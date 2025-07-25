package itu.web_dyn.bibliotheque.entities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "pret")
public class Pret {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pret")
    private Integer idPret;
    
    @Column(name = "date_debut")
    private LocalDateTime dateDebut;
    
    @ManyToOne
    @JoinColumn(name = "id_admin", nullable = false)
    private Admin admin;
    
    @ManyToOne
    @JoinColumn(name = "id_type_pret", nullable = false)
    private TypePret typePret;
    
    @ManyToOne
    @JoinColumn(name = "id_exemplaire", nullable = false)
    private Exemplaire exemplaire;
    
    @ManyToOne
    @JoinColumn(name = "id_adherant", nullable = false)
    private Adherant adherant;
    
    // Constructeurs
    public Pret() {}
    
    public Pret(Integer idPret, LocalDateTime dateDebut, Admin admin, 
                TypePret typePret, Exemplaire exemplaire, Adherant adherant) {
        this.idPret = idPret;
        this.dateDebut = dateDebut;
        this.admin = admin;
        this.typePret = typePret;
        this.exemplaire = exemplaire;
        this.adherant = adherant;
    }
    
    public Pret(LocalDateTime dateDebut, Admin admin, 
                TypePret typePret, Exemplaire exemplaire, Adherant adherant) {
        this.dateDebut = dateDebut;
        this.admin = admin;
        this.typePret = typePret;
        this.exemplaire = exemplaire;
        this.adherant = adherant;
    }
    
    // Getters et Setters
    public Integer getIdPret() {
        return idPret;
    }
    
    public void setIdPret(Integer idPret) {
        this.idPret = idPret;
    }
    
    public LocalDateTime getDateDebut() {
        return dateDebut;
    }
    
    public void setDateDebut(LocalDateTime dateDebut) {
        this.dateDebut = dateDebut;
    }
    
    public Admin getAdmin() {
        return admin;
    }
    
    public void setAdmin(Admin admin) {
        this.admin = admin;
    }
    
    public TypePret getTypePret() {
        return typePret;
    }
    
    public void setTypePret(TypePret typePret) {
        this.typePret = typePret;
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
    
    // Méthodes pour formatage des dates
    public String getDateDebutFormattee() {
        if (dateDebut != null) {
            return dateDebut.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return "";
    }
    
    public String getDateDebutFormatteeLongue() {
        if (dateDebut != null) {
            return dateDebut.format(DateTimeFormatter.ofPattern("dd/MM/yyyy 'à' HH:mm"));
        }
        return "";
    }
    
    public String getDateDebutFormatteeCourte() {
        if (dateDebut != null) {
            return dateDebut.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        }
        return "";
    }
}
