package itu.web_dyn.bibliotheque.controller;

import java.util.HashSet;
import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Categorie;
import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.repository.AuteurRepository;
import itu.web_dyn.bibliotheque.repository.CategorieRepository;
import itu.web_dyn.bibliotheque.repository.EditeurRepository;
import itu.web_dyn.bibliotheque.repository.ExemplaireRepository;
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
    private ExemplaireRepository exemplaireRepository;

    @Autowired
    private LivreService livreService;

    @Autowired
    private CategorieService categorieService;

    // Liste des livres
    @GetMapping
    public String listLivres(Model model, HttpSession session) {
        List<Livre> livres = livreRepository.findAll();
        model.addAttribute("livres", livres);
        
        // Ajouter le type d'utilisateur pour la vue
        String userType = (String) session.getAttribute("userType");
        model.addAttribute("userType", userType);
        
        return "livre/list";
    }

    // Formulaire d'ajout - ADMIN UNIQUEMENT
    @GetMapping("/new")
    public String newLivre(Model model, HttpSession session) {
        // Vérifier que l'utilisateur est admin
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/livres?error=access-denied";
        }
        
        model.addAttribute("livre", new Livre());
        model.addAttribute("auteurs", auteurRepository.findAll());
        model.addAttribute("editeurs", editeurRepository.findAll());
        model.addAttribute("categories", categorieRepository.findAll());
        return "livre/form";
    }

    // Sauvegarde - ADMIN UNIQUEMENT
    @PostMapping("/save")
    public String saveLivre(@ModelAttribute Livre livre, 
                           @RequestParam(value = "categorieIds", required = false) List<Integer> categorieIds,
                           HttpSession session) {
        // Vérifier que l'utilisateur est admin
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/livres?error=access-denied";
        }
        
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

    // Formulaire d'édition - ADMIN UNIQUEMENT
    @GetMapping("/edit/{id}")
    public String editLivre(@PathVariable Integer id, Model model, HttpSession session) {
        // Vérifier que l'utilisateur est admin
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/livres?error=access-denied";
        }
        
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

    // Suppression - ADMIN UNIQUEMENT
    @GetMapping("/delete/{id}")
    public String deleteLivre(@PathVariable Integer id, HttpSession session) {
        // Vérifier que l'utilisateur est admin
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/livres?error=access-denied";
        }
        
        livreRepository.deleteById(id);
        return "redirect:/livres";
    }

    // Détails d'un livre avec gestion des permissions
    @GetMapping("/view/{id}")
    public String viewLivre(@PathVariable Integer id, Model model, HttpSession session) {
        Livre livre = livreRepository.findById(id).orElse(null);
        if (livre != null) {
            model.addAttribute("livre", livre);
            
            // Récupérer les exemplaires de ce livre
            List<Exemplaire> exemplaires = exemplaireRepository.findByLivreIdLivre(id);
            model.addAttribute("exemplaires", exemplaires);
            model.addAttribute("nbExemplaires", exemplaires.size());
            
            // Récupérer le type d'utilisateur depuis la session
            String userType = (String) session.getAttribute("userType");
            model.addAttribute("userType", userType);
            
            // Si c'est un adhérent, vérifier s'il peut emprunter ce livre
            if ("adherant".equals(userType)) {
                Adherant adherant = (Adherant) session.getAttribute("user");
                if (adherant != null) {
                    boolean peutPreter = livreService.peutPreterLivre(adherant, livre);
                    model.addAttribute("peutPreter", peutPreter);
                    model.addAttribute("adherant", adherant);
                }
            }
            
            // Ajouter des informations contextuelles pour l'affichage
            if (userType == null) {
                model.addAttribute("isGuest", true);
            } else {
                model.addAttribute("isGuest", false);
            }
            
            return "livre/view";
        }
        return "redirect:/livres";
    }

    @GetMapping("/list")
    public String livres(Model model, HttpSession session) {
        List<Livre> livres = livreService.findAll();
        List<Categorie> categories = categorieService.findAll();
        
        // Ajouter le type d'utilisateur pour la vue
        String userType = (String) session.getAttribute("userType");
        model.addAttribute("userType", userType);
        
        model.addAttribute("livres", livres);
        model.addAttribute("categories", categories);

        return "listLivre"; // Redirection vers la page des livres
    }
}
