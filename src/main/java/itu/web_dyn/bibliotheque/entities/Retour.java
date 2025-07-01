package itu.web_dyn.bibliotheque.entities;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "retour")
public class Retour {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_retour")
    private Integer idRetour;

    @Column(name = "date_retour")
    private LocalDateTime dateRetour;

    @OneToOne
    @JoinColumn(name = "id_pret", nullable = false)
    private Pret pret;

    @ManyToOne
    @JoinColumn(name = "id_type_retour", nullable = false)
    private TypeRetour typeRetour;

    public Retour() {}

    public Retour(Integer idRetour, LocalDateTime dateRetour, Pret pret) {
        this.idRetour = idRetour;
        this.dateRetour = dateRetour;
        this.pret = pret;
    }

    public Integer getIdRetour() {
        return idRetour;
    }

    public void setIdRetour(Integer idRetour) {
        this.idRetour = idRetour;
    }

    public LocalDateTime getDateRetour() {
        return dateRetour;
    }

    public void setDateRetour(LocalDateTime dateRetour) {
        this.dateRetour = dateRetour;
    }

    public Pret getPret() {
        return pret;
    }

    public void setPret(Pret pret) {
        this.pret = pret;
    }

}
