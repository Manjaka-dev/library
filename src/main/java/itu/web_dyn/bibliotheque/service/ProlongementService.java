package itu.web_dyn.bibliotheque.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.DureePret;
import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.entities.Reservation;
import itu.web_dyn.bibliotheque.entities.Prolongement;
import itu.web_dyn.bibliotheque.entities.Profil;
import itu.web_dyn.bibliotheque.repository.DureePretRepository;
import itu.web_dyn.bibliotheque.repository.FinPretRepository;
import itu.web_dyn.bibliotheque.repository.PretRepository;
import itu.web_dyn.bibliotheque.repository.ReservationRepository;
import itu.web_dyn.bibliotheque.repository.ProlongementRepository;

@Service
public class ProlongementService {

    @Autowired
    PretRepository pretRepository;

    @Autowired
    DureePretRepository dureePretRepository;
    
    @Autowired
    ReservationRepository reservationRepository;
    
    @Autowired
    FinPretRepository finPretRepository;
    
    @Autowired
    private ProlongementRepository prolongementRepository;
    
    // Méthodes utilisant l'entité Prolongement (pour la compatibilité)
    public List<Prolongement> findById(int idPret) {
        return prolongementRepository.findByPretId(idPret);
    }

    public boolean isExemplaireEnProlongementActif(Integer idExemplaire) {
        List<Prolongement> prolongements = prolongementRepository.findProlongementsEnCoursByExemplaire(idExemplaire, LocalDateTime.now());
        return !prolongements.isEmpty();
    }

    public List<Prolongement> findByPretId(int idPret) {
        return prolongementRepository.findByPretId(idPret);
    }

    public int countProlongementsActifsParAdherant(int idAdherant) {
        return prolongementRepository.countActifsByAdherant(idAdherant, LocalDateTime.now());
    }

    public Prolongement creerProlongement(int idPret, int duree) {
        Pret pret = pretRepository.findById(idPret)
                                  .orElseThrow(() -> new RuntimeException("Prêt non trouvé"));
        Prolongement p = new Prolongement();

        // Utiliser FinPret pour récupérer la date de fin actuelle
        List<FinPret> finsPret = finPretRepository.findByPretId(idPret);
        LocalDateTime dateFinActuelle;
        
        if (finsPret.isEmpty()) {
            // Si pas de FinPret, utiliser une durée par défaut (2 semaines)
            dateFinActuelle = pret.getDateDebut().plusWeeks(2);
        } else {
            dateFinActuelle = finsPret.get(0).getDateFin();
        }

        LocalDateTime nouvelleDateFin = dateFinActuelle.plusDays(duree);

        p.setDateFin(nouvelleDateFin);
        p.setPret(pret);
        return prolongementRepository.save(p);
    }
    
    // Méthode principale de prolongement qui utilise FinPret (plus cohérent avec le controller)
    public void prolongerPretAvecFinPret(Integer idPret, LocalDateTime nouvelleDateFin) throws Exception {
        Pret currentPret = pretRepository.findById(idPret).orElse(null);
        if (currentPret == null) {
            throw new Exception("Prêt non trouvé avec l'ID : " + idPret);
        }

        Profil profil = currentPret.getAdherant().getProfil();
        
        DureePret dureePret = dureePretRepository.findByIdProfil(profil.getIdProfil());
        if (dureePret == null) {
            throw new Exception("Aucune durée de prêt définie pour ce profil");
        }
        
        // Vérifier si le prêt peut être prolongé
        List<FinPret> finPrets = finPretRepository.findByPretId(currentPret.getIdPret());
        if (finPrets.size() >= 2) {
            throw new Exception("Ce prêt a déjà été prolongé le maximum de fois autorisé");
        }
        
        // Vérifier les réservations conflictuelles
        List<Reservation> reservations = reservationRepository.findByDateDeReservationBetween(
            LocalDateTime.now(), nouvelleDateFin);
        if (!reservations.isEmpty()) {
            throw new Exception("Prolongement impossible. Le livre est réservé durant cette période");
        }
        
        // Créer ou modifier FinPret
        FinPret finPret;
        if (finPrets.isEmpty()) {
            finPret = new FinPret(nouvelleDateFin, currentPret);
        } else {
            finPret = finPrets.get(0);
            finPret.setDateFin(nouvelleDateFin);
        }
        
        finPretRepository.save(finPret);
    }

    public void prolongerPret(Integer idPret, LocalDateTime dateTime) throws Exception{
        Pret currentPret = pretRepository.findById(idPret).orElse(null);

        Profil profil = currentPret.getAdherant().getProfil();
        
        DureePret dureePret = dureePretRepository.findByIdProfil(profil.getIdProfil());

        if (dureePret == null) {
            throw new Exception("Aucune durée de prêt définie");
        }
        if (currentPret != null) {
            List<FinPret> finPrets = finPretRepository.findByPretId(currentPret.getIdPret());
            if (finPrets.size() >= 2) {
                throw new Exception("Pret deja prolonger");
            }
            if (currentPret.getDateDebut().plusDays(dureePret.getDuree()).isAfter(dateTime)) {
                throw new Exception("La date est avant la date fin du pret");
            }
            List<Reservation> reservations = reservationRepository.findByDateDeReservationBetween(dateTime, dateTime.plusDays(dureePret.getDuree()));
            if (!reservations.isEmpty()) {
                throw new Exception("Prolongement impossible. Date deja reserver");
            }
            FinPret newFin = new FinPret(dateTime, currentPret);
            finPretRepository.save(newFin);
        } 
        // else {
        //     throw new Exception("Pret non trouver idPret : "+idPret);
        // }
    }
}