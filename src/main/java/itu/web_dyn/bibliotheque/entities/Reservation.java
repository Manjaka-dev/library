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
    @JoinColumn(name = "id_admin", nullable = true)
    private Admin admin;
    
    @ManyToOne
    @JoinColumn(name = "id_statut", nullable = false)
    private StatutReservation statut;
    
    @ManyToOne
    @JoinColumn(name = "id_statut_reservation", nullable = false)
    private StatutReservation statutReservation;
    
    @ManyToOne
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;
    
    @ManyToOne
    @JoinColumn(name = "id_adherant", nullable = false)
    private Adherant adherant;
    
    @ManyToOne
    @JoinColumn(name = "id_exemplaire", nullable = false)
    private Exemplaire exemplaire;
    
    // Constructeurs
    public Reservation() {}
    
    public Reservation(Integer idReservation, LocalDateTime dateDeReservation, 
                       Admin admin, StatutReservation statut, Livre livre, 
                       Adherant adherant, Exemplaire exemplaire) {
        this.idReservation = idReservation;
        this.dateDeReservation = dateDeReservation;
        this.admin = admin;
        this.statut = statut;
        this.statutReservation = statut;
        this.livre = livre;
        this.adherant = adherant;
        this.exemplaire = exemplaire;
    }
    
    // Constructeur sans ID (pour nouvelles réservations)
    public Reservation(LocalDateTime dateDeReservation, Admin admin, 
                       StatutReservation statut, Livre livre, Adherant adherant, Exemplaire exemplaire) {
        this.dateDeReservation = dateDeReservation;
        this.admin = admin;
        this.statut = statut;
        this.statutReservation = statut;
        this.livre = livre;
        this.adherant = adherant;
        this.exemplaire = exemplaire;
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
    
    public StatutReservation getStatut() {
        return statut;
    }
    
    public void setStatut(StatutReservation statut) {
        this.statut = statut;
        this.statutReservation = statut; // Synchronise les deux champs
    }
    
    public StatutReservation getStatutReservation() {
        return statutReservation;
    }
    
    public void setStatutReservation(StatutReservation statutReservation) {
        this.statutReservation = statutReservation;
        this.statut = statutReservation; // Synchronise les deux champs
    }
    
    public Livre getLivre() {
        return livre;
    }
    
    public void setLivre(Livre livre) {
        this.livre = livre;
    }
    
    public Adherant getAdherant() {
        return adherant;
    }
    
    public void setAdherant(Adherant adherant) {
        this.adherant = adherant;
    }
    
    public Exemplaire getExemplaire() {
        return exemplaire;
    }
    
    public void setExemplaire(Exemplaire exemplaire) {
        this.exemplaire = exemplaire;
    }
}