package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Reservation;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
    
    @Query("SELECT r FROM Reservation r WHERE r.adherant.idAdherant = :adherantId")
    List<Reservation> findByAdherantId(@Param("adherantId") Integer adherantId);
    
    // @Query("SELECT r FROM Reservation r WHERE r.exemplaire.idExemplaire = :exemplaireId")
    // List<Reservation> findByExemplaireId(@Param("exemplaireId") Integer exemplaireId);
    
    @Query("SELECT r FROM Reservation r WHERE r.admin.idAdmin = :adminId")
    List<Reservation> findByAdminId(@Param("adminId") Integer adminId);
    
    @Query("SELECT r FROM Reservation r WHERE r.statut.idStatutReservation = :statutId")
    List<Reservation> findByStatutId(@Param("statutId") Integer statutId);
    
    // Méthode pour trouver les réservations dans une période donnée
    @Query("SELECT r FROM Reservation r WHERE r.dateDeReservation BETWEEN :dateDebut AND :dateFin")
    List<Reservation> findByDateDeReservationBetween(@Param("dateDebut") LocalDateTime dateDebut, @Param("dateFin") LocalDateTime dateFin);
    
    // Compter les réservations actives (En attente ou Confirmée) d'un adhérant
    @Query("SELECT COUNT(r) FROM Reservation r WHERE r.adherant.idAdherant = :adherantId AND r.statut.nomStatut IN ('En attente', 'Confirmée')")
    int countReservationsActivesByAdherant(@Param("adherantId") Integer adherantId);
    
    // Trouver les réservations actives d'un adhérant
    @Query("SELECT r FROM Reservation r WHERE r.adherant.idAdherant = :adherantId AND r.statut.nomStatut IN ('En attente', 'Confirmée')")
    List<Reservation> findReservationsActivesByAdherant(@Param("adherantId") Integer adherantId);
}
