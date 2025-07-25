package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Categorie;
import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.repository.ExemplaireRepository;
import itu.web_dyn.bibliotheque.repository.LivreRepository;
import itu.web_dyn.bibliotheque.repository.RestrictionCategorieRepository;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;


@Service
public class LivreService {
    @Autowired
    private LivreRepository livreRepository;

    @Autowired 
    private RestrictionCategorieRepository restrictionCategorieRepository;

    @Autowired 
    private ExemplaireRepository exemplaireRepository;

    public Livre findById(Integer id){
        return livreRepository.findById(id).get();
    }

    public List<Livre> findAll(){
        return livreRepository.findAll();
    }

    public void save(Livre livre){
        livreRepository.save(livre);
    }

    public void deleteById(Integer id) {
        livreRepository.deleteById(id);
    }

    public List<Exemplaire> findAllExemplaireByIdLivre(Integer idLivre) {
        return exemplaireRepository.findByLivreIdLivre(idLivre);
    }

    public boolean peutPreterLivre(Adherant adherant, Livre livre) {
        // 1. Vérifier la restriction de catégorie
        for (Categorie categorie : livre.getCategories()) {
            boolean restreint = restrictionCategorieRepository.existsRestriction(
                categorie.getIdCategorie(), adherant.getProfil().getIdProfil());
            if (restreint) {
                System.out.println("❌ Restriction trouvée : Profil '" + adherant.getProfil().getNomProfil() + 
                    "' ne peut pas emprunter la catégorie '" + categorie.getNomCategorie() + "'");
                return false;
            }
        }

        // 2. Vérifier l'âge requis
        LocalDate naissance = adherant.getDateNaissance();
        int age = Period.between(naissance, LocalDate.now()).getYears();
        if (livre.getAgeRequis() != null && age < livre.getAgeRequis()) {
            System.out.println("❌ Restriction d'âge : Adhérant (" + age + " ans) trop jeune pour ce livre (âge requis: " + livre.getAgeRequis() + " ans)");
            return false;
        }

        System.out.println("✅ Aucune restriction : Adhérant peut emprunter ce livre");
        return true;
    }
}