package itu.web_dyn.bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "statut_prolongement")
public class StatutProlongement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_statut_prolongement")
    private Integer idStatutProlongement;
    
    @Column(name = "nom_statut", length = 50)
    private String nomStatut;
    
    // Constructeurs
    public StatutProlongement() {}
    
    public StatutProlongement(Integer idStatutProlongement, String nomStatut) {
        this.idStatutProlongement = idStatutProlongement;
        this.nomStatut = nomStatut;
    }
    
    // Getters et Setters
    public Integer getIdStatutProlongement() {
        return idStatutProlongement;
    }
    
    public void setIdStatutProlongement(Integer idStatutProlongement) {
        this.idStatutProlongement = idStatutProlongement;
    }
    
    public String getNomStatut() {
        return nomStatut;
    }
    
    public void setNomStatut(String nomStatut) {
        this.nomStatut = nomStatut;
    }
}
