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

import itu.web_dyn.bibliotheque.entities.Auteur;
import itu.web_dyn.bibliotheque.repository.AuteurRepository;

@Controller
@RequestMapping("/auteurs")
public class AuteurController {

    @Autowired
    private AuteurRepository auteurRepository;

    // Liste des auteurs
    @GetMapping
    public String listAuteurs(Model model) {
        List<Auteur> auteurs = auteurRepository.findAll();
        model.addAttribute("auteurs", auteurs);
        return "auteur/list";
    }

    // Formulaire d'ajout
    @GetMapping("/new")
    public String newAuteur(Model model) {
        model.addAttribute("auteur", new Auteur());
        return "auteur/form";
    }

    // Sauvegarde
    @PostMapping("/save")
    public String saveAuteur(@ModelAttribute Auteur auteur) {
        auteurRepository.save(auteur);
        return "redirect:/auteurs";
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String editAuteur(@PathVariable Integer id, Model model) {
        Auteur auteur = auteurRepository.findById(id).orElse(null);
        if (auteur != null) {
            model.addAttribute("auteur", auteur);
            return "auteur/form";
        }
        return "redirect:/auteurs";
    }

    // Suppression
    @GetMapping("/delete/{id}")
    public String deleteAuteur(@PathVariable Integer id) {
        auteurRepository.deleteById(id);
        return "redirect:/auteurs";
    }

    // Détails
    @GetMapping("/view/{id}")
    public String viewAuteur(@PathVariable Integer id, Model model) {
        Auteur auteur = auteurRepository.findById(id).orElse(null);
        if (auteur != null) {
            model.addAttribute("auteur", auteur);
            return "auteur/view";
        }
        return "redirect:/auteurs";
    }
}
