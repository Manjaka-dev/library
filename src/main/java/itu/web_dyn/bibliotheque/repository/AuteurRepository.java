package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Auteur;

@Repository
public interface AuteurRepository extends JpaRepository<Auteur, Integer> {
}
