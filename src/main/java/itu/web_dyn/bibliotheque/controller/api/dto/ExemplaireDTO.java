package itu.web_dyn.bibliotheque.controller.api.dto;

public class ExemplaireDTO {
    private Integer idExemplaire;
    private Integer idLivre;
    private String titreLivre;
    private Boolean disponible;
    
    public ExemplaireDTO() {}
    
    public ExemplaireDTO(Integer idExemplaire, Integer idLivre, String titreLivre, Boolean disponible) {
        this.idExemplaire = idExemplaire;
        this.idLivre = idLivre;
        this.titreLivre = titreLivre;
        this.disponible = disponible;
    }
    
    // Getters et Setters
    public Integer getIdExemplaire() {
        return idExemplaire;
    }
    
    public void setIdExemplaire(Integer idExemplaire) {
        this.idExemplaire = idExemplaire;
    }
    
    public Integer getIdLivre() {
        return idLivre;
    }
    
    public void setIdLivre(Integer idLivre) {
        this.idLivre = idLivre;
    }
    
    public String getTitreLivre() {
        return titreLivre;
    }
    
    public void setTitreLivre(String titreLivre) {
        this.titreLivre = titreLivre;
    }
    
    public Boolean getDisponible() {
        return disponible;
    }
    
    public void setDisponible(Boolean disponible) {
        this.disponible = disponible;
    }
}
