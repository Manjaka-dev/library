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

import itu.web_dyn.bibliotheque.entities.Editeur;
import itu.web_dyn.bibliotheque.repository.EditeurRepository;

@Controller
@RequestMapping("/editeurs")
public class EditeurController {

    @Autowired
    private EditeurRepository editeurRepository;

    // Liste des éditeurs
    @GetMapping
    public String listEditeurs(Model model) {
        List<Editeur> editeurs = editeurRepository.findAll();
        model.addAttribute("editeurs", editeurs);
        return "editeur/list";
    }

    // Formulaire d'ajout
    @GetMapping("/new")
    public String newEditeur(Model model) {
        model.addAttribute("editeur", new Editeur());
        return "editeur/form";
    }

    // Sauvegarde
    @PostMapping("/save")
    public String saveEditeur(@ModelAttribute Editeur editeur) {
        editeurRepository.save(editeur);
        return "redirect:/editeurs";
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String editEditeur(@PathVariable Integer id, Model model) {
        Editeur editeur = editeurRepository.findById(id).orElse(null);
        if (editeur != null) {
            model.addAttribute("editeur", editeur);
            return "editeur/form";
        }
        return "redirect:/editeurs";
    }

    // Suppression
    @GetMapping("/delete/{id}")
    public String deleteEditeur(@PathVariable Integer id) {
        editeurRepository.deleteById(id);
        return "redirect:/editeurs";
    }

    // Détails
    @GetMapping("/view/{id}")
    public String viewEditeur(@PathVariable Integer id, Model model) {
        Editeur editeur = editeurRepository.findById(id).orElse(null);
        if (editeur != null) {
            model.addAttribute("editeur", editeur);
            return "editeur/view";
        }
        return "redirect:/editeurs";
    }
}
