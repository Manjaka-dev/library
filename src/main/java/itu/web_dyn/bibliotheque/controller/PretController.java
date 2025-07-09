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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.repository.DureePretRepository;
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
    @Autowired
    private DureePretRepository dureePretRepository;

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
    public String creerPret(
            @RequestParam("adherent") int adherantId,
            @RequestParam("livre") int id_livre,
            @RequestParam("dateFin") LocalDate dateFinLocal,
            @RequestParam("dateDeb") LocalDate dateDebutLocal,
            Model model,
            RedirectAttributes redirectAttributes) {
        LocalDateTime dateTimeDebut = UtilService.toDateTimeWithCurrentTime(dateDebutLocal);
        LocalDateTime dateTimeFin = UtilService.toDateTimeWithCurrentTime(dateFinLocal);
        Adherant adherant = adherantService.getAdherantByNumero(adherantId);
        if (adherant == null) {
            model.addAttribute("error", "Adhérant inexistant.");
            return "redirect:/preter";
        }

        boolean pretEffectue = livreService.preterLivre(id_livre, adherant, dateTimeDebut, dateTimeFin);

        if (pretEffectue) {
            redirectAttributes.addFlashAttribute("success", "Prêt enregistré avec succès !");
        } else {
            redirectAttributes.addFlashAttribute("error", "Aucun exemplaire disponible pour cette période.");
        }

        return "redirect:/preter";
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