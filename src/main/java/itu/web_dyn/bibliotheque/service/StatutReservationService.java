package itu.web_dyn.bibliotheque.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.StatutReservation;
import itu.web_dyn.bibliotheque.repository.StatutReservationRepository;

@Service
public class StatutReservationService {
    @Autowired
    private StatutReservationRepository statutReservationRepository;

    public StatutReservation findById(Integer id){
        return statutReservationRepository.findById(id).get();
    }

    public List<StatutReservation> findAll(){
        return statutReservationRepository.findAll();
    }

    public void save(StatutReservation statutReservation){
        statutReservationRepository.save(statutReservation);
    }
}
