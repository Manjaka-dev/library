package itu.web_dyn.bibliotheque.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.web_dyn.bibliotheque.entities.JourFerier;

@Repository
public interface JourFerierRepository extends JpaRepository<JourFerier, Integer> {
    
    // Trouver les jours fériés par année
    List<JourFerier> findByAnnee(Integer annee);
    
    // Trouver les jours fériés récurrents
    List<JourFerier> findByRecurrent(Boolean recurrent);
    
    // Vérifier si une date est un jour férié
    @Query("SELECT COUNT(j) > 0 FROM JourFerier j WHERE j.dateFerier = :date OR (j.recurrent = true AND MONTH(j.dateFerier) = MONTH(:date) AND DAY(j.dateFerier) = DAY(:date))")
    boolean isJourFerier(@Param("date") LocalDate date);
    
    // Récupérer tous les jours fériés pour une période
    @Query("SELECT j FROM JourFerier j WHERE j.dateFerier BETWEEN :debut AND :fin OR (j.recurrent = true AND YEAR(:debut) <= YEAR(j.dateFerier) AND YEAR(:fin) >= YEAR(j.dateFerier))")
    List<JourFerier> findJoursFeriersPeriode(@Param("debut") LocalDate debut, @Param("fin") LocalDate fin);
    
    // Récupérer les jours fériés pour une année donnée (y compris les récurrents)
    @Query("SELECT j FROM JourFerier j WHERE j.annee = :annee OR (j.recurrent = true)")
    List<JourFerier> findJoursFeriersAnnee(@Param("annee") Integer annee);
}
