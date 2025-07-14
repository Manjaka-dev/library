package itu.web_dyn.bibliotheque.service;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.stereotype.Service;

@Service
public class UtilService {
    public static LocalDateTime toDateTimeWithCurrentTime(LocalDate date) {
        LocalTime heureActuelle = LocalTime.now();

        return date.atTime(heureActuelle);
    }
    
    // Méthode manquante pour ajouter des jours à une LocalDateTime
    public static LocalDateTime ajouterJours(LocalDateTime dateTime, int jours) {
        return dateTime.plusDays(jours);
    }
}
