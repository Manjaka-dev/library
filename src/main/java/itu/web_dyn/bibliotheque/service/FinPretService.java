package itu.web_dyn.bibliotheque.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.repository.FinPretRepository;

@Service
public class FinPretService {
    @Autowired
    private FinPretRepository finPretRepository;

    public FinPret findById(Integer id){
        return finPretRepository.findById(id).get();
    }

    public List<FinPret> findAll(){
        return finPretRepository.findAll();
    }

    public void save(FinPret finPret){
        finPretRepository.save(finPret);
    }
}
