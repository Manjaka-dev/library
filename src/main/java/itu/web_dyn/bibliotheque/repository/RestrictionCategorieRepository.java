package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.RestrictionCategorie;
import itu.web_dyn.bibliotheque.entities.RestrictionCategorieId;

@Repository
public interface RestrictionCategorieRepository extends JpaRepository<RestrictionCategorie, RestrictionCategorieId>{
    @Query(value = "SELECT EXISTS(SELECT 1 FROM restriction_categorie WHERE id_categorie = :idCategorie AND id_profil = :idProfil)", nativeQuery = true)
    int existsRestriction(@Param("idCategorie") Integer idCategorie, @Param("idProfil") Integer idProfil);
}
