package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.FinPret;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface FinPretRepository extends JpaRepository<FinPret, Integer> {
    
    @Query("SELECT fp FROM FinPret fp WHERE fp.pret.idPret = :pretId")
    List<FinPret> findByPretId(@Param("pretId") Integer pretId);
    
    @Query("SELECT fp FROM FinPret fp WHERE fp.dateFin BETWEEN :dateDebut AND :dateFin")
    List<FinPret> findByDateFinBetween(@Param("dateDebut") LocalDateTime dateDebut, @Param("dateFin") LocalDateTime dateFin);
    
    // Méthode pour trouver le FinPret d'un prêt spécifique (une seule occurrence)
    @Query("SELECT fp FROM FinPret fp WHERE fp.pret.idPret = :idPret")
    FinPret findByIdPret(@Param("idPret") Integer idPret);
}
