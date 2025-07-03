package itu.web_dyn.bibliotheque.entities;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reservation")
    private Integer idReservation;
    
    @Column(name = "date_de_reservation")
    private LocalDateTime dateDeReservation;
    
    @ManyToOne
    @JoinColumn(name = "id_admin", nullable = false)
    private Admin admin;
    
    @ManyToOne
    @JoinColumn(name = "id_exemplaire", nullable = false)
    private Exemplaire exemplaire;
    
    @ManyToOne
    @JoinColumn(name = "id_adherant", nullable = false)
    private Adherant adherant;
    
    @ManyToOne
    @JoinColumn(name = "id_statut_reservation", nullable = false)
    private StatutReservation statut;
    
    // Constructeurs
    public Reservation() {}
    
    public Reservation(Integer idReservation, LocalDateTime dateDeReservation, 
                       Admin admin, Exemplaire exemplaire, 
                       Adherant adherant, StatutReservation statut) {
        this.idReservation = idReservation;
        this.dateDeReservation = dateDeReservation;
        this.admin = admin;
        this.exemplaire = exemplaire;
        this.adherant = adherant;
        this.statut = statut;
    }

    public Reservation(LocalDateTime dateDeReservation, 
                       Admin admin, Exemplaire exemplaire, 
                       Adherant adherant, StatutReservation statut) {
        this.dateDeReservation = dateDeReservation;
        this.admin = admin;
        this.exemplaire = exemplaire;
        this.adherant = adherant;
        this.statut = statut;
    }
    
    // Getters et Setters
    public Integer getIdReservation() {
        return idReservation;
    }
    
    public void setIdReservation(Integer idReservation) {
        this.idReservation = idReservation;
    }
    
    public LocalDateTime getDateDeReservation() {
        return dateDeReservation;
    }
    
    public void setDateDeReservation(LocalDateTime dateDeReservation) {
        this.dateDeReservation = dateDeReservation;
    }
    
    public Admin getAdmin() {
        return admin;
    }
    
    public void setAdmin(Admin admin) {
        this.admin = admin;
    }
    
    public Exemplaire getExemplaire() {
        return exemplaire;
    }
    
    public void setExemplaire(Exemplaire exemplaire) {
        this.exemplaire = exemplaire;
    }
    
    public Adherant getAdherant() {
        return adherant;
    }
    
    public void setAdherant(Adherant adherant) {
        this.adherant = adherant;
    }
    
    public StatutReservation getStatut() {
        return statut;
    }
    
    public void setStatut(StatutReservation statut) {
        this.statut = statut;
    }
}
