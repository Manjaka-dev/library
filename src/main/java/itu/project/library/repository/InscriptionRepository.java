package itu.project.library.repository;

import itu.project.library.entity.Inscription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface InscriptionRepository extends JpaRepository<Inscription, Integer> {
    
    @Query("SELECT i FROM Inscription i WHERE i.adherant.idAdherant = :adherantId")
    List<Inscription> findByAdherantId(@Param("adherantId") Integer adherantId);
    
    @Query("SELECT i FROM Inscription i WHERE i.etat = :etat")
    List<Inscription> findByEtat(@Param("etat") Boolean etat);
}
