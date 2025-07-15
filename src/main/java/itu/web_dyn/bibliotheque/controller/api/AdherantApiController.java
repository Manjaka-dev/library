package itu.web_dyn.bibliotheque.controller.api;

import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import itu.web_dyn.bibliotheque.controller.api.dto.AdherantDetailDTO;
import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.service.AdherantService;
import itu.web_dyn.bibliotheque.service.PretService;
import itu.web_dyn.bibliotheque.repository.ReservationRepository;

@RestController
@RequestMapping("/api/adherants")
public class AdherantApiController {
    
    @Autowired
    private AdherantService adherantService;
    
    @Autowired
    private PretService pretService;
    
    @Autowired
    private ReservationRepository reservationRepository;
    
    /**
     * Obtenir les détails d'un adhérant avec ses quotas de prêt et de réservation
     * 
     * @param id ID de l'adhérant
     * @return Détails de l'adhérant avec ses quotas
     */
    @GetMapping("/{id}")
    public ResponseEntity<AdherantDetailDTO> getAdherantDetails(@PathVariable Integer id) {
        try {
            Adherant adherant = adherantService.findById(id);
            if (adherant == null) {
                return ResponseEntity.notFound().build();
            }
            
            // Récupérer les quotas du profil
            Integer quotaTotalPret = adherant.getProfil().getQuotaPret();
            Integer quotaTotalReservation = adherant.getProfil().getQuotaReservation();
            
            // Calculer les prêts en cours (non terminés)
            List<Pret> pretsAdherant = pretService.findByAdherant(adherant);
            int pretsUtilises = (int) pretsAdherant.stream()
                .filter(pret -> pretService.findFinPret(pret) == null)
                .count();
            
            // Calculer les réservations actives (En attente ou Confirmée)
            int reservationsUtilisees = reservationRepository.countReservationsActivesByAdherant(id);
            
            // Calculer les quotas restants
            int pretsRestants = Math.max(0, quotaTotalPret - pretsUtilises);
            int reservationsRestantes = Math.max(0, quotaTotalReservation - reservationsUtilisees);
            
            // Formater la date de naissance
            String dateNaissanceFormatee = adherant.getDateNaissance() != null ? 
                adherant.getDateNaissance().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : null;
            
            AdherantDetailDTO adherantDetail = new AdherantDetailDTO(
                adherant.getIdAdherant(),
                adherant.getNumeroAdherant(),
                adherant.getNomAdherant(),
                adherant.getPrenomAdherant(),
                dateNaissanceFormatee,
                adherant.getProfil().getNomProfil(),
                adherant.getProfil().getIdProfil(),
                quotaTotalPret,
                pretsUtilises,
                pretsRestants,
                quotaTotalReservation,
                reservationsUtilisees,
                reservationsRestantes
            );
            
            return ResponseEntity.ok(adherantDetail);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
