package itu.project.library.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "fin_pret")
public class FinPret {
    
    @Id
    @Column(name = "id_fin_pret")
    private Integer idFinPret;
    
    @Column(name = "date_fin")
    private LocalDateTime dateFin;
    
    @ManyToOne
    @JoinColumn(name = "id_pret", nullable = false)
    private Pret pret;
    
    // Constructeurs
    public FinPret() {}
    
    public FinPret(Integer idFinPret, LocalDateTime dateFin, Pret pret) {
        this.idFinPret = idFinPret;
        this.dateFin = dateFin;
        this.pret = pret;
    }
    
    // Getters et Setters
    public Integer getIdFinPret() {
        return idFinPret;
    }
    
    public void setIdFinPret(Integer idFinPret) {
        this.idFinPret = idFinPret;
    }
    
    public LocalDateTime getDateFin() {
        return dateFin;
    }
    
    public void setDateFin(LocalDateTime dateFin) {
        this.dateFin = dateFin;
    }
    
    public Pret getPret() {
        return pret;
    }
    
    public void setPret(Pret pret) {
        this.pret = pret;
    }
}
