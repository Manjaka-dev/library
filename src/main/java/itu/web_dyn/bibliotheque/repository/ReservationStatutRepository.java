package itu.web_dyn.bibliotheque.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.ReservationStatut;
import itu.web_dyn.bibliotheque.entities.ReservationStatutId;

@Repository
public interface ReservationStatutRepository extends JpaRepository<ReservationStatut, ReservationStatutId> {

}
