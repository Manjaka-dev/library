package itu.web_dyn.bibliotheque.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Inscription;

@Repository
public interface InscriptionRepository extends JpaRepository<Inscription, Integer> {
    @Query(value = "SELECT * FROM inscription WHERE id_adherant = :adherantId ORDER BY date_debut DESC LIMIT 1", nativeQuery = true)
    Inscription findLastByAdherantId(@Param("adherantId") Integer adherantId);

    // Corriger la méthode pour utiliser les bonnes propriétés de l'entité Inscription
    Optional<Inscription> findTopByAdherantIdAdherantOrderByDateDebutDesc(Integer adherantId);
    
    // Ajouter des méthodes utiles pour les inscriptions
    List<Inscription> findByAdherantIdAdherantOrderByDateDebutDesc(Integer adherantId);
    
    // Trouver les inscriptions actives (date fin > maintenant)
    @Query("SELECT i FROM Inscription i WHERE i.adherant.idAdherant = :adherantId AND i.dateFin > :now ORDER BY i.dateDebut DESC")
    List<Inscription> findActiveInscriptionsByAdherant(@Param("adherantId") Integer adherantId, @Param("now") LocalDateTime now);
    
    // Vérifier si un adhérant a une inscription active
    @Query("SELECT CASE WHEN COUNT(i) > 0 THEN true ELSE false END FROM Inscription i WHERE i.adherant.idAdherant = :adherantId AND i.dateFin > :now")
    boolean hasActiveInscription(@Param("adherantId") Integer adherantId, @Param("now") LocalDateTime now);
}
