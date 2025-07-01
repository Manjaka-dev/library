package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Exemplaire;

import java.util.List;

@Repository
public interface ExemplaireRepository extends JpaRepository<Exemplaire, Integer> {
    
    @Query("SELECT e FROM Exemplaire e WHERE e.livre.idLivre = :livreId")
    List<Exemplaire> findByLivreId(@Param("livreId") Integer livreId);
}
