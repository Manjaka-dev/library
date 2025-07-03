package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.entities.Retour;
import itu.web_dyn.bibliotheque.repository.PretRepository;
import itu.web_dyn.bibliotheque.repository.RetourRepository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class PretService {
    @Autowired
    private PretRepository pretRepository;

    @Autowired
    private RetourRepository retourRepository;

    public Pret findById(Integer id){
        return pretRepository.findById(id).get();
    }

    public List<Pret> findAll(){
        return pretRepository.findAll();
    }

    public void save(Pret pret){
        pretRepository.save(pret);
    }

    public void deleteById(Integer id){
        pretRepository.deleteById(id);
    }

    public List<Pret> findByIdExemplaire(Integer id_exemplaire){
        return pretRepository.findByIdExemplaire(id_exemplaire);
    }

        public FinPret findFinPret(Pret pret){
        return pretRepository.findByIdPret(pret.getIdPret());
    }

    public Retour findRetourPret(Pret pret){
        return retourRepository.findRetourByPret(pret.getIdPret());
    }

    public static boolean datesSeChevauchent(LocalDateTime debut1, LocalDateTime fin1,
                                             LocalDateTime debut2, LocalDateTime fin2) {
        return !fin1.isBefore(debut2) && !fin2.isBefore(debut1);
    }

}