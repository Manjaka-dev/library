package itu.web_dyn.bibliotheque.controller.api;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import itu.web_dyn.bibliotheque.controller.api.dto.ExemplaireDTO;
import itu.web_dyn.bibliotheque.controller.api.dto.LivreAvecExemplairesDTO;
import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.service.ExemplaireService;
import itu.web_dyn.bibliotheque.service.LivreService;

@RestController
@RequestMapping("/api/livres")
public class LivreApiController {
    
    @Autowired
    private LivreService livreService;
    
    @Autowired
    private ExemplaireService exemplaireService;
    
    /**
     * Obtenir la liste de tous les livres avec leurs exemplaires
     * 
     * @return Liste des livres avec leurs exemplaires
     */
    @GetMapping
    public ResponseEntity<List<LivreAvecExemplairesDTO>> getAllLivresAvecExemplaires() {
        try {
            List<Livre> livres = livreService.findAll();
            
            List<LivreAvecExemplairesDTO> livresAvecExemplaires = livres.stream()
                .map(this::convertirLivreAvecExemplaires)
                .collect(Collectors.toList());
            
            return ResponseEntity.ok(livresAvecExemplaires);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
    
    /**
     * Obtenir un livre spécifique avec ses exemplaires
     * 
     * @param id ID du livre
     * @return Livre avec ses exemplaires
     */
    @GetMapping("/{id}")
    public ResponseEntity<LivreAvecExemplairesDTO> getLivreAvecExemplaires(@PathVariable Integer id) {
        try {
            Livre livre = livreService.findById(id);
            if (livre == null) {
                return ResponseEntity.notFound().build();
            }
            
            LivreAvecExemplairesDTO livreAvecExemplaires = convertirLivreAvecExemplaires(livre);
            return ResponseEntity.ok(livreAvecExemplaires);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
    
    /**
     * Obtenir seulement les exemplaires d'un livre
     * 
     * @param id ID du livre
     * @return Liste des exemplaires du livre
     */
    @GetMapping("/{id}/exemplaires")
    public ResponseEntity<List<ExemplaireDTO>> getExemplairesParLivre(@PathVariable Integer id) {
        try {
            Livre livre = livreService.findById(id);
            if (livre == null) {
                return ResponseEntity.notFound().build();
            }
            
            List<Exemplaire> exemplaires = exemplaireService.findAllExemplaireByIdLivre(id);
            List<ExemplaireDTO> exemplairesDTO = exemplaires.stream()
                .map(this::convertirExemplaire)
                .collect(Collectors.toList());
            
            return ResponseEntity.ok(exemplairesDTO);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
    
    /**
     * Convertir un livre en DTO avec ses exemplaires
     */
    private LivreAvecExemplairesDTO convertirLivreAvecExemplaires(Livre livre) {
        List<Exemplaire> exemplaires = exemplaireService.findAllExemplaireByIdLivre(livre.getIdLivre());
        
        List<ExemplaireDTO> exemplairesDTO = exemplaires.stream()
            .map(this::convertirExemplaire)
            .collect(Collectors.toList());
        
        return new LivreAvecExemplairesDTO(
            livre.getIdLivre(),
            livre.getTitre(),
            livre.getIsbn(),
            livre.getLangue(),
            livre.getAnneePublication(),
            livre.getSynopsis(),
            livre.getNbPage(),
            livre.getAgeRequis(),
            livre.getAuteur() != null ? livre.getAuteur().getNomAuteur() + " " + livre.getAuteur().getPrenomAuteur() : null,
            livre.getEditeur() != null ? livre.getEditeur().getNomEditeur() : null,
            livre.getCategories() != null ? 
                livre.getCategories().stream()
                    .map(cat -> cat.getNomCategorie())
                    .collect(Collectors.toList()) : null,
            exemplairesDTO,
            exemplairesDTO.size()
        );
    }
    
    /**
     * Convertir un exemplaire en DTO
     */
    private ExemplaireDTO convertirExemplaire(Exemplaire exemplaire) {
        return new ExemplaireDTO(
            exemplaire.getIdExemplaire(),
            exemplaire.getLivre().getIdLivre(),
            exemplaire.getLivre().getTitre()
        );
    }
}
