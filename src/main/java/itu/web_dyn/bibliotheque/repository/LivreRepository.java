package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.Livre;

import java.util.List;

@Repository
public interface LivreRepository extends JpaRepository<Livre, Integer> {
    
    List<Livre> findByTitreContainingIgnoreCase(String titre);
    
    List<Livre> findByIsbn(String isbn);
    
    @Query("SELECT l FROM Livre l WHERE l.auteur.idAuteur = :auteurId")
    List<Livre> findByAuteurId(@Param("auteurId") Integer auteurId);
    
    @Query("SELECT l FROM Livre l WHERE l.editeur.idEditeur = :editeurId")
    List<Livre> findByEditeurId(@Param("editeurId") Integer editeurId);
    
    @Query("SELECT l FROM Livre l JOIN l.categories c WHERE c.idCategorie = :categorieId")
    List<Livre> findByCategorieId(@Param("categorieId") Integer categorieId);

    @Query(value = "SELECT * from exemplaire where id_livre = :idLivre", nativeQuery = true)
    List<Exemplaire> findAllExemplaireByIdLivre(@Param("idLivre") Integer idLivre);
}
