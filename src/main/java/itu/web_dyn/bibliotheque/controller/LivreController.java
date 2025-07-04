package itu.web_dyn.bibliotheque.controller;

import java.util.HashSet;
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

import itu.web_dyn.bibliotheque.entities.Categorie;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.repository.AuteurRepository;
import itu.web_dyn.bibliotheque.repository.CategorieRepository;
import itu.web_dyn.bibliotheque.repository.EditeurRepository;
import itu.web_dyn.bibliotheque.repository.LivreRepository;
import itu.web_dyn.bibliotheque.service.CategorieService;
import itu.web_dyn.bibliotheque.service.LivreService;

@Controller
@RequestMapping("/livres")
public class LivreController {

    @Autowired
    private LivreRepository livreRepository;
    
    @Autowired
    private AuteurRepository auteurRepository;
    
    @Autowired
    private EditeurRepository editeurRepository;
    
    @Autowired
    private CategorieRepository categorieRepository;

    @Autowired
    private LivreService livreService;

    @Autowired
    private CategorieService categorieService;

    // Liste des livres
    @GetMapping
    public String listLivres(Model model) {
        List<Livre> livres = livreRepository.findAll();
        model.addAttribute("livres", livres);
        return "livre/list";
    }

    // Formulaire d'ajout
    @GetMapping("/new")
    public String newLivre(Model model) {
        model.addAttribute("livre", new Livre());
        model.addAttribute("auteurs", auteurRepository.findAll());
        model.addAttribute("editeurs", editeurRepository.findAll());
        model.addAttribute("categories", categorieRepository.findAll());
        return "livre/form";
    }

    // Sauvegarde
    @PostMapping("/save")
    public String saveLivre(@ModelAttribute Livre livre, 
                           @RequestParam(value = "categorieIds", required = false) List<Integer> categorieIds) {
        // Gestion des catégories Many-to-Many
        if (categorieIds != null && !categorieIds.isEmpty()) {
            livre.setCategories(new HashSet<>());
            for (Integer categorieId : categorieIds) {
                Categorie categorie = categorieRepository.findById(categorieId).orElse(null);
                if (categorie != null) {
                    livre.getCategories().add(categorie);
                }
            }
        }
        
        livreRepository.save(livre);
        return "redirect:/livres";
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String editLivre(@PathVariable Integer id, Model model) {
        Livre livre = livreRepository.findById(id).orElse(null);
        if (livre != null) {
            model.addAttribute("livre", livre);
            model.addAttribute("auteurs", auteurRepository.findAll());
            model.addAttribute("editeurs", editeurRepository.findAll());
            model.addAttribute("categories", categorieRepository.findAll());
            return "livre/form";
        }
        return "redirect:/livres";
    }

    // Suppression
    @GetMapping("/delete/{id}")
    public String deleteLivre(@PathVariable Integer id) {
        livreRepository.deleteById(id);
        return "redirect:/livres";
    }

    // Détails
    @GetMapping("/view/{id}")
    public String viewLivre(@PathVariable Integer id, Model model) {
        Livre livre = livreRepository.findById(id).orElse(null);
        if (livre != null) {
            model.addAttribute("livre", livre);
            return "livre/view";
        }
        return "redirect:/livres";
    }

    @GetMapping("/list")
    public String livres(Model model) {
        List<Livre> livres = livreService.findAll();
        List<Categorie> categories = categorieService.findAll();
        
        model.addAttribute("livres", livres);
        model.addAttribute("categories", categories);

        return "listLivre"; // Redirection vers la page des livres
    }

    @GetMapping("/detail")
    public String detailLivre(Model model, Integer id) {
        Livre livre = livreService.findById(id);
        if (livre == null) {
            return "redirect:/livre/"; // Redirection si le livre n'existe pas
        }
        
        model.addAttribute("livre", livre);
        return "detailLivre"; // Redirection vers la page de détail du livre
    }
}
