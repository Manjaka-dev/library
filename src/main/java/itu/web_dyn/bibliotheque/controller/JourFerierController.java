package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import itu.web_dyn.bibliotheque.entities.JourFerier;
import itu.web_dyn.bibliotheque.service.JourFerierService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/jours-ferier")
public class JourFerierController {

    @Autowired
    private JourFerierService jourFerierService;

    // Liste des jours fériés
    @GetMapping
    public String listJoursFerier(Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        List<JourFerier> joursFerier = jourFerierService.findAll();
        model.addAttribute("joursFerier", joursFerier);
        return "jour-ferier/list";
    }

    // Formulaire de nouveau jour férié
    @GetMapping("/new")
    public String newJourFerier(Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        model.addAttribute("jourFerier", new JourFerier());
        return "jour-ferier/form";
    }

    // Sauvegarde d'un jour férié
    @PostMapping("/save")
    public String saveJourFerier(@ModelAttribute JourFerier jourFerier, HttpSession session, Model model) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        try {
            jourFerierService.save(jourFerier);
            return "redirect:/jours-ferier?success=jour-ferier-cree";
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la sauvegarde: " + e.getMessage());
            model.addAttribute("jourFerier", jourFerier);
            return "jour-ferier/form";
        }
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String editJourFerier(@PathVariable Integer id, Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        JourFerier jourFerier = jourFerierService.findById(id);
        if (jourFerier != null) {
            model.addAttribute("jourFerier", jourFerier);
            return "jour-ferier/form";
        }
        return "redirect:/jours-ferier";
    }

    // Suppression d'un jour férié
    @GetMapping("/delete/{id}")
    public String deleteJourFerier(@PathVariable Integer id, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        jourFerierService.deleteById(id);
        return "redirect:/jours-ferier";
    }

    // Vérifier si une date est un jour férié
    @GetMapping("/check")
    public String checkJourFerier(@RequestParam("date") LocalDate date, Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        boolean isJourFerier = jourFerierService.isJourFerier(date);
        boolean isWeekend = jourFerierService.isWeekend(date);
        boolean isJourNonOuvrable = jourFerierService.isJourNonOuvrable(date);
        
        model.addAttribute("date", date);
        model.addAttribute("isJourFerier", isJourFerier);
        model.addAttribute("isWeekend", isWeekend);
        model.addAttribute("isJourNonOuvrable", isJourNonOuvrable);
        
        return "jour-ferier/check";
    }

    // Calcul des jours ouvrables
    @GetMapping("/calcul-jours-ouvrables")
    public String calculJoursOuvrables(@RequestParam("dateDebut") LocalDate dateDebut, 
                                      @RequestParam("dateFin") LocalDate dateFin, 
                                      Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        long joursOuvrables = jourFerierService.calculerJoursOuvrables(dateDebut, dateFin);
        
        model.addAttribute("dateDebut", dateDebut);
        model.addAttribute("dateFin", dateFin);
        model.addAttribute("joursOuvrables", joursOuvrables);
        
        return "jour-ferier/calcul";
    }
}
