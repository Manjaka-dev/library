package itu.web_dyn.bibliotheque.service;

import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Penalite;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.entities.Retour;
import itu.web_dyn.bibliotheque.repository.AdherantRepository;
import itu.web_dyn.bibliotheque.repository.FinPretRepository;
import itu.web_dyn.bibliotheque.repository.PenaliteRepository;
import itu.web_dyn.bibliotheque.repository.PretRepository;
import itu.web_dyn.bibliotheque.repository.RetourRepository;

@Service
public class PenaliteService {
    @Autowired
    private PretRepository pretRepository;

    @Autowired
    private FinPretRepository finPretRepository;

    @Autowired
    private RetourRepository retourRepository;

    @Autowired
    private PenaliteRepository penaliteRepository;

    @Autowired
    private AdherantRepository adherantRepository;
    
    @Autowired
    private JourFerierService jourFerierService;

    public List<Penalite> findAll() {
        return penaliteRepository.findAll();
    }

    public Optional<Penalite> findById(Integer id) {
        return penaliteRepository.findById(id);
    }

    public List<Penalite> findByAdherantId(Integer idAdherant) {
        return penaliteRepository.findByAdherantIdAdherant(idAdherant);
    }

    public Penalite save(Penalite penalite) {
        return penaliteRepository.save(penalite);
    }

    public void deleteById(Integer id) {
        penaliteRepository.deleteById(id);
    }

    public void calculPenalite(Integer idPret) throws Exception {
        Pret pret = pretRepository.findById(idPret).orElse(null);
        if (pret == null) {
            throw new Exception("Prêt introuvable");
        }
        
        // Récupérer la date de fin du prêt
        List<FinPret> finPrets = finPretRepository.findByPretId(pret.getIdPret());
        if (finPrets.isEmpty()) {
            throw new Exception("Date de fin de prêt introuvable");
        }
        FinPret finPret = finPrets.get(finPrets.size() - 1); // Dernière date de fin
        
        // Récupérer le retour
        Retour retour = retourRepository.findByPret_IdPret(pret.getIdPret());
        if (retour == null) {
            throw new Exception("Retour introuvable");
        }
        
        // Calculer le retard en jours ouvrables
        if (retour.getDateRetour().isAfter(finPret.getDateFin())) {
            // Calculer le retard en jours ouvrables (exclut weekends et jours fériés)
            long retardJoursOuvrables = jourFerierService.calculerJoursOuvrables(
                finPret.getDateFin().toLocalDate(), 
                retour.getDateRetour().toLocalDate()
            );
            
            if (retardJoursOuvrables > 0) {
                // Récupérer la dernière pénalité de l'adhérent
                List<Penalite> penalitesExistantes = penaliteRepository.findByAdherant(pret.getAdherant());
                
                LocalDateTime datePenalite;
                if (penalitesExistantes.isEmpty()) {
                    // Pas de pénalité précédente, commence à la date de retour
                    datePenalite = retour.getDateRetour();
                } else {
                    // Récupérer la dernière pénalité
                    Penalite dernierePenalite = penalitesExistantes.stream()
                        .max(Comparator.comparing(p -> p.getDatePenalite().plusDays(p.getDuree())))
                        .orElse(null);
                    
                    if (dernierePenalite != null) {
                        LocalDateTime finDernierePenalite = dernierePenalite.getDatePenalite().plusDays(dernierePenalite.getDuree());
                        // Si la dernière pénalité n'est pas encore terminée, on continue après
                        if (finDernierePenalite.isAfter(retour.getDateRetour())) {
                            datePenalite = finDernierePenalite;
                        } else {
                            datePenalite = retour.getDateRetour();
                        }
                    } else {
                        datePenalite = retour.getDateRetour();
                    }
                }
                
                // Créer la nouvelle pénalité
                Penalite nouvellePenalite = new Penalite(pret.getAdherant(), (int)retardJoursOuvrables, datePenalite);
                penaliteRepository.save(nouvellePenalite);
                
                System.out.println("Pénalité créée: " + retardJoursOuvrables + " jours ouvrables à partir du " + datePenalite);
            }
        }
    }

