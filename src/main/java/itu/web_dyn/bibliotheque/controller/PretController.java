package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDateTime;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Admin;
import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.service.AdherantService;
import itu.web_dyn.bibliotheque.service.ExemplaireService;
import itu.web_dyn.bibliotheque.service.FinPretService;
import itu.web_dyn.bibliotheque.service.LivreService;
import itu.web_dyn.bibliotheque.service.PenaliteService;
import itu.web_dyn.bibliotheque.service.PretService;
import itu.web_dyn.bibliotheque.service.QuotaTypePretService;
import itu.web_dyn.bibliotheque.service.TypePretService;
import itu.web_dyn.bibliotheque.service.UtilService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/prets")
public class PretController {

    // @PostConstruct
    // public void forceStdOutToConsole() {
    //     System.setOut(new PrintStream(new FileOutputStream(FileDescriptor.out)));
    //     System.setErr(new PrintStream(new FileOutputStream(FileDescriptor.err)));
    // }

    // private static final Logger logger = LoggerFactory.getLogger(PretController.class);

    @Autowired
    private LivreService livreService;

    @Autowired
    private ExemplaireService exemplaireService;

    @Autowired
    private AdherantService adherantService;

    @Autowired
    private QuotaTypePretService quotaTypePretService;

    @Autowired 
    private TypePretService typePretService; 

    @Autowired
    private PretService pretService;

    @Autowired
    private PenaliteService penaliteService;

    @Autowired
    private FinPretService finPretService;

    private void preparePretPage(Model model) {
        model.addAttribute("livres", livreService.findAll());
        model.addAttribute("adherants", adherantService.findAll());
        model.addAttribute("typesPret", typePretService.findAll());
    }

    // Formulaire de nouveau prêt
    @GetMapping("/new")
    public String newPret(Model model, HttpSession session) {
        // Vérifier les autorisations
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/prets?error=access-denied";
        }
        
