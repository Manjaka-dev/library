package itu.web_dyn.bibliotheque.entities;

import java.io.Serializable;
import jakarta.persistence.*;

@Embeddable
public class ReservationStatutId implements Serializable {
    @SuppressWarnings("unused")
    private Integer idReservation;
    @SuppressWarnings("unused")
    private Integer idStatutReservation;

    // equals & hashCode
    // Getters & Setters
}