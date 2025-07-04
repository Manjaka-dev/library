package itu.web_dyn.bibliotheque.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Admin;
import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.repository.AdminRepository;
import itu.web_dyn.bibliotheque.repository.AdherantRepository;

@Service
public class AuthenticationService {

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private AdherantRepository adherantRepository;

    /**
     * Authentification d'un administrateur
     * @param nomAdmin Nom de l'administrateur
     * @param password Mot de passe
     * @return Admin si authentification réussie, null sinon
     */
    public Admin authenticateAdmin(String nomAdmin, String password) {
        List<Admin> admins = adminRepository.findAll();
        for (Admin admin : admins) {
            if (nomAdmin.equals(admin.getNomAdmin()) && password.equals(admin.getPassword())) {
                return admin;
            }
        }
        return null;
    }

    /**
     * Authentification d'un adhérent
     * @param nomAdherant Nom de l'adhérent
     * @param password Mot de passe
     * @return Adherant si authentification réussie, null sinon
     */
    public Adherant authenticateAdherant(String nomAdherant, String password) {
        List<Adherant> adherants = adherantRepository.findAll();
        for (Adherant adherant : adherants) {
            if (nomAdherant.equals(adherant.getNomAdherant()) && password.equals(adherant.getPassword())) {
                return adherant;
            }
        }
        return null;
    }

    /**
     * Authentification d'un adhérent par numéro
     * @param numeroAdherant Numéro de l'adhérent
     * @param password Mot de passe
     * @return Adherant si authentification réussie, null sinon
     */
    public Adherant authenticateAdherantByNumero(int numeroAdherant, String password) {
        List<Adherant> adherants = adherantRepository.findAll();
        for (Adherant adherant : adherants) {
            if (numeroAdherant == adherant.getNumeroAdherant() && password.equals(adherant.getPassword())) {
                return adherant;
            }
        }
        return null;
    }

    /**
     * Vérifier si un utilisateur est administrateur
     * @param userType Type d'utilisateur depuis la session
     * @return true si administrateur
     */
    public boolean isAdmin(String userType) {
        return "admin".equals(userType);
    }

    /**
     * Vérifier si un utilisateur est adhérent
     * @param userType Type d'utilisateur depuis la session
     * @return true si adhérent
     */
    public boolean isAdherant(String userType) {
        return "adherant".equals(userType);
    }
}
