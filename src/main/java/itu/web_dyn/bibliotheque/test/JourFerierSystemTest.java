package itu.web_dyn.bibliotheque.test;

import java.time.LocalDate;
import java.time.DayOfWeek;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import itu.web_dyn.bibliotheque.entities.JourFerier;
import itu.web_dyn.bibliotheque.service.JourFerierService;

/**
 * Test du système de jours fériés
 * Pour l'activer, décommentez l'annotation @Component
 */
//@Component
public class JourFerierSystemTest implements CommandLineRunner {

    @Autowired
    private JourFerierService jourFerierService;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("=== TEST DU SYSTÈME DE JOURS FÉRIÉS ===");
        
        // Test 1: Créer des jours fériés de test
        testCreateJoursFerier();
        
        // Test 2: Vérifier les weekends
        testWeekend();
        
        // Test 3: Vérifier les jours fériés
        testJoursFerier();
        
        // Test 4: Calcul des jours ouvrables
        testCalculJoursOuvrables();
        
        // Test 5: Ajout de jours ouvrables
        testAjouterJoursOuvrables();
        
        System.out.println("=== FIN DES TESTS ===");
    }
    
    private void testCreateJoursFerier() {
        System.out.println("\n--- Test 1: Création de jours fériés ---");
        
        try {
            // Créer quelques jours fériés de test
            List<JourFerier> joursTest = Arrays.asList(
                new JourFerier("Test Jour Férié 1", LocalDate.of(2025, 7, 16), 2025, false),
                new JourFerier("Test Jour Férié Récurrent", LocalDate.of(2025, 12, 25), 2025, true)
            );
            
            for (JourFerier jour : joursTest) {
                jourFerierService.save(jour);
                System.out.println("✓ Jour férié créé: " + jour.getNomJour() + " - " + jour.getDateFerier());
            }
            
        } catch (Exception e) {
            System.out.println("✗ Erreur lors de la création: " + e.getMessage());
        }
    }
    
    private void testWeekend() {
        System.out.println("\n--- Test 2: Vérification des weekends ---");
        
        try {
            // Tester différents jours de la semaine
            LocalDate[] datesTest = {
                LocalDate.of(2025, 7, 14), // Lundi
                LocalDate.of(2025, 7, 15), // Mardi
                LocalDate.of(2025, 7, 19), // Samedi
                LocalDate.of(2025, 7, 20)  // Dimanche
            };
            
            for (LocalDate date : datesTest) {
                boolean isWeekend = jourFerierService.isWeekend(date);
                DayOfWeek dayOfWeek = date.getDayOfWeek();
                System.out.println("  " + date + " (" + dayOfWeek + ") - Weekend: " + (isWeekend ? "OUI" : "NON"));
            }
            
        } catch (Exception e) {
            System.out.println("✗ Erreur lors de la vérification: " + e.getMessage());
        }
    }
    
    private void testJoursFerier() {
        System.out.println("\n--- Test 3: Vérification des jours fériés ---");
        
        try {
            // Tester différentes dates
            LocalDate[] datesTest = {
                LocalDate.of(2025, 1, 1),  // Nouvel An
                LocalDate.of(2025, 7, 14), // Fête Nationale
                LocalDate.of(2025, 12, 25), // Noël
                LocalDate.of(2025, 7, 15)   // Jour normal
            };
            
            for (LocalDate date : datesTest) {
                boolean isJourFerier = jourFerierService.isJourFerier(date);
                boolean isJourNonOuvrable = jourFerierService.isJourNonOuvrable(date);
                System.out.println("  " + date + " - Jour férié: " + (isJourFerier ? "OUI" : "NON") + 
                                 ", Non ouvrable: " + (isJourNonOuvrable ? "OUI" : "NON"));
            }
            
        } catch (Exception e) {
            System.out.println("✗ Erreur lors de la vérification: " + e.getMessage());
        }
    }
    
    private void testCalculJoursOuvrables() {
        System.out.println("\n--- Test 4: Calcul des jours ouvrables ---");
        
        try {
            // Calculer les jours ouvrables pour différentes périodes
            LocalDate[][] periodes = {
                {LocalDate.of(2025, 7, 14), LocalDate.of(2025, 7, 18)}, // Lundi à vendredi
                {LocalDate.of(2025, 7, 14), LocalDate.of(2025, 7, 20)}, // Lundi à dimanche
                {LocalDate.of(2025, 12, 23), LocalDate.of(2025, 12, 27)} // Période avec Noël
            };
            
            for (LocalDate[] periode : periodes) {
                long joursOuvrables = jourFerierService.calculerJoursOuvrables(periode[0], periode[1]);
                System.out.println("  Du " + periode[0] + " au " + periode[1] + " : " + joursOuvrables + " jours ouvrables");
            }
            
        } catch (Exception e) {
            System.out.println("✗ Erreur lors du calcul: " + e.getMessage());
        }
    }
    
    private void testAjouterJoursOuvrables() {
        System.out.println("\n--- Test 5: Ajout de jours ouvrables ---");
        
        try {
            LocalDate dateDebut = LocalDate.of(2025, 7, 15); // Mardi
            int[] joursAjouter = {1, 5, 10};
            
            for (int jours : joursAjouter) {
                LocalDate dateFin = jourFerierService.ajouterJoursOuvrables(dateDebut, jours);
                System.out.println("  " + dateDebut + " + " + jours + " jours ouvrables = " + dateFin);
            }
            
        } catch (Exception e) {
            System.out.println("✗ Erreur lors de l'ajout: " + e.getMessage());
        }
    }
}
