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
@Table(name = "prolongement")
public class Prolongement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_prolongement")
    private Integer idProlongement;
    
    @Column(name = "date_fin")
    private LocalDateTime dateFin;
    
    @ManyToOne
    @JoinColumn(name = "id_pret", nullable = false)
    private Pret pret;
    
    // Constructeurs
    public Prolongement() {}
    
    public Prolongement(Integer idProlongement, LocalDateTime dateFin, Pret pret) {
        this.idProlongement = idProlongement;
        this.dateFin = dateFin;
        this.pret = pret;
    }

    public Prolongement(LocalDateTime dateFin, Pret pret) {
        this.dateFin = dateFin;
        this.pret = pret;
    }
    
    // Getters et Setters
    public Integer getIdProlongement() {
        return idProlongement;
    }
    
    public void setIdProlongement(Integer idProlongement) {
        this.idProlongement = idProlongement;
    }
    
    public LocalDateTime getDateFin() {
        return dateFin;
    }
    
    public void setDateFin(LocalDateTime dateFin) {
        this.dateFin = dateFin;
    }
    
    public Pret getPret() {
        return pret;
    }
    
    public void setPret(Pret pret) {
        this.pret = pret;
    }
}
