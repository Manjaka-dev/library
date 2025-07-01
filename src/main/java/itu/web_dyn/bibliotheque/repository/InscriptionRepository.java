package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Inscription;

import java.util.List;

@Repository
public interface InscriptionRepository extends JpaRepository<Inscription, Integer> {
    
    @Query("SELECT i FROM Inscription i WHERE i.adherant.idAdherant = :adherantId")
    List<Inscription> findByAdherantId(@Param("adherantId") Integer adherantId);
}
