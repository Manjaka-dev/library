package itu.web_dyn.bibliotheque.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Penalite;

@Repository
public interface PenaliteRepository extends JpaRepository<Penalite, Integer> {
    List<Penalite> findByAdherant(Adherant adherant);

}
