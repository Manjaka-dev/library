package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Adherant;

import java.util.List;

@Repository
public interface AdherantRepository extends JpaRepository<Adherant, Integer> {
    
    @Query("SELECT a FROM Adherant a WHERE a.nomAdherant = :nom AND a.prenomAdherant = :prenom")
    List<Adherant> findByNomAndPrenom(@Param("nom") String nom, @Param("prenom") String prenom);
    
    @Query("SELECT a FROM Adherant a WHERE a.profil.idProfil = :profilId")
    List<Adherant> findByProfilId(@Param("profilId") Integer profilId);
}
