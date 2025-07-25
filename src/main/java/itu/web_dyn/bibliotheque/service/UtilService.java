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


    public static boolean periodesSeChevauchent(LocalDateTime debut1, LocalDateTime fin1,
                                                LocalDateTime debut2, LocalDateTime fin2) {
        return !debut1.isAfter(fin2) && !debut2.isAfter(fin1);
    }

    public static LocalDateTime ajouterJours(LocalDateTime date, int nbJours) {
        return date.plusDays(nbJours);
    }
}
