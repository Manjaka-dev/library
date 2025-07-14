package itu.web_dyn.bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "type_pret")
public class TypePret {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_type_pret")
    private Integer idTypePret;
    
    @Column(name = "type", length = 50)
    private String type;
    
    @Column(name = "duree_jours")
    private Integer dureeJours;
    
    // Constructeurs
    public TypePret() {}
    
    public TypePret(Integer idTypePret, String type, Integer dureeJours) {
        this.idTypePret = idTypePret;
        this.type = type;
        this.dureeJours = dureeJours;
    }
    
    // Getters et Setters
    public Integer getIdTypePret() {
        return idTypePret;
    }
    
    public void setIdTypePret(Integer idTypePret) {
        this.idTypePret = idTypePret;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public Integer getDureeJours() {
        return dureeJours;
    }
    
    public void setDureeJours(Integer dureeJours) {
        this.dureeJours = dureeJours;
    }
}
