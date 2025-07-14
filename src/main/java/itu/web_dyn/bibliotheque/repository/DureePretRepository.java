package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.DureePret;

import java.util.List;

@Repository
public interface DureePretRepository extends JpaRepository<DureePret, Integer> {
    
    @Query("SELECT dp FROM DureePret dp WHERE dp.profil.idProfil = :profilId")
    List<DureePret> findByProfilId(@Param("profilId") Integer profilId);
    
    // Méthode pour trouver une durée de prêt par profil (une seule occurrence)
    @Query("SELECT dp FROM DureePret dp WHERE dp.profil.idProfil = :idProfil")
    DureePret findByIdProfil(@Param("idProfil") Integer idProfil);
}