        preparePretPage(model);
        return "pret/form";
    }

    @GetMapping("/preter")
    public String preter(Model model) {

        preparePretPage(model);

        return "pret";
    }

    @PostMapping("/preter")
    public String preterLivre(@RequestParam("adherantId") int adherantId,
                              @RequestParam("typePret") int typePretId,  
                              @RequestParam("livre") int livreId,
                              @RequestParam("dateFin") LocalDate dateFin, 
                              HttpSession session,
                              Model model) {

        Adherant adherant = adherantService.findById(adherantId);
        Livre livre = livreService.findById(livreId);
        List<Exemplaire> exemplaires = exemplaireService.findAllExemplaireByIdLivre(livre.getIdLivre());
        
        Exemplaire exemplaireOpt = null;

        if (adherant.getIdAdherant() == null) {
            model.addAttribute("message", "Adhérant inexistant.");
            
            preparePretPage(model);

            return "pret";
        }

        // 2. L'adhérant doit être inscrit (à adapter selon ta logique d'inscription)
        System.out.println("--------- CHECK IF ADHERANT IS ACTIF -----------------");
        boolean inscrit = adherantService.isActif(adherant.getIdAdherant(), LocalDateTime.now());
        if (inscrit == false) {
            model.addAttribute("message", "Adhérant non inscrit ou inscription inactive.");

            preparePretPage(model);


            return "pret";
        }

        System.out.println("----------------- LOOP FOR EXEMPLAIRE");
        for (Exemplaire exemplaire : exemplaires) {
            // 3. Le numéro de l'exemplaire doit exister
            if (exemplaireService.isExemplaireDisponible(exemplaire.getIdExemplaire(), LocalDateTime.now(), UtilService.toDateTimeWithCurrentTime(dateFin))) {
                exemplaireOpt = exemplaire;
                break;
            }
        }


        if (exemplaireOpt == null) {
            model.addAttribute("message", "Il n'y a plus d'exemplaire disponible.");
            preparePretPage(model);
            return "pret";
        }

        // 5. Vérifier si l'adhérant n'est pas pénalisé
        System.out.println("----------------- CHECK IF ADHERANT IS PENALISED -----------------------------");
        boolean penalise = penaliteService.isPenalise(LocalDateTime.now(),adherant.getIdAdherant()); 
        if (penalise) {
            model.addAttribute("message", "Adhérant pénalisé, prêt impossible.");
            preparePretPage(model);

            return "pret";
        }

        // 6. Vérifier que l'adhérant ne dépasse pas le quota pour le type de prêt
        System.out.println("----------------- CHECK IF ADHERANT HAS MORE PRET THAN QUOTA  -----------------------------");
        boolean depasseQuota = quotaTypePretService.adherantDepasseQuota(
            adherant.getIdAdherant(),
            adherant.getProfil().getIdProfil(),
            typePretId
        ); 

        if (depasseQuota) {
            model.addAttribute("message", "Quota de prêt dépassé.");
            preparePretPage(model);
            
            return "pret";
        }


        // 7. L'adhérant peut-il prêter ce livre (ex: restrictions sur certains livres)
        System.out.println("----------------- CHECK IF ADHERANT CAN PRETER THE BOOK -----------------------------");

        Boolean peutPreter = livreService.peutPreterLivre(adherant, livre);

        if (!peutPreter) {
            model.addAttribute("message", "Vous ne pouvez pas emprunter ce livre a cause de votre age ou du type de votre profil");
            preparePretPage(model);
            return "pret";
        }

        Admin admin = (Admin) session.getAttribute("admin");

        // Pret pret = new Pret(
        //     LocalDateTime.now(), // Date de début du prêt
        //     admin, // Admin (à définir selon votre logique, peut-être l'admin connecté)
        //     typePretService.findById(typePretId), // Type de prêt
        //     exemplaireOpt, // Exemplaire (le dernier exemplaire vérifié)
        //     adherant // Adhérant
        // );
        Pret pret = new Pret();
        pret.setAdherant(adherant);
        pret.setAdmin(admin);
        pret.setDateDebut(LocalDateTime.now());
        pret.setExemplaire(exemplaireOpt);
        pret.setTypePret(typePretService.findById(typePretId));


        FinPret finPret = new FinPret(UtilService.toDateTimeWithCurrentTime(dateFin), pret);
        
        if (exemplaireOpt != null) {
            System.out.println("----------------- SAVE PRET -----------------------------");

            pretService.save(pret);
            finPretService.save(finPret);
            model.addAttribute("success", "Prêt validé et inséré");
        }

        preparePretPage(model);
        
        
        // Redirection vers la page de confirmation ou d'accueil après le prêt
        return "pret";
        
    }

    // Voir les détails d'un prêt
    @GetMapping("/view/{id}")
    public String viewPret(@PathVariable("id") Integer id, Model model, HttpSession session) {
        // Récupérer le type d'utilisateur depuis la session
        String userType = (String) session.getAttribute("userType");
        model.addAttribute("userType", userType);
        
        // Récupérer le prêt
        Pret pret = pretService.findById(id);
        if (pret == null) {
            return "redirect:/prets";
        }
        
        // Vérifier les autorisations
        if ("admin".equals(userType)) {
            // Admin peut voir tous les prêts
            model.addAttribute("pret", pret);
            return "pret/view";
        } else if ("adherant".equals(userType)) {
            // Adhérent ne peut voir que ses propres prêts
            Adherant adherant = (Adherant) session.getAttribute("user");
            if (adherant != null && pret.getAdherant().getIdAdherant().equals(adherant.getIdAdherant())) {
                model.addAttribute("pret", pret);
                return "pret/view";
            }
        }
        
        // Rediriger vers la liste des prêts si pas d'autorisation
        return "redirect:/prets";
    }

    // Modifier un prêt (formulaire)
    @GetMapping("/edit/{id}")
    public String editPretForm(@PathVariable("id") Integer id, Model model, HttpSession session) {
        // Seuls les admins peuvent modifier les prêts
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/prets";
        }
        
        Pret pret = pretService.findById(id);
        if (pret == null) {
            return "redirect:/prets";
        }
        
        model.addAttribute("pret", pret);
        model.addAttribute("userType", userType);
        return "pret/edit";
    }

    // Supprimer un prêt
    @GetMapping("/delete/{id}")
    public String deletePret(@PathVariable("id") Integer id, HttpSession session) {
        // Seuls les admins peuvent supprimer les prêts
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/prets";
        }
        
        Pret pret = pretService.findById(id);
        if (pret != null) {
            pretService.deleteById(id);
        }
        
        return "redirect:/prets";
    }

    // Liste des prêts
    @GetMapping
    public String listPrets(Model model, HttpSession session) {
        // Récupérer le type d'utilisateur depuis la session
        String userType = (String) session.getAttribute("userType");
        model.addAttribute("userType", userType);
        
        if ("admin".equals(userType)) {
            // Admin peut voir tous les prêts
            List<Pret> prets = pretService.findAll();
            model.addAttribute("prets", prets);
            return "pret/list";
        } else if ("adherant".equals(userType)) {
            // Adhérent ne peut voir que ses propres prêts
            Adherant adherant = (Adherant) session.getAttribute("user");
            if (adherant != null) {
                List<Pret> prets = pretService.findByAdherant(adherant);
                model.addAttribute("prets", prets);
                return "pret/list";
            }
        }
        
        // Rediriger vers la page d'accueil si pas d'autorisation
        return "redirect:/";
    }

}