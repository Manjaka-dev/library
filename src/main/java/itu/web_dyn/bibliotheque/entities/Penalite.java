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
@Table(name = "penalite")
public class Penalite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_penalite")
    private Integer idPenalite;
    
    @ManyToOne
    @JoinColumn(name = "id_adherant", nullable = false)
    private Adherant adherant;
    
    @Column(name = "date_fin_penalite")
    private LocalDateTime dateFinPenalite;
    
    @Column(name = "motif")
    private String motif;
    
    // Constructeurs
    public Penalite() {}
    
    public Penalite(Integer idPenalite, Adherant adherant, LocalDateTime dateFinPenalite, String motif) {
        this.idPenalite = idPenalite;
        this.adherant = adherant;
        this.dateFinPenalite = dateFinPenalite;
        this.motif = motif;
    }
    
    // Getters et Setters
    public Integer getIdPenalite() {
        return idPenalite;
    }
    
    public void setIdPenalite(Integer idPenalite) {
        this.idPenalite = idPenalite;
    }
    
    public Adherant getAdherant() {
        return adherant;
    }
    
    public void setAdherant(Adherant adherant) {
        this.adherant = adherant;
    }
    
    public LocalDateTime getDateFinPenalite() {
        return dateFinPenalite;
    }
    
    public void setDateFinPenalite(LocalDateTime dateFinPenalite) {
        this.dateFinPenalite = dateFinPenalite;
    }
    
    public String getMotif() {
        return motif;
    }
    
    public void setMotif(String motif) {
        this.motif = motif;
    }
}
