package itu.web_dyn.bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "type_retour")
public class TypeRetour {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_type_retour")
    private Integer idTypeRetour;

    @Column(name = "nom_type_retour", nullable = false)
    private String nomTypeRetour;

    public TypeRetour(){}

    public TypeRetour(Integer idTypeRetour, String nomTypeRetour) {
        this.idTypeRetour = idTypeRetour;
        this.nomTypeRetour = nomTypeRetour;
    }

    public Integer getIdTypeRetour() {
        return idTypeRetour;
    }

    public void setIdTypeRetour(Integer idTypeRetour) {
        this.idTypeRetour = idTypeRetour;
    }

    public String getNomTypeRetour() {
        return nomTypeRetour;
    }

    public void setNomTypeRetour(String nomTypeRetour) {
        this.nomTypeRetour = nomTypeRetour;
    }
}
