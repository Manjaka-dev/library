package itu.web_dyn.bibliotheque.controller.api.dto;

import java.util.List;

public class LivreAvecExemplairesDTO {
    private Integer idLivre;
    private String titre;
    private String isbn;
    private String langue;
    private Integer anneePublication;
    private String synopsis;
    private Integer nbPage;
    private Integer ageRequis;
    private String auteur;
    private String editeur;
    private List<String> categories;
    private List<ExemplaireDTO> exemplaires;
    private Integer nombreExemplaires;
    
    public LivreAvecExemplairesDTO() {}
    
    public LivreAvecExemplairesDTO(Integer idLivre, String titre, String isbn, String langue, 
                                   Integer anneePublication, String synopsis, Integer nbPage, 
                                   Integer ageRequis, String auteur, String editeur, 
                                   List<String> categories, List<ExemplaireDTO> exemplaires, 
                                   Integer nombreExemplaires) {
        this.idLivre = idLivre;
        this.titre = titre;
        this.isbn = isbn;
        this.langue = langue;
        this.anneePublication = anneePublication;
        this.synopsis = synopsis;
        this.nbPage = nbPage;
        this.ageRequis = ageRequis;
        this.auteur = auteur;
        this.editeur = editeur;
        this.categories = categories;
        this.exemplaires = exemplaires;
        this.nombreExemplaires = nombreExemplaires;
    }
    
    // Getters et Setters
    public Integer getIdLivre() {
        return idLivre;
    }
    
    public void setIdLivre(Integer idLivre) {
        this.idLivre = idLivre;
    }
    
    public String getTitre() {
        return titre;
    }
    
    public void setTitre(String titre) {
        this.titre = titre;
    }
    
    public String getIsbn() {
        return isbn;
    }
    
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    public String getLangue() {
        return langue;
    }
    
    public void setLangue(String langue) {
        this.langue = langue;
    }
    
    public Integer getAnneePublication() {
        return anneePublication;
    }
    
    public void setAnneePublication(Integer anneePublication) {
        this.anneePublication = anneePublication;
    }
    
    public String getSynopsis() {
        return synopsis;
    }
    
    public void setSynopsis(String synopsis) {
        this.synopsis = synopsis;
    }
    
    public Integer getNbPage() {
        return nbPage;
    }
    
    public void setNbPage(Integer nbPage) {
        this.nbPage = nbPage;
    }
    
    public Integer getAgeRequis() {
        return ageRequis;
    }
    
    public void setAgeRequis(Integer ageRequis) {
        this.ageRequis = ageRequis;
    }
    
    public String getAuteur() {
        return auteur;
    }
    
    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }
    
    public String getEditeur() {
        return editeur;
    }
    
    public void setEditeur(String editeur) {
        this.editeur = editeur;
    }
    
    public List<String> getCategories() {
        return categories;
    }
    
    public void setCategories(List<String> categories) {
        this.categories = categories;
    }
    
    public List<ExemplaireDTO> getExemplaires() {
        return exemplaires;
    }
    
    public void setExemplaires(List<ExemplaireDTO> exemplaires) {
        this.exemplaires = exemplaires;
    }
    
    public Integer getNombreExemplaires() {
        return nombreExemplaires;
    }
    
    public void setNombreExemplaires(Integer nombreExemplaires) {
        this.nombreExemplaires = nombreExemplaires;
    }
}
