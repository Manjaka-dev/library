package itu.web_dyn.bibliotheque.test;

import java.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Penalite;
import itu.web_dyn.bibliotheque.service.AdherantService;
import itu.web_dyn.bibliotheque.service.PenaliteService;

/**
 * Test du système de pénalité
 * Pour l'activer, décommentez l'annotation @Component
 */
//@Component
public class PenaliteSystemTest implements CommandLineRunner {

    @Autowired
    private PenaliteService penaliteService;
    
    @Autowired
    private AdherantService adherantService;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("=== TEST DU SYSTÈME DE PÉNALITÉ ===");
        
        // Test 1: Créer une pénalité de test
        testCreatePenalite();
        
        // Test 2: Vérifier si un adhérent est pénalisé
        testIsPenalise();
        
        // Test 3: Calcul automatique de pénalité
        testCalculAutomatique();
        
        System.out.println("=== FIN DES TESTS ===");
    }
    
    private void testCreatePenalite() {
        System.out.println("\n--- Test 1: Création d'une pénalité ---");
        
        try {
            // Récupérer le premier adhérent
            Adherant adherant = adherantService.findById(1);
            if (adherant != null) {
                // Créer une pénalité de 7 jours
                Penalite penalite = new Penalite(adherant, 7, LocalDateTime.now());
                penaliteService.save(penalite);
                
                System.out.println("✓ Pénalité créée avec succès");
                System.out.println("  - Adhérent: " + adherant.getNomAdherant() + " " + adherant.getPrenomAdherant());
                System.out.println("  - Durée: 7 jours");
                System.out.println("  - Date début: " + penalite.getDatePenalite());
            } else {
                System.out.println("✗ Aucun adhérent trouvé pour le test");
            }
        } catch (Exception e) {
            System.out.println("✗ Erreur lors de la création: " + e.getMessage());
        }
    }
    
    private void testIsPenalise() {
        System.out.println("\n--- Test 2: Vérification pénalité ---");
        
        try {
            // Vérifier si l'adhérent 1 est pénalisé
            boolean penalise = penaliteService.isPenalise(LocalDateTime.now(), 1);
            System.out.println("✓ Vérification effectuée");
            System.out.println("  - Adhérent ID 1 pénalisé: " + (penalise ? "OUI" : "NON"));
            
            // Vérifier dans 8 jours (après la pénalité)
            LocalDateTime futur = LocalDateTime.now().plusDays(8);
            boolean penaliseFutur = penaliteService.isPenalise(futur, 1);
            System.out.println("  - Adhérent ID 1 pénalisé dans 8 jours: " + (penaliseFutur ? "OUI" : "NON"));
            
        } catch (Exception e) {
            System.out.println("✗ Erreur lors de la vérification: " + e.getMessage());
        }
    }
    
    private void testCalculAutomatique() {
        System.out.println("\n--- Test 3: Calcul automatique ---");
        
        try {
            // Test avec jours ouvrables
            System.out.println("⚠ Test de calcul automatique avec jours ouvrables");
            System.out.println("  - Calcul en jours ouvrables (excluant weekends et jours fériés)");
            System.out.println("  - Pour tester, utilisez l'interface web des retours");
            System.out.println("  - Le système calculera automatiquement les pénalités en jours ouvrables");
            
        } catch (Exception e) {
            System.out.println("✗ Erreur lors du calcul: " + e.getMessage());
        }
    }
}
