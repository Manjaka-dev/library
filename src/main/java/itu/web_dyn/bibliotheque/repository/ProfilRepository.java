package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Profil;

@Repository
public interface ProfilRepository extends JpaRepository<Profil, Integer> {
}
