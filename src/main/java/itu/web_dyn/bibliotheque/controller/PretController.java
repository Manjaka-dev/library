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
import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.service.AdherantService;
import itu.web_dyn.bibliotheque.service.AdminService;
import itu.web_dyn.bibliotheque.service.ExemplaireService;
import itu.web_dyn.bibliotheque.service.LivreService;
import itu.web_dyn.bibliotheque.service.PenaliteService;
import itu.web_dyn.bibliotheque.service.PretService;
import itu.web_dyn.bibliotheque.service.QuotaTypePretService;
import itu.web_dyn.bibliotheque.service.TypePretService;
import itu.web_dyn.bibliotheque.service.UtilService;

@Controller
@RequestMapping("/prets")
public class PretController {

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
    private AdminService adminService; 
    @Autowired
    private PenaliteService penaliteService;

    private void preparePretPage(Model model) {
        model.addAttribute("livres", livreService.findAll());
        model.addAttribute("adherants", adherantService.findAll());
        model.addAttribute("typesPret", typePretService.findAll());
    }

    // Formulaire de nouveau prêt
    @GetMapping("/new")
    public String nouveauPret(Model model) {
        preparePretPage(model);
        return "pret/form";
    }

    // Liste des prêts
    @GetMapping
    public String listPrets(Model model) {
        List<Pret> prets = pretService.findAll();
        model.addAttribute("prets", prets);
        return "pret/list";
    }

    // Traitement du formulaire de prêt
    @PostMapping("/save")
    public String creerPret(@RequestParam("adherantId") int adherantId,
                           @RequestParam("typePret") int typePretId,  
                           @RequestParam("livre") int livreId,
                           @RequestParam("dateFin") LocalDate dateFin, Model model) {
        Adherant adherant = adherantService.findById(adherantId);
        Livre livre = livreService.findById(livreId);
        List<Exemplaire> exemplaires = livreService.findAllExemplaireByIdLivre(livre.getIdLivre());
        Exemplaire exemplaireOpt = null;

        if (adherant.getIdAdherant() == null) {
            model.addAttribute("message", "Adhérant inexistant.");
            preparePretPage(model);
            return "pret/form";
        }

        // 2. L'adhérant doit être inscrit (à adapter selon ta logique d'inscription)
        boolean inscrit = adherantService.isActif(adherant.getIdAdherant(), LocalDateTime.now());
        if (inscrit == false) {
            model.addAttribute("message", "Adhérant non inscrit ou inscription inactive.");
            preparePretPage(model);
            return "pret/form";
        }

        for (Exemplaire exemplaire : exemplaires) {
            // 3. Le numéro de l'exemplaire doit exister
            exemplaireOpt = exemplaireService.findById(exemplaire.getIdExemplaire());
            if (exemplaireOpt.getIdExemplaire() == null) {
                model.addAttribute("message", "Exemplaire n°" + exemplaire.getIdExemplaire() + " inexistant.");
                preparePretPage(model);
                return "pret/form";
            }

            // 4. L'exemplaire doit être disponible (pas déjà prêté)
            Boolean disponible = exemplaireService.isExemplaireDisponible(exemplaire.getIdExemplaire(), LocalDateTime.now(), UtilService.toDateTimeWithCurrentTime(dateFin));
            if (!disponible) {
                model.addAttribute("message", "Exemplaire n°" + exemplaire.getIdExemplaire() + " non disponible.");
                preparePretPage(model);
                return "pret/form";
            }
        }

        // 5. Vérifier si l'adhérant n'est pas pénalisé
        boolean penalise = penaliteService.isPenalise(LocalDateTime.now(),adherant.getIdAdherant()); 
        if (penalise) {
            model.addAttribute("message", "Adhérant pénalisé, prêt impossible.");
            preparePretPage(model);
            return "pret/form";
        }

        // 6. Vérifier que l'adhérant ne dépasse pas le quota pour le type de prêt
        boolean depasseQuota = quotaTypePretService.adherantDepasseQuota(
            adherant.getIdAdherant(),
            adherant.getProfil().getIdProfil(),
            typePretId
        ); 

        if (depasseQuota) {
            model.addAttribute("message", "Quota de prêt dépassé." + depasseQuota);
            preparePretPage(model);
            return "pret/form";
        }

        // 7. L'adhérant peut-il prêter ce livre (ex: restrictions sur certains livres)
        Boolean peutPreter = livreService.peutPreterLivre(adherant, livre);

        if (!peutPreter) {
            model.addAttribute("message", "Vous ne pouvez pas emprunter ce livre a cause de votre age ou du type de votre profil");
            preparePretPage(model);
            return "pret/form";
        }

        Pret pret = new Pret(
            LocalDateTime.now(), // Date de début du prêt
            adminService.findById(1), // Admin (à définir selon votre logique, peut-être l'admin connecté)
            typePretService.findById(typePretId), // Type de prêt
            exemplaireOpt, // Exemplaire (le dernier exemplaire vérifié)
            adherant // Adhérant
        );
        

        if (exemplaireOpt != null) {
            pretService.save(pret);
            model.addAttribute("message", "Prêt validé et inséré");
        }

        preparePretPage(model);
        
        // Redirection vers la page de confirmation ou d'accueil après le prêt
        return "pret/form";
    }

    // Détails d'un prêt
    @GetMapping("/view/{id}")
    public String viewPret(@PathVariable Integer id, Model model) {
        Pret pret = pretService.findById(id);
        if (pret != null) {
            model.addAttribute("pret", pret);
            return "pret/view";
        }
        return "redirect:/prets";
    }

    // Formulaire d'édition d'un prêt
    @GetMapping("/edit/{id}")
    public String editPret(@PathVariable Integer id, Model model) {
        Pret pret = pretService.findById(id);
        if (pret != null) {
            model.addAttribute("pret", pret);
            preparePretPage(model);
            return "pret/form";
        }
        return "redirect:/prets";
    }

    // Suppression d'un prêt
    @GetMapping("/delete/{id}")
    public String deletePret(@PathVariable Integer id) {
        pretService.deleteById(id);
        return "redirect:/prets";
    }
}