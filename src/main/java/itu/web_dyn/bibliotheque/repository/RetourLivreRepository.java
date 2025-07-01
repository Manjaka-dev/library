package itu.web_dyn.bibliotheque.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface RetourLivreRepository extends JpaRepository<RetourLivre,Integer> {
    List<RetourLivre> findByDateRetourBetween(LocalDateTime debut, LocalDateTime fin);
    
    // Recherche par type de retour
    List<RetourLivre> findByTypeRetour_IdTypeRetour(Integer idTypeRetour);
    
    // Recherche par prêt
    RetourLivre findByPret_IdPret(Integer idPret);
    
    // Recherche par adhérant
    @Query("SELECT r FROM RetourLivre r WHERE r.pret.adherant.idAdherant = :idAdherant")
    List<RetourLivre> findByAdherant(@Param("idAdherant") Integer idAdherant);
}
