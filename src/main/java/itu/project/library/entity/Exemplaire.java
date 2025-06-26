package itu.project.library.entity;

import javax.persistence.*;

@Entity
@Table(name = "exemplaire")
public class Exemplaire {
    
    @Id
    @Column(name = "id_exemplaire")
    private Integer idExemplaire;
    
    @ManyToOne
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre livre;
    
    // Constructeurs
    public Exemplaire() {}
    
    public Exemplaire(Integer idExemplaire, Livre livre) {
        this.idExemplaire = idExemplaire;
        this.livre = livre;
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
}
