package itu.web_dyn.bibliotheque.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.Reservation;
import itu.web_dyn.bibliotheque.repository.ReservationRepository;

@Service
public class ReservationService {
    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private AdherantService adherantService;

    @Autowired
    private StatutReservationService statutReservationService;

    @Autowired
    private LivreService livreService;

    @Autowired
    private ExemplaireService exemplaireService;

    public Reservation findById(Integer id){
        return reservationRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Réservation non trouvée avec l'ID " + id));
    }

    public List<Reservation> findAll(){
        return reservationRepository.findAll();
    }

    public void save(Reservation reservation){
        reservationRepository.save(reservation);
    }

    public void deleteById(Integer id){
        reservationRepository.deleteById(id);
    }

    public void reserverUnLivre(Integer id_adherant,Integer id_livre,LocalDateTime dateTime){
        // Trouver tous les exemplaires du livre
        List<Exemplaire> exemplairesLivre = exemplaireService.findAllExemplaireByIdLivre(id_livre);
        
        // Chercher un exemplaire disponible
        Exemplaire exemplaireDisponible = null;
        for (Exemplaire exemplaire : exemplairesLivre) {
            if (exemplaireService.isExemplaireDisponible(exemplaire.getIdExemplaire(), dateTime)) {
                exemplaireDisponible = exemplaire;
                break;
            }
        }
        
        if (exemplaireDisponible == null) {
            throw new RuntimeException("Aucun exemplaire disponible pour ce livre");
        }
        
        Reservation resa = new Reservation(
            dateTime, 
            null, 
            statutReservationService.findByNomStatut("En attente"), 
            livreService.findById(id_livre), 
            adherantService.findById(id_adherant),
            exemplaireDisponible
        );
        save(resa);
    }
}
