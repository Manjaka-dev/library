package itu.web_dyn.bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "categorie")
public class Categorie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_categorie")
    private Integer idCategorie;
    
    @Column(name = "nom_categorie", nullable = false)
    private Integer nomCategorie;
    
    // Constructeurs
    public Categorie() {}
    
    public Categorie(Integer idCategorie, Integer nomCategorie) {
        this.idCategorie = idCategorie;
        this.nomCategorie = nomCategorie;
    }
    
    // Getters et Setters
    public Integer getIdCategorie() {
        return idCategorie;
    }
    
    public void setIdCategorie(Integer idCategorie) {
        this.idCategorie = idCategorie;
    }
    
    public Integer getNomCategorie() {
        return nomCategorie;
    }
    
    public void setNomCategorie(Integer nomCategorie) {
        this.nomCategorie = nomCategorie;
    }
}
