package itu.web_dyn.bibliotheque.controller.api.dto;

import java.time.LocalDate;
import java.util.List;

public class AdherantDTO {
    private Integer idAdherant;
    private String nomAdherant;
    private String prenomAdherant;
    private Integer numeroAdherant;
    private LocalDate dateNaissance;
    private String nomProfil;
    private Integer quotaPretTotal;
    private Integer quotaReservationTotal;
    private Integer quotaPretRestant;
    private Integer quotaReservationRestant;
    private List<QuotaParTypeDTO> quotasParType;
    private Boolean inscriptionActive;
    private Boolean penalise;
    
    // Constructeurs
    public AdherantDTO() {}
    
    public AdherantDTO(Integer idAdherant, String nomAdherant, String prenomAdherant, 
                       Integer numeroAdherant, LocalDate dateNaissance, String nomProfil,
                       Integer quotaPretTotal, Integer quotaReservationTotal,
                       Integer quotaPretRestant, Integer quotaReservationRestant,
                       List<QuotaParTypeDTO> quotasParType, Boolean inscriptionActive, Boolean penalise) {
        this.idAdherant = idAdherant;
        this.nomAdherant = nomAdherant;
        this.prenomAdherant = prenomAdherant;
        this.numeroAdherant = numeroAdherant;
        this.dateNaissance = dateNaissance;
        this.nomProfil = nomProfil;
        this.quotaPretTotal = quotaPretTotal;
        this.quotaReservationTotal = quotaReservationTotal;
        this.quotaPretRestant = quotaPretRestant;
        this.quotaReservationRestant = quotaReservationRestant;
        this.quotasParType = quotasParType;
        this.inscriptionActive = inscriptionActive;
        this.penalise = penalise;
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
    
    public Integer getNumeroAdherant() {
        return numeroAdherant;
    }
    
    public void setNumeroAdherant(Integer numeroAdherant) {
        this.numeroAdherant = numeroAdherant;
    }
    
    public LocalDate getDateNaissance() {
        return dateNaissance;
    }
    
    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }
    
    public String getNomProfil() {
        return nomProfil;
    }
    
    public void setNomProfil(String nomProfil) {
        this.nomProfil = nomProfil;
    }
    
    public Integer getQuotaPretTotal() {
        return quotaPretTotal;
    }
    
    public void setQuotaPretTotal(Integer quotaPretTotal) {
        this.quotaPretTotal = quotaPretTotal;
    }
    
    public Integer getQuotaReservationTotal() {
        return quotaReservationTotal;
    }
    
    public void setQuotaReservationTotal(Integer quotaReservationTotal) {
        this.quotaReservationTotal = quotaReservationTotal;
    }
    
    public Integer getQuotaPretRestant() {
        return quotaPretRestant;
    }
    
    public void setQuotaPretRestant(Integer quotaPretRestant) {
        this.quotaPretRestant = quotaPretRestant;
    }
    
    public Integer getQuotaReservationRestant() {
        return quotaReservationRestant;
    }
    
    public void setQuotaReservationRestant(Integer quotaReservationRestant) {
        this.quotaReservationRestant = quotaReservationRestant;
    }
    
    public List<QuotaParTypeDTO> getQuotasParType() {
        return quotasParType;
    }
    
    public void setQuotasParType(List<QuotaParTypeDTO> quotasParType) {
        this.quotasParType = quotasParType;
    }
    
    public Boolean getInscriptionActive() {
        return inscriptionActive;
    }
    
    public void setInscriptionActive(Boolean inscriptionActive) {
        this.inscriptionActive = inscriptionActive;
    }
    
    public Boolean getPenalise() {
        return penalise;
    }
    
    public void setPenalise(Boolean penalise) {
        this.penalise = penalise;
    }
}
