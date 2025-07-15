package itu.web_dyn.bibliotheque.controller.api.dto;

public class QuotaParTypeDTO {
    private Integer idTypePret;
    private String nomTypePret;
    private Integer quotaAutorise;
    private Integer quotaUtilise;
    private Integer quotaRestant;
    
    // Constructeurs
    public QuotaParTypeDTO() {}
    
    public QuotaParTypeDTO(Integer idTypePret, String nomTypePret, Integer quotaAutorise, 
                           Integer quotaUtilise, Integer quotaRestant) {
        this.idTypePret = idTypePret;
        this.nomTypePret = nomTypePret;
        this.quotaAutorise = quotaAutorise;
        this.quotaUtilise = quotaUtilise;
        this.quotaRestant = quotaRestant;
    }
    
    // Getters et Setters
    public Integer getIdTypePret() {
        return idTypePret;
    }
    
    public void setIdTypePret(Integer idTypePret) {
        this.idTypePret = idTypePret;
    }
    
    public String getNomTypePret() {
        return nomTypePret;
    }
    
    public void setNomTypePret(String nomTypePret) {
        this.nomTypePret = nomTypePret;
    }
    
    public Integer getQuotaAutorise() {
        return quotaAutorise;
    }
    
    public void setQuotaAutorise(Integer quotaAutorise) {
        this.quotaAutorise = quotaAutorise;
    }
    
    public Integer getQuotaUtilise() {
        return quotaUtilise;
    }
    
    public void setQuotaUtilise(Integer quotaUtilise) {
        this.quotaUtilise = quotaUtilise;
    }
    
    public Integer getQuotaRestant() {
        return quotaRestant;
    }
    
    public void setQuotaRestant(Integer quotaRestant) {
        this.quotaRestant = quotaRestant;
    }
}
