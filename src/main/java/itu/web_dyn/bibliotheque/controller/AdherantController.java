package itu.web_dyn.bibliotheque.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.repository.AdherantRepository;
import itu.web_dyn.bibliotheque.repository.ProfilRepository;

@Controller
@RequestMapping("/adherants")
public class AdherantController {

    @Autowired
    private AdherantRepository adherantRepository;
    
    @Autowired
    private ProfilRepository profilRepository;

    // Liste des adhérents
    @GetMapping
    public String listAdherants(Model model) {
        List<Adherant> adherants = adherantRepository.findAll();
        model.addAttribute("adherants", adherants);
        return "adherant/list";
    }

    // Formulaire d'ajout
    @GetMapping("/new")
    public String newAdherant(Model model) {
        model.addAttribute("adherant", new Adherant());
        model.addAttribute("profils", profilRepository.findAll());
        return "adherant/form";
    }

    // Sauvegarde
    @PostMapping("/save")
    public String saveAdherant(@ModelAttribute Adherant adherant) {
        adherantRepository.save(adherant);
        return "redirect:/adherants";
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String editAdherant(@PathVariable Integer id, Model model) {
        Adherant adherant = adherantRepository.findById(id).orElse(null);
        if (adherant != null) {
            model.addAttribute("adherant", adherant);
            model.addAttribute("profils", profilRepository.findAll());
            return "adherant/form";
        }
        return "redirect:/adherants";
    }

    // Suppression
    @GetMapping("/delete/{id}")
    public String deleteAdherant(@PathVariable Integer id) {
        adherantRepository.deleteById(id);
        return "redirect:/adherants";
    }

    // Détails
    @GetMapping("/view/{id}")
    public String viewAdherant(@PathVariable Integer id, Model model) {
        Adherant adherant = adherantRepository.findById(id).orElse(null);
        if (adherant != null) {
            model.addAttribute("adherant", adherant);
            return "adherant/view";
        }
        return "redirect:/adherants";
    }
}
