package itu.web_dyn.bibliotheque.entities;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "jour_ferier")
public class JourFerier {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_jour_ferier")
    private Integer idJourFerier;
    
    @Column(name = "nom_jour", nullable = false, length = 100)
    private String nomJour;
    
    @Column(name = "date_ferier", nullable = false)
    private LocalDate dateFerier;
    
    @Column(name = "annee", nullable = false)
    private Integer annee;
    
    @Column(name = "recurrent", nullable = false)
    private Boolean recurrent = false;
    
    // Constructeurs
    public JourFerier() {}
    
    public JourFerier(String nomJour, LocalDate dateFerier, Integer annee, Boolean recurrent) {
        this.nomJour = nomJour;
        this.dateFerier = dateFerier;
        this.annee = annee;
        this.recurrent = recurrent;
    }
    
    // Getters et Setters
    public Integer getIdJourFerier() {
        return idJourFerier;
    }
    
    public void setIdJourFerier(Integer idJourFerier) {
        this.idJourFerier = idJourFerier;
    }
    
    public String getNomJour() {
        return nomJour;
    }
    
    public void setNomJour(String nomJour) {
        this.nomJour = nomJour;
    }
    
    public LocalDate getDateFerier() {
        return dateFerier;
    }
    
    public void setDateFerier(LocalDate dateFerier) {
        this.dateFerier = dateFerier;
        if (dateFerier != null) {
            this.annee = dateFerier.getYear();
        }
    }
    
    public Integer getAnnee() {
        return annee;
    }
    
    public void setAnnee(Integer annee) {
        this.annee = annee;
    }
    
    public Boolean getRecurrent() {
        return recurrent;
    }
    
    public void setRecurrent(Boolean recurrent) {
        this.recurrent = recurrent;
    }
    
    @Override
    public String toString() {
        return "JourFerier{" +
                "idJourFerier=" + idJourFerier +
                ", nomJour='" + nomJour + '\'' +
                ", dateFerier=" + dateFerier +
                ", annee=" + annee +
                ", recurrent=" + recurrent +
                '}';
    }
}
