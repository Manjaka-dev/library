package itu.web_dyn.bibliotheque.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Inscription;
import itu.web_dyn.bibliotheque.repository.AdherantRepository;
import itu.web_dyn.bibliotheque.repository.InscriptionRepository;

@Service
public class AdherantService {
    @Autowired
    private AdherantRepository adherantRepository;

    @Autowired 
    private InscriptionRepository inscriptionRepository;

    public Adherant findById(Integer id) {
        return adherantRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Adhérant non trouvé avec l’ID " + id));
    }

    public List<Adherant> findAll(){
        return adherantRepository.findAll();
    }

    public void save(Adherant adherant){
        adherantRepository.save(adherant);
    }

    public boolean isActif(Integer adherantId, LocalDateTime datePret) {
        Inscription inscription = inscriptionRepository.findLastByAdherantId(adherantId);
        if (inscription == null) {
            System.out.println("❌ Aucune inscription trouvée pour l'adhérant ID: " + adherantId);
            return false;
        }
        
        if (datePret.isAfter(inscription.getDateDebut()) && datePret.isBefore(inscription.getDateFin())) {
            System.out.println("✅ Adhérant actif - inscription valide du " + inscription.getDateDebut() + " au " + inscription.getDateFin());
            return true;
        }
        
        System.out.println("❌ Adhérant inactif - inscription expirée ou pas encore commencée");
        System.out.println("   Date prêt demandée: " + datePret);
        System.out.println("   Inscription valide du " + inscription.getDateDebut() + " au " + inscription.getDateFin());
        return false;
    }

    public Adherant authenticate(int idAdherant, String motDePasse) {
        Adherant adherant = adherantRepository.findById(idAdherant).get();
        if (adherant != null && adherant.getPassword().equals(motDePasse)) {
            return adherant;
        }
        return null;
    }

}