package itu.web_dyn.bibliotheque.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import itu.web_dyn.bibliotheque.controller.api.dto.LivreAvecExemplairesDTO;

@RestController
@RequestMapping("/api/test")
public class TestApiController {
    
    @Autowired
    private LivreApiController livreApiController;
    
    @GetMapping("/livres")
    public ResponseEntity<String> testLivresApi() {
        try {
            ResponseEntity<List<LivreAvecExemplairesDTO>> response = livreApiController.getAllLivresAvecExemplaires();
            
            if (response.getStatusCode().is2xxSuccessful()) {
                List<LivreAvecExemplairesDTO> livres = response.getBody();
                return ResponseEntity.ok("API test réussi! Nombre de livres: " + (livres != null ? livres.size() : 0));
            } else {
                return ResponseEntity.ok("API test échoué avec le status: " + response.getStatusCode());
            }
        } catch (Exception e) {
            return ResponseEntity.ok("Erreur lors du test API: " + e.getMessage());
        }
    }
    
    @GetMapping("/status")
    public ResponseEntity<String> testStatus() {
        return ResponseEntity.ok("API Test Controller est opérationnel");
    }
}
