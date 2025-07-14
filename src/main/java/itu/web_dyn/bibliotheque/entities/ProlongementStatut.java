package itu.web_dyn.bibliotheque.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "prolongement_statut")
public class ProlongementStatut {
    @EmbeddedId
    private ProlongementStatutId id;

    @ManyToOne
    @MapsId("idProlongement")
    @JoinColumn(name = "id_prolongement")
    private Prolongement prolongement;

    @ManyToOne
    @MapsId("idStatutProlongement")
    @JoinColumn(name = "id_statut_prolongement")
    private StatutProlongement statutProlongement;

    // Constructeurs
    public ProlongementStatut() {}

    public ProlongementStatut(ProlongementStatutId id, Prolongement prolongement, StatutProlongement statutProlongement) {
        this.id = id;
        this.prolongement = prolongement;
        this.statutProlongement = statutProlongement;
    }

    // Getters & Setters
    public ProlongementStatutId getId() {
        return id;
    }

    public void setId(ProlongementStatutId id) {
        this.id = id;
    }

    public Prolongement getProlongement() {
        return prolongement;
    }

    public void setProlongement(Prolongement prolongement) {
        this.prolongement = prolongement;
    }

    public StatutProlongement getStatutProlongement() {
        return statutProlongement;
    }

    public void setStatutProlongement(StatutProlongement statutProlongement) {
        this.statutProlongement = statutProlongement;
    }
}
