package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import itu.web_dyn.bibliotheque.entities.Retour;
import itu.web_dyn.bibliotheque.service.PenaliteService;
import itu.web_dyn.bibliotheque.service.PretService;
import itu.web_dyn.bibliotheque.service.RetourService;
import itu.web_dyn.bibliotheque.service.TypeRetourService;

@Controller
@RequestMapping("/retours")
public class RetourController {

    @Autowired
    private RetourService retourService;

    @Autowired
    private PretService pretService;

    @Autowired
    private TypeRetourService typeRetourService;

    @Autowired
    private PenaliteService penaliteService;

    // Liste des retours
    @GetMapping
    public String listRetours(Model model) {
        List<Retour> retours = retourService.findAll();
        model.addAttribute("retours", retours);
        return "retour/list";
    }

    // Formulaire de nouveau retour
    @GetMapping("/new")
    public String newRetour(Model model) {
        model.addAttribute("retour", new Retour());
        model.addAttribute("prets", pretService.findAll());
        model.addAttribute("typesRetour", typeRetourService.findAll());
        return "retour/form";
    }

    // Sauvegarde d'un retour
    @PostMapping("/save")
    public String saveRetour(@ModelAttribute Retour retour, Model model) {
        try {
            if (retour.getDateRetour() == null) {
                retour.setDateRetour(LocalDateTime.now());
            }
            
            // Sauvegarder le retour
            retourService.save(retour);
            
            // Calculer automatiquement les pénalités en jours ouvrables
            if (retour.getPret() != null) {
                try {
                    // Utiliser le calcul en jours ouvrables (true) ou jours calendaires (false)
                    penaliteService.calculPenaliteAvecJoursOuvrables(retour.getPret().getIdPret(), true);
                } catch (Exception e) {
                    System.err.println("Erreur lors du calcul de pénalité: " + e.getMessage());
                    // On continue même si le calcul de pénalité échoue
                }
            }
            
            return "redirect:/retours";
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la sauvegarde: " + e.getMessage());
            model.addAttribute("retour", retour);
            model.addAttribute("prets", pretService.findAll());
            model.addAttribute("typesRetour", typeRetourService.findAll());
            return "retour/form";
        }
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String editRetour(@PathVariable Integer id, Model model) {
        Retour retour = retourService.findById(id);
        if (retour != null) {
            model.addAttribute("retour", retour);
            model.addAttribute("prets", pretService.findAll());
            model.addAttribute("typesRetour", typeRetourService.findAll());
            return "retour/form";
        }
        return "redirect:/retours";
    }

    // Détails d'un retour
    @GetMapping("/view/{id}")
    public String viewRetour(@PathVariable Integer id, Model model) {
        Retour retour = retourService.findById(id);
        if (retour != null) {
            model.addAttribute("retour", retour);
            return "retour/view";
        }
        return "redirect:/retours";
    }

    // Suppression d'un retour
    @GetMapping("/delete/{id}")
    public String deleteRetour(@PathVariable Integer id) {
        retourService.deleteById(id);
        return "redirect:/retours";
    }
}
