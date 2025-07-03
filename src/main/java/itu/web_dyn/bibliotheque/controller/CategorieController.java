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

import itu.web_dyn.bibliotheque.entities.Categorie;
import itu.web_dyn.bibliotheque.repository.CategorieRepository;

@Controller
@RequestMapping("/categories")
public class CategorieController {

    @Autowired
    private CategorieRepository categorieRepository;

    // Liste des catégories
    @GetMapping
    public String listCategories(Model model) {
        List<Categorie> categories = categorieRepository.findAll();
        model.addAttribute("categories", categories);
        return "categorie/list";
    }

    // Formulaire d'ajout
    @GetMapping("/new")
    public String newCategorie(Model model) {
        model.addAttribute("categorie", new Categorie());
        return "categorie/form";
    }

    // Sauvegarde
    @PostMapping("/save")
    public String saveCategorie(@ModelAttribute Categorie categorie) {
        categorieRepository.save(categorie);
        return "redirect:/categories";
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String editCategorie(@PathVariable Integer id, Model model) {
        Categorie categorie = categorieRepository.findById(id).orElse(null);
        if (categorie != null) {
            model.addAttribute("categorie", categorie);
            return "categorie/form";
        }
        return "redirect:/categories";
    }

    // Suppression
    @GetMapping("/delete/{id}")
    public String deleteCategorie(@PathVariable Integer id) {
        categorieRepository.deleteById(id);
        return "redirect:/categories";
    }

    // Détails
    @GetMapping("/view/{id}")
    public String viewCategorie(@PathVariable Integer id, Model model) {
        Categorie categorie = categorieRepository.findById(id).orElse(null);
        if (categorie != null) {
            model.addAttribute("categorie", categorie);
            return "categorie/view";
        }
        return "redirect:/categories";
    }
}
