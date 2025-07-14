package itu.web_dyn.bibliotheque.entities;

import java.io.Serializable;
import jakarta.persistence.*;

@Embeddable
public class ProlongementStatutId implements Serializable {
    private Integer idProlongement;
    private Integer idStatutProlongement;

    public ProlongementStatutId() {}

    public ProlongementStatutId(Integer idProlongement, Integer idStatutProlongement) {
        this.idProlongement = idProlongement;
        this.idStatutProlongement = idStatutProlongement;
    }

    // equals & hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProlongementStatutId that = (ProlongementStatutId) o;
        return idProlongement.equals(that.idProlongement) && 
               idStatutProlongement.equals(that.idStatutProlongement);
    }

    @Override
    public int hashCode() {
        return idProlongement.hashCode() + idStatutProlongement.hashCode();
    }

    // Getters & Setters
    public Integer getIdProlongement() {
        return idProlongement;
    }

    public void setIdProlongement(Integer idProlongement) {
        this.idProlongement = idProlongement;
    }

    public Integer getIdStatutProlongement() {
        return idStatutProlongement;
    }

    public void setIdStatutProlongement(Integer idStatutProlongement) {
        this.idStatutProlongement = idStatutProlongement;
    }
}
