package itu.web_dyn.bibliotheque.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import itu.web_dyn.bibliotheque.entities.Admin;
import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.service.AuthenticationService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private AuthenticationService authService;

    // Page de connexion
    @GetMapping("/login")
    public String loginPage(Model model, @RequestParam(value = "error", required = false) String error,
                           @RequestParam(value = "logout", required = false) String logout) {
        if (error != null) {
            model.addAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect.");
        }
        if (logout != null) {
            model.addAttribute("logoutMessage", "Vous avez été déconnecté avec succès.");
        }
        return "auth/login";
    }

    // Traitement de la connexion
    @PostMapping("/login")
    public String processLogin(@RequestParam("userType") String userType,
                              @RequestParam("username") String username,
                              @RequestParam("password") String password,
                              HttpSession session,
                              Model model) {
        
        try {
            if ("admin".equals(userType)) {
                // Authentification administrateur
                Admin admin = authService.authenticateAdmin(username, password);
                if (admin != null) {
                    session.setAttribute("userType", "admin");
                    session.setAttribute("userId", admin.getIdAdmin());
                    session.setAttribute("userName", admin.getNomAdmin() + " " + admin.getPrenomAdmin());
                    session.setAttribute("user", admin);
                    return "redirect:/";
                }
            } else if ("adherant".equals(userType)) {
                // Authentification adhérent
                Adherant adherant = authService.authenticateAdherant(username, password);
                if (adherant != null) {
                    session.setAttribute("userType", "adherant");
                    session.setAttribute("userId", adherant.getIdAdherant());
                    session.setAttribute("userName", adherant.getNomAdherant() + " " + adherant.getPrenomAdherant());
                    session.setAttribute("user", adherant);
                    return "redirect:/adherant/dashboard";
                }
            }
            
            model.addAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect.");
            return "auth/login";
            
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Erreur lors de la connexion: " + e.getMessage());
            return "auth/login";
        }
    }

    // Déconnexion
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout";
    }

    // Dashboard adhérent
    @GetMapping("/adherant/dashboard")
    public String adherantDashboard(HttpSession session, Model model) {
        // Vérifier que l'utilisateur est connecté en tant qu'adhérent
        if (!"adherant".equals(session.getAttribute("userType"))) {
            return "redirect:/login";
        }
        
        Adherant adherant = (Adherant) session.getAttribute("user");
        model.addAttribute("adherant", adherant);
        return "adherant/dashboard";
    }
}
