package itu.web_dyn.bibliotheque.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.DureePret;
import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.entities.Reservation;
import itu.web_dyn.bibliotheque.repository.DureePretRepository;
import itu.web_dyn.bibliotheque.repository.FinPretRepository;
import itu.web_dyn.bibliotheque.repository.PretRepository;
import itu.web_dyn.bibliotheque.repository.ReservationRepository;

@Service
public class ProlongementService {

    @Autowired
    PretRepository pretRepository;
    @Autowired
    DureePretRepository dureePretRepository;
    @Autowired
    ReservationRepository reservationRepository;
    @Autowired
    FinPretRepository finPretRepository;

    public void prologerPret(Integer idPret, LocalDateTime dateTime) throws Exception{
        Pret currentPret = pretRepository.findById(idPret).orElse(null);
        DureePret dureePret = dureePretRepository.findAll().getLast();

        if (dureePret == null) {
            throw new Exception("Aucune durée de prêt définie");
        }
        if (currentPret != null) {
            List<FinPret> finPrets = finPretRepository.findByPretId(currentPret.getIdPret());
            if (finPrets.size() >= 2) {
                throw new Exception("Pret deja prolonger");
            }
            if (currentPret.getDateDebut().plusDays(dureePret.getDuree()).isAfter(dateTime)) {
                throw new Exception("La non valide");
            }
            List<Reservation> reservations = reservationRepository.findByDateDeReservationBetween(dateTime, dateTime.plusDays(dureePret.getDuree()));
            if (!reservations.isEmpty()) {
                throw new Exception("Prolongement impossible. Date deja reserver");
            }
            FinPret newFin = new FinPret(dateTime, currentPret);
            finPretRepository.save(newFin);
        } else {
            throw new Exception("Pret non trouver idPret : "+idPret);
        }
    }
}
