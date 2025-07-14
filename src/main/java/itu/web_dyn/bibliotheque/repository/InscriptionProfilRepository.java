package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.InscriptionProfil;

@Repository
public interface InscriptionProfilRepository extends JpaRepository<InscriptionProfil, Integer> {
    
}
