package itu.web_dyn.bibliotheque.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import itu.web_dyn.bibliotheque.repository.AdherantRepository;
import itu.web_dyn.bibliotheque.repository.LivreRepository;
import itu.web_dyn.bibliotheque.repository.PretRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    @Autowired
    private AdherantRepository adherantRepository;
    
    @Autowired
    private LivreRepository livreRepository;
    
    @Autowired
    private PretRepository pretRepository;

    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        String userType = (String) session.getAttribute("userType");
        
        // Redirection selon le type d'utilisateur
        if ("adherant".equals(userType)) {
            return "redirect:/adherant/dashboard";
        }
        
        // Pour les administrateurs et les utilisateurs non connectés, afficher l'index
        // Les statistiques ne sont visibles que pour les administrateurs
        if ("admin".equals(userType)) {
            model.addAttribute("totalAdherants", adherantRepository.count());
            model.addAttribute("totalLivres", livreRepository.count());
            model.addAttribute("totalPrets", pretRepository.count());
        }
        
        return "index";
    }
}
