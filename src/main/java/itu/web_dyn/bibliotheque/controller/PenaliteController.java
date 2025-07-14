package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import itu.web_dyn.bibliotheque.entities.Penalite;
import itu.web_dyn.bibliotheque.service.AdherantService;
import itu.web_dyn.bibliotheque.service.PenaliteService;
import itu.web_dyn.bibliotheque.service.PretService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/penalites")
public class PenaliteController {

    @Autowired
    private PenaliteService penaliteService;

    @Autowired
    private AdherantService adherantService;

    @Autowired
    private PretService pretService;

    // Liste des pénalités
    @GetMapping
    public String listPenalites(Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        List<Penalite> penalites = penaliteService.findAll();
        model.addAttribute("penalites", penalites);
        return "penalite/list";
    }

    // Détails d'une pénalité
    @GetMapping("/view/{id}")
    public String viewPenalite(@PathVariable Integer id, Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        Penalite penalite = penaliteService.findById(id).orElse(null);
        if (penalite != null) {
            model.addAttribute("penalite", penalite);
            return "penalite/view";
        }
        return "redirect:/penalites";
    }

    // Calculer pénalité pour un prêt
    @PostMapping("/calculer")
    public String calculerPenalite(@RequestParam Integer idPret, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        try {
            penaliteService.calculPenalite(idPret);
            return "redirect:/penalites?success=penalite-calculee";
        } catch (Exception e) {
            return "redirect:/penalites?error=" + e.getMessage();
        }
    }

    // Vérifier si un adhérent est pénalisé (API)
    @GetMapping("/check/{idAdherant}")
    @ResponseBody
    public boolean isPenalise(@PathVariable Integer idAdherant) {
        return penaliteService.isPenalise(LocalDateTime.now(), idAdherant);
    }

    // Supprimer une pénalité
    @GetMapping("/delete/{id}")
    public String deletePenalite(@PathVariable Integer id, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        penaliteService.deleteById(id);
        return "redirect:/penalites";
    }

    // Pénalités d'un adhérent
    @GetMapping("/adherant/{idAdherant}")
    public String penalitesAdherant(@PathVariable Integer idAdherant, Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/login";
        }
        
        List<Penalite> penalites = penaliteService.findByAdherantId(idAdherant);
        model.addAttribute("penalites", penalites);
        model.addAttribute("adherant", adherantService.findById(idAdherant));
        return "penalite/adherant";
    }
}
