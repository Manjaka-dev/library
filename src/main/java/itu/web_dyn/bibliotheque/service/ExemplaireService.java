package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.entities.Retour;
import itu.web_dyn.bibliotheque.repository.ExemplaireRepository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class ExemplaireService {

    @Autowired
    private ExemplaireRepository exemplaireRepository;

    @Autowired
    private ProlongementService prolongementService;

    @Autowired
    private PretService pretService;

    public Exemplaire findById(Integer id) {
        return exemplaireRepository.findById(id).get();
    }

    public List<Exemplaire> findAll() {
        return exemplaireRepository.findAll();
    }

    public void save(Exemplaire exemplaire) {
        exemplaireRepository.save(exemplaire);
    }

    public List<Exemplaire> findAllExemplaireByIdLivre(Integer idLivre) {
        return exemplaireRepository.findByLivreIdLivre(idLivre);
    }

    public Boolean isExemplaireDisponible(Integer id_exemplaire, LocalDateTime dateDebut, LocalDateTime dateFin) {

        // Vérifie s'il y a un prolongement actif
        if (prolongementService.isExemplaireEnProlongementActif(id_exemplaire)) {
            return false;
        }

        List<Pret> prets = pretService.findByIdExemplaire(id_exemplaire);

        for (Pret pret : prets) {

            LocalDateTime dateDebutPret = pret.getDateDebut();
            LocalDateTime dateFinPretOuRetour = null;

            Retour retour = pretService.findRetourPret(pret);
            if (retour != null) {
                // Le livre a été retourné, utiliser la date de retour
                dateFinPretOuRetour = retour.getDateRetour();
            } else {
                // Pas de retour, vérifier la date de fin prévue du prêt
                FinPret finpret = pretService.findFinPret(pret);
                if (finpret != null) {
                    dateFinPretOuRetour = finpret.getDateFin();
                } else {
                    // Pas de fin prévue, considérer le prêt comme indéfini
                    return false;
                }
            }

            if (dateFinPretOuRetour == null) return false;

            // Vérifier si les périodes se chevauchent
            if (UtilService.periodesSeChevauchent(dateDebutPret, dateFinPretOuRetour, dateDebut, dateFin)) {
                return false;
            }

        }

        return true;
    }

    public Boolean isExemplaireDisponible(Integer idExemplaire, LocalDateTime dateDebut) {

        if (prolongementService.isExemplaireEnProlongementActif(idExemplaire)) {
            return false;
        }

        List<Pret> prets = pretService.findByIdExemplaire(idExemplaire);

        for (Pret pret : prets) {
            Retour retour = pretService.findRetourPret(pret);

            if (retour == null) {
                // Pas de retour, vérifier si le prêt est encore en cours
                FinPret finPret = pretService.findFinPret(pret);
                if (finPret != null && finPret.getDateFin().isAfter(dateDebut)) {
                    // Prêt encore en cours au moment voulu
                    return false;
                }
                // Si pas de FinPret ou si la date de fin est passée, continuer à vérifier les autres prêts
            } else {
                // Il y a eu un retour, vérifier si le retour s'est fait après la date voulue
                if (retour.getDateRetour().isAfter(dateDebut)) {
                    // Le livre était encore emprunté à la date voulue
                    return false;
                }
            }
        }

        return true;
    }

}