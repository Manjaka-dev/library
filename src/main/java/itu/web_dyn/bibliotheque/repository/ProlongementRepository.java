package itu.web_dyn.bibliotheque.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Prolongement;

@Repository
public interface ProlongementRepository extends JpaRepository<Prolongement, Integer> {
    
    // Utiliser JPQL simple au lieu de SQL natif - suit le pattern des autres repositories
    @Query("SELECT p FROM Prolongement p JOIN p.pret pr WHERE pr.exemplaire.idExemplaire = :idExemplaire AND p.dateFin > :now")
    List<Prolongement> findProlongementsEnCoursByExemplaire(@Param("idExemplaire") Integer idExemplaire, @Param("now") LocalDateTime now);

    // Simplifier en utilisant JPQL - pattern cohérent avec ReservationRepository
    @Query("SELECT COUNT(p) FROM Prolongement p JOIN p.pret pr WHERE pr.adherant.idAdherant = :idAdherant AND p.dateFin > :now")
    int countActifsByAdherant(@Param("idAdherant") Integer idAdherant, @Param("now") LocalDateTime now);

    // Méthode standard JPA - suit le pattern simple comme AuteurRepository
    List<Prolongement> findByPretIdPret(@Param("idPret") Integer idPret);
    
    // Alternative avec JPQL si la méthode au-dessus ne fonctionne pas
    @Query("SELECT p FROM Prolongement p WHERE p.pret.idPret = :idPret")
    List<Prolongement> findByPretId(@Param("idPret") Integer idPret);
    
    // Ajouter des méthodes suivant le pattern standard JPA
    List<Prolongement> findByDateFinAfter(LocalDateTime date);
    List<Prolongement> findByDateFinBefore(LocalDateTime date);
}
