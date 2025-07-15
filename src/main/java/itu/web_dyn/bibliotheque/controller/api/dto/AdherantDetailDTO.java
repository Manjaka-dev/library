package itu.web_dyn.bibliotheque.controller.api.dto;

public class AdherantDetailDTO {
    private Integer idAdherant;
    private Integer numeroAdherant;
    private String nomAdherant;
    private String prenomAdherant;
    private String dateNaissance;
    private String profil;
    private Integer idProfil;
    private Integer quotaTotalPret;
    private Integer pretsUtilises;
    private Integer pretsRestants;
    private Integer quotaTotalReservation;
    private Integer reservationsUtilisees;
    private Integer reservationsRestantes;
    
    // Constructeurs
    public AdherantDetailDTO() {}
    
    public AdherantDetailDTO(Integer idAdherant, Integer numeroAdherant, String nomAdherant, 
                           String prenomAdherant, String dateNaissance, String profil, 
                           Integer idProfil, Integer quotaTotalPret, Integer pretsUtilises, 
                           Integer pretsRestants, Integer quotaTotalReservation, 
                           Integer reservationsUtilisees, Integer reservationsRestantes) {
        this.idAdherant = idAdherant;
        this.numeroAdherant = numeroAdherant;
        this.nomAdherant = nomAdherant;
        this.prenomAdherant = prenomAdherant;
        this.dateNaissance = dateNaissance;
        this.profil = profil;
        this.idProfil = idProfil;
        this.quotaTotalPret = quotaTotalPret;
        this.pretsUtilises = pretsUtilises;
        this.pretsRestants = pretsRestants;
        this.quotaTotalReservation = quotaTotalReservation;
        this.reservationsUtilisees = reservationsUtilisees;
        this.reservationsRestantes = reservationsRestantes;
    }
    
    // Getters et Setters
    public Integer getIdAdherant() {
        return idAdherant;
    }
    
    public void setIdAdherant(Integer idAdherant) {
        this.idAdherant = idAdherant;
    }
    
    public String getNomAdherant() {
        return nomAdherant;
    }
    
    public void setNomAdherant(String nomAdherant) {
        this.nomAdherant = nomAdherant;
    }
    
    public String getPrenomAdherant() {
        return prenomAdherant;
    }
    
    public void setPrenomAdherant(String prenomAdherant) {
        this.prenomAdherant = prenomAdherant;
    }
    
    public String getProfil() {
        return profil;
    }
    
    public void setProfil(String profil) {
        this.profil = profil;
    }
    
    public Integer getQuotaTotalPret() {
        return quotaTotalPret;
    }
    
    public void setQuotaTotalPret(Integer quotaTotalPret) {
        this.quotaTotalPret = quotaTotalPret;
    }
    
    public Integer getPretsUtilises() {
        return pretsUtilises;
    }
    
    public void setPretsUtilises(Integer pretsUtilises) {
        this.pretsUtilises = pretsUtilises;
    }
    
    public Integer getPretsRestants() {
        return pretsRestants;
    }
    
    public void setPretsRestants(Integer pretsRestants) {
        this.pretsRestants = pretsRestants;
    }
    
    public Integer getQuotaTotalReservation() {
        return quotaTotalReservation;
    }
    
    public void setQuotaTotalReservation(Integer quotaTotalReservation) {
        this.quotaTotalReservation = quotaTotalReservation;
    }
    
    public Integer getReservationsUtilisees() {
        return reservationsUtilisees;
    }
    
    public void setReservationsUtilisees(Integer reservationsUtilisees) {
        this.reservationsUtilisees = reservationsUtilisees;
    }
    
    public Integer getReservationsRestantes() {
        return reservationsRestantes;
    }
    
    public void setReservationsRestantes(Integer reservationsRestantes) {
        this.reservationsRestantes = reservationsRestantes;
    }

    public Integer getNumeroAdherant() {
        return numeroAdherant;
    }

    public void setNumeroAdherant(Integer numeroAdherant) {
        this.numeroAdherant = numeroAdherant;
    }

    public String getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(String dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public Integer getIdProfil() {
        return idProfil;
    }

    public void setIdProfil(Integer idProfil) {
        this.idProfil = idProfil;
    }
}
