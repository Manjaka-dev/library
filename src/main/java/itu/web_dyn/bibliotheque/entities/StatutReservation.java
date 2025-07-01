package itu.web_dyn.bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "statut_reservation")
public class StatutReservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_statut_reservation")
    private Integer idStatutReservation;
    
    @Column(name = "nom_statut", length = 50)
    private String nomStatut;
    
    // Constructeurs
    public StatutReservation() {}
    
    public StatutReservation(Integer idStatutReservation, String nomStatut) {
        this.idStatutReservation = idStatutReservation;
        this.nomStatut = nomStatut;
    }
    
    // Getters et Setters
    public Integer getIdStatutReservation() {
        return idStatutReservation;
    }
    
    public void setIdStatutReservation(Integer idStatutReservation) {
        this.idStatutReservation = idStatutReservation;
    }
    
    public String getNomStatut() {
        return nomStatut;
    }
    
    public void setNomStatut(String nomStatut) {
        this.nomStatut = nomStatut;
    }
}
