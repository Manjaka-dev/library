package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Pret;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface PretRepository extends JpaRepository<Pret, Integer> {
    
    @Query("SELECT p FROM Pret p WHERE p.adherant.idAdherant = :adherantId")
    List<Pret> findByAdherantId(@Param("adherantId") Integer adherantId);
    
    @Query("SELECT p FROM Pret p WHERE p.exemplaire.idExemplaire = :exemplaireId")
    List<Pret> findByExemplaireId(@Param("exemplaireId") Integer exemplaireId);
    
    @Query("SELECT p FROM Pret p WHERE p.admin.idAdmin = :adminId")
    List<Pret> findByAdminId(@Param("adminId") Integer adminId);
    
    @Query("SELECT p FROM Pret p WHERE p.dateDebut BETWEEN :dateDebut AND :dateFin")
    List<Pret> findByDateDebutBetween(@Param("dateDebut") LocalDateTime dateDebut, @Param("dateFin") LocalDateTime dateFin);
    
    @Query("SELECT p FROM Pret p WHERE p.typePret.idTypePret = :typePretId")
    List<Pret> findByTypePretId(@Param("typePretId") Integer typePretId);
}
