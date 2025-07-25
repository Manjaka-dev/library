package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Pret;

import java.util.List;

@Repository
public interface PretRepository extends JpaRepository<Pret, Integer> {

    @Query("""
        SELECT COUNT(p) FROM Pret p
        WHERE p.adherant.idAdherant = :idAdherant
          AND p.typePret.idTypePret = :idTypePret
          AND p.idPret NOT IN (SELECT f.pret.idPret FROM FinPret f)
        """)
    int countPretsEnCours(@Param("idAdherant") Integer idAdherant, @Param("idTypePret") Integer idTypePret);

    @Query(value = "SELECT * FROM fin_pret f WHERE f.id_pret = :idPret ORDER BY date_fin ASC limit 1",  nativeQuery = true)
    FinPret findByIdPret(@Param("idPret") Integer id_pret);

    @Query(value = "SELECT * FROM pret p WHERE p.id_exemplaire = :idExemplaire", nativeQuery = true)
    List<Pret> findByIdExemplaire(@Param("idExemplaire") Integer id_exemplaire);
    
    @Query("SELECT p FROM Pret p WHERE p.adherant.idAdherant = :idAdherant ORDER BY p.dateDebut DESC")
    List<Pret> findByAdherantIdAdherant(@Param("idAdherant") Integer idAdherant);
    
}
