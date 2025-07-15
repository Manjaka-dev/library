package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import itu.web_dyn.bibliotheque.service.JourFerierService;

@Controller
public class TestController {
    
    @Autowired
    private JourFerierService jourFerierService;
    
    @GetMapping("/test-penalites")
    public String testPenalites() {
        return "test-penalites";
    }
    
    @GetMapping("/test-api-livres")
    public String testApiLivres() {
        return "test-api-livres";
    }
    
    @PostMapping("/test-jours-ouvrables")
    public String testJoursOuvrables(@RequestParam String dateDebut, 
                                   @RequestParam String dateFin, 
                                   Model model) {
        try {
            LocalDate debut = LocalDate.parse(dateDebut);
            LocalDate fin = LocalDate.parse(dateFin);
            
            // Calculer les jours ouvrables
            long joursOuvrables = jourFerierService.calculerJoursOuvrables(debut, fin);
            
            // Calculer les jours calendaires pour comparaison
            long joursCalendaires = java.time.temporal.ChronoUnit.DAYS.between(debut, fin);
            
            // Formater les dates pour l'affichage
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String debutFormate = debut.format(formatter);
            String finFormate = fin.format(formatter);
            
            model.addAttribute("dateDebut", debutFormate);
            model.addAttribute("dateFin", finFormate);
            model.addAttribute("joursOuvrables", joursOuvrables);
            model.addAttribute("joursCalendaires", joursCalendaires);
            model.addAttribute("difference", joursCalendaires - joursOuvrables);
            model.addAttribute("calculEffectue", true);
            
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur lors du calcul : " + e.getMessage());
        }
        
        return "test-penalites";
    }
}
