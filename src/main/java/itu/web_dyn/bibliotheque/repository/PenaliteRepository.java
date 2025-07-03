package itu.web_dyn.bibliotheque.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Penalite;

@Repository
public interface PenaliteRepository extends JpaRepository<Penalite, Integer> {
    List<Penalite> findByAdherantIdAdherant(Integer idAdherant);
    Optional<Penalite> findTopByAdherantIdAdherantOrderByDatePenaliteDesc(Integer idAdherant);
    List<Penalite> findByAdherant(Adherant adherant);
}
