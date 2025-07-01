package itu.web_dyn.bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "examplaire")
public class Exemplaire {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_exemplaire")
    private Integer idExemplaire;
    
    @ManyToOne
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;
    
    @Column(name = "dispo")
    private Boolean dispo;
    
    // Constructeurs
    public Exemplaire() {}
    
    public Exemplaire(Integer idExemplaire, Livre livre, Boolean dispo) {
        this.idExemplaire = idExemplaire;
        this.livre = livre;
        this.dispo = dispo;
    }
    
    // Getters et Setters
    public Integer getIdExemplaire() {
        return idExemplaire;
    }
    
    public void setIdExemplaire(Integer idExemplaire) {
        this.idExemplaire = idExemplaire;
    }
    
    public Livre getLivre() {
        return livre;
    }
    
    public void setLivre(Livre livre) {
        this.livre = livre;
    }
    
    public Boolean getDispo() {
        return dispo;
    }
    
    public void setDispo(Boolean dispo) {
        this.dispo = dispo;
    }
}
