package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.entities.Retour;
import itu.web_dyn.bibliotheque.repository.ExemplaireRepository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class ExemplaireService {
    
    @Autowired
    private ExemplaireRepository exemplaireRepository;

    @Autowired 
    private PretService pretService;

    public Exemplaire findById(Integer id){
        return exemplaireRepository.findById(id).get();
    }

    public List<Exemplaire> findAll(){
        return exemplaireRepository.findAll();
    }

    public void save(Exemplaire exemplaire){
        exemplaireRepository.save(exemplaire);
    }


    public Boolean isExemplaireDisponible(Integer id_exemplaire, LocalDateTime dateDebut, LocalDateTime dateFin) {

        List<Pret> prets = pretService.findByIdExemplaire(id_exemplaire);
    
        for (Pret pret : prets) {
            LocalDateTime dateDebutPret = pret.getDateDebut();
            LocalDateTime dateFinPretOuRetour = null;
    
            Retour retour = pretService.findRetourPret(pret);
            if (retour != null) {
                dateFinPretOuRetour = retour.getDateRetour();
            } else {
                FinPret finpret = pretService.findFinPret(pret);
                if (finpret != null) {
                    dateFinPretOuRetour = finpret.getDateFin();
                }
            }
    
            if (dateFinPretOuRetour == null) continue;
    
            if (PretService.datesSeChevauchent(dateDebut, dateFin, dateDebutPret, dateFinPretOuRetour)) {
                return false;
            }
        }
    
        return true;
    }
    
}
