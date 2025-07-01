package itu.web_dyn.bibliotheque.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

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

    public void calculPenalite(Integer idPret) throws Exception{
        Pret pret = pretRepository.findById(idPret).orElse(null);
        Penalite penalite = null;
        if (pret != null) {
            FinPret finPret = finPretRepository.findByPretId(pret.getIdPret()).getFirst();
            Retour retour = retourRepository.findByPret_IdPret(pret.getIdPret());
            if (retour !=null && finPret != null) {
                if (retour.getDateRetour().isAfter(finPret.getDateFin())) {
                    long retard = ChronoUnit.DAYS.between(finPret.getDateFin(), retour.getDateRetour());
                    if (retard > 0) {
                        Penalite lastPenalites = penaliteRepository.findByAdherant(pret.getAdherant())
                            .stream()
                            .sorted(Comparator.comparing(penalitee -> penalitee.getDatePenalite().plusDays(penalitee.getDuree())))
                            .collect(Collectors.toList()).getFirst();
                        
                        if (lastPenalites.getDatePenalite().plusDays(lastPenalites.getDuree()).isAfter(retour.getDateRetour())) {
                            penalite = new Penalite(pret.getAdherant(),((int)retard), retour.getDateRetour());
                        }
                        penalite = new Penalite(pret.getAdherant(),((int)retard), lastPenalites.getDatePenalite().plusDays(lastPenalites.getDuree()).plusDays(retard));
                        penaliteRepository.save(penalite);
                    }
                } else {
                    throw new Exception("n'a pas emprunter ou retourner de livre");
                }
            } else {
                throw new Exception("pret introuvable");
            }
        }
    }

    public boolean asPenalite(LocalDateTime date, Integer idAdherant){
        Penalite lastpenalite = penaliteRepository.findByAdherant(adherantRepository.findById(idAdherant).orElse(null))
        .stream()
        .sorted(Comparator.comparing(penalite -> penalite.getDatePenalite().plusDays(penalite.getDuree())))
        .collect(Collectors.toList()).getFirst();
        if (lastpenalite.getDatePenalite().plusDays(lastpenalite.getDuree()).isAfter(date)) {
            return true;
        }
        return false;
    }
}
