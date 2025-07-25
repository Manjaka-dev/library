package itu.web_dyn.bibliotheque.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Retour;

@Repository
public interface RetourRepository extends JpaRepository<Retour,Integer> {
    @Query(value = "SELECT * FROM retour WHERE id_pret = :idPret", nativeQuery = true)
    Retour findRetourByPret(@Param("idPret") Integer idPret);

    List<Retour> findByDateRetourBetween(LocalDateTime debut, LocalDateTime fin);
    
    // Recherche par prêt
    Retour findByPret_IdPret(Integer idPret);
    
    // Recherche par adhérant
    @Query("SELECT r FROM Retour r WHERE r.pret.adherant.idAdherant = :idAdherant")
    List<Retour> findByAdherant(@Param("idAdherant") Integer idAdherant);  
}
