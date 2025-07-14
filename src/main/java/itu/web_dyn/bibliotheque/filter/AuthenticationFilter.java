package itu.web_dyn.bibliotheque.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Component;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Filtre d'authentification et d'autorisation
 * - Les adhérents peuvent consulter les livres et faire des réservations
 * - Les bibliothécaires (admin) ont accès à tout
 */
@Component
@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    // Pages publiques accessibles sans authentification
    private static final List<String> PUBLIC_URLS = Arrays.asList(
        "/login",
        "/logout",
        "/css/",
        "/js/",
        "/images/",
        "/favicon.ico",
        "/webjars/",
        "/static/",
        "/error",
        "/livres",              // Consultation du catalogue (lecture seule)
        "/livres/view/"         // Détails d'un livre (lecture seule)
    );

    // Pages accessibles aux adhérents (lecture et réservation)
    private static final List<String> ADHERANT_URLS = Arrays.asList(
        "/adherant/",
        "/livres",              // Consultation du catalogue
        "/livres/view/",        // Détails d'un livre
        "/reservations/new",    // Nouvelle réservation
        "/reservations/save",   // Sauvegarder une réservation
        "/reservation/reserveBook", // Ancienne route de réservation
        "/logout"              // Déconnexion
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation du filtre
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Vérifier si la page est publique
        if (isPublicPage(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Page d'accueil accessible à tous (contenu adapté selon le type d'utilisateur)
        if ("/".equals(path) || "".equals(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Vérifier l'authentification
        String userType = (session != null) ? (String) session.getAttribute("userType") : null;
        
        if (userType == null) {
            // Utilisateur non connecté - vérifier si l'accès est autorisé en lecture seule
            if (isGuestReadOnlyAllowed(path)) {
                chain.doFilter(request, response);
                return;
            } else {
                // Rediriger vers la page de connexion pour les autres pages
                httpResponse.sendRedirect(contextPath + "/login");
                return;
            }
        }

        // Vérifier les autorisations selon le type d'utilisateur
        if ("admin".equals(userType)) {
            // Les bibliothécaires (admin) ont accès à tout
            chain.doFilter(request, response);
        } else if ("adherant".equals(userType)) {
            // Vérifier si l'adhérent a accès à cette page
            if (isAdherantAllowed(path)) {
                chain.doFilter(request, response);
            } else {
                // Accès refusé, rediriger vers le dashboard adhérent avec message d'erreur
                httpResponse.sendRedirect(contextPath + "/adherant/dashboard?error=access_denied");
            }
        } else {
            // Type d'utilisateur non reconnu, invalider la session et rediriger
            session.invalidate();
            httpResponse.sendRedirect(contextPath + "/login?error=invalid_session");
        }
    }

    @Override
    public void destroy() {
        // Nettoyage du filtre
    }

    /**
     * Vérifier si une page est publique
     */
    private boolean isPublicPage(String path) {
        return PUBLIC_URLS.stream().anyMatch(url -> path.startsWith(url));
    }

    /**
     * Vérifier si un adhérent a accès à une page
     */
    private boolean isAdherantAllowed(String path) {
        // Vérifier les pages spécifiquement autorisées aux adhérents
        for (String allowedUrl : ADHERANT_URLS) {
            if (path.startsWith(allowedUrl)) {
                return true;
            }
        }
        
        // Autoriser la consultation des livres (lecture seule)
        if (path.startsWith("/livres")) {
            // Interdire les actions de modification (new, edit, delete, save)
            return !path.contains("/new") && 
                   !path.contains("/edit") && 
                   !path.contains("/delete") && 
                   !path.contains("/save");
        }
        
        return false;
    }

    /**
     * Vérifier si un utilisateur non connecté (invité) a accès à une page en lecture seule
     */
    private boolean isGuestReadOnlyAllowed(String path) {
        // Autoriser uniquement la consultation du catalogue des livres (lecture seule)
        if (path.startsWith("/livres")) {
            // Interdire toutes les actions de modification et de réservation
            return !path.contains("/new") && 
                   !path.contains("/edit") && 
                   !path.contains("/delete") && 
                   !path.contains("/save") &&
                   !path.contains("/reserve");
        }
        
        return false;
    }
}
