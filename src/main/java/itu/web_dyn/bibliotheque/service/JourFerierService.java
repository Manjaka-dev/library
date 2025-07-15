package itu.web_dyn.bibliotheque.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.JourFerier;
import itu.web_dyn.bibliotheque.repository.JourFerierRepository;

@Service
public class JourFerierService {
    
    @Autowired
    private JourFerierRepository jourFerierRepository;
    
    public List<JourFerier> findAll() {
        return jourFerierRepository.findAll();
    }
    
    public JourFerier findById(Integer id) {
        return jourFerierRepository.findById(id).orElse(null);
    }
    
    public List<JourFerier> findByAnnee(Integer annee) {
        return jourFerierRepository.findByAnnee(annee);
    }
    
    public List<JourFerier> findJoursFeriersAnnee(Integer annee) {
        return jourFerierRepository.findJoursFeriersAnnee(annee);
    }
    
    public JourFerier save(JourFerier jourFerier) {
        return jourFerierRepository.save(jourFerier);
    }
    
    public void deleteById(Integer id) {
        jourFerierRepository.deleteById(id);
    }
    
    /**
     * Vérifie si une date est un jour férié
     */
    public boolean isJourFerier(LocalDate date) {
        return jourFerierRepository.isJourFerier(date);
    }
    
    /**
     * Vérifie si une date est un weekend (samedi ou dimanche)
     */
    public boolean isWeekend(LocalDate date) {
        DayOfWeek dayOfWeek = date.getDayOfWeek();
        return dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY;
    }
    
    /**
     * Vérifie si une date est un jour non-ouvrable (weekend ou jour férié)
     */
    public boolean isJourNonOuvrable(LocalDate date) {
        return isWeekend(date) || isJourFerier(date);
    }
    
    /**
     * Calcule le nombre de jours ouvrables entre deux dates
     * (exclut les weekends et jours fériés)
     */
    public long calculerJoursOuvrables(LocalDate debut, LocalDate fin) {
        if (debut.isAfter(fin)) {
            return 0;
        }
        
        long joursOuvrables = 0;
        LocalDate dateCourante = debut;
        
        while (!dateCourante.isAfter(fin)) {
            if (!isJourNonOuvrable(dateCourante)) {
                joursOuvrables++;
            }
            dateCourante = dateCourante.plusDays(1);
        }
        
        return joursOuvrables;
    }
    
    /**
     * Trouve le prochain jour ouvrable à partir d'une date donnée
     */
    public LocalDate prochainJourOuvrable(LocalDate date) {
        LocalDate prochainJour = date.plusDays(1);
        while (isJourNonOuvrable(prochainJour)) {
            prochainJour = prochainJour.plusDays(1);
        }
        return prochainJour;
    }
    
    /**
     * Ajoute un nombre de jours ouvrables à une date
     */
    public LocalDate ajouterJoursOuvrables(LocalDate dateDebut, int joursOuvrables) {
        LocalDate dateCourante = dateDebut;
        int joursAjoutes = 0;
        
        while (joursAjoutes < joursOuvrables) {
            dateCourante = dateCourante.plusDays(1);
            if (!isJourNonOuvrable(dateCourante)) {
                joursAjoutes++;
            }
        }
        
        return dateCourante;
    }
}