    /**
     * Calcule les pénalités en tenant compte des jours ouvrables uniquement
     * @param idPret ID du prêt
     * @param calculerEnJoursOuvrables true pour calculer en jours ouvrables, false pour jours calendaires
     * @throws Exception si le prêt n'est pas trouvé
     */
    public void calculPenaliteAvecJoursOuvrables(Integer idPret, boolean calculerEnJoursOuvrables) throws Exception {
        Pret pret = pretRepository.findById(idPret).orElse(null);
        if (pret == null) {
            throw new Exception("Prêt introuvable");
        }
        
        // Récupérer la date de fin du prêt
        List<FinPret> finPrets = finPretRepository.findByPretId(pret.getIdPret());
        if (finPrets.isEmpty()) {
            throw new Exception("Date de fin de prêt introuvable");
        }
        FinPret finPret = finPrets.get(finPrets.size() - 1);
        
        // Récupérer le retour
        Retour retour = retourRepository.findByPret_IdPret(pret.getIdPret());
        if (retour == null) {
            throw new Exception("Retour introuvable");
        }
        
        // Calculer le retard
        if (retour.getDateRetour().isAfter(finPret.getDateFin())) {
            long retard;
            String typeCalcul;
            
            if (calculerEnJoursOuvrables) {
                // Calculer en jours ouvrables seulement
                retard = jourFerierService.calculerJoursOuvrables(
                    finPret.getDateFin().toLocalDate(), 
                    retour.getDateRetour().toLocalDate()
                );
                typeCalcul = "jours ouvrables";
            } else {
                // Calculer en jours calendaires (ancien comportement)
                retard = java.time.temporal.ChronoUnit.DAYS.between(finPret.getDateFin(), retour.getDateRetour());
                typeCalcul = "jours calendaires";
            }
            
            if (retard > 0) {
                // Récupérer la dernière pénalité de l'adhérent
                List<Penalite> penalitesExistantes = penaliteRepository.findByAdherant(pret.getAdherant());
                
                LocalDateTime datePenalite;
                if (penalitesExistantes.isEmpty()) {
                    datePenalite = retour.getDateRetour();
                } else {
                    Penalite dernierePenalite = penalitesExistantes.stream()
                        .max(Comparator.comparing(p -> p.getDatePenalite().plusDays(p.getDuree())))
                        .orElse(null);
                    
                    if (dernierePenalite != null) {
                        LocalDateTime finDernierePenalite = dernierePenalite.getDatePenalite().plusDays(dernierePenalite.getDuree());
                        datePenalite = finDernierePenalite.isAfter(retour.getDateRetour()) ? 
                            finDernierePenalite : retour.getDateRetour();
                    } else {
                        datePenalite = retour.getDateRetour();
                    }
                }
                
                // Créer la nouvelle pénalité
                Penalite nouvellePenalite = new Penalite(pret.getAdherant(), (int)retard, datePenalite);
                penaliteRepository.save(nouvellePenalite);
                
                System.out.println("Pénalité créée: " + retard + " " + typeCalcul + " à partir du " + datePenalite);
            }
        }
    }

    public boolean isPenalise(LocalDateTime date, Integer idAdherant){
        List<Penalite> penalites = penaliteRepository.findByAdherant(adherantRepository.findById(idAdherant).orElse(null));
        if (penalites == null || penalites.isEmpty()) {
            return false;
        }
        
        // Récupérer la pénalité la plus récente (qui se termine le plus tard)
        Penalite dernierePenalite = penalites.stream()
            .max(Comparator.comparing(penalite -> penalite.getDatePenalite().plusDays(penalite.getDuree())))
            .orElse(null);
        
        if (dernierePenalite == null) {
            return false;
        }
        
        LocalDateTime finPenalite = dernierePenalite.getDatePenalite().plusDays(dernierePenalite.getDuree());
        return finPenalite.isAfter(date);
    }
}