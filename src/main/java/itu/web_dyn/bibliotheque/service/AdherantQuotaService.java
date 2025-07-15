package itu.web_dyn.bibliotheque.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.controller.api.dto.AdherantDTO;
import itu.web_dyn.bibliotheque.controller.api.dto.QuotaParTypeDTO;
import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.QuotaTypePret;
import itu.web_dyn.bibliotheque.entities.TypePret;
import itu.web_dyn.bibliotheque.repository.PretRepository;
import itu.web_dyn.bibliotheque.repository.QuotaTypePretRepository;
import itu.web_dyn.bibliotheque.repository.ReservationRepository;
import itu.web_dyn.bibliotheque.repository.TypePretRepository;

@Service
public class AdherantQuotaService {
    
    @Autowired
    private AdherantService adherantService;
    
    @Autowired
    private PenaliteService penaliteService;
    
    @Autowired
    private QuotaTypePretRepository quotaTypePretRepository;
    
    @Autowired
    private PretRepository pretRepository;
    
    @Autowired
    private ReservationRepository reservationRepository;
    
    @Autowired
    private TypePretRepository typePretRepository;
    
    /**
     * Convertir un adhérant en DTO avec calculs de quotas
     */
    public AdherantDTO convertirAdherantAvecQuotas(Integer idAdherant) {
        Adherant adherant = adherantService.findById(idAdherant);
        
        // Vérifier l'inscription active
        Boolean inscriptionActive = adherantService.isActif(idAdherant, LocalDateTime.now());
        
        // Vérifier les pénalités
        Boolean penalise = penaliteService.isPenalise(LocalDateTime.now(), idAdherant);
        
        // Calculer les quotas généraux
        Integer quotaPretTotal = adherant.getProfil().getQuotaPret();
        Integer quotaReservationTotal = adherant.getProfil().getQuotaReservation();
        
        // Calculer les quotas utilisés
        Integer pretsEnCours = calculerPretsEnCours(idAdherant);
        Integer reservationsActives = reservationRepository.countReservationsActivesByAdherant(idAdherant);
        
        // Calculer les quotas restants
        Integer quotaPretRestant = Math.max(0, quotaPretTotal - pretsEnCours);
        Integer quotaReservationRestant = Math.max(0, quotaReservationTotal - reservationsActives);
        
        // Calculer les quotas par type de prêt
        List<QuotaParTypeDTO> quotasParType = calculerQuotasParType(idAdherant, adherant.getProfil().getIdProfil());
        
        return new AdherantDTO(
            adherant.getIdAdherant(),
            adherant.getNomAdherant(),
            adherant.getPrenomAdherant(),
            adherant.getNumeroAdherant(),
            adherant.getDateNaissance(),
            adherant.getProfil().getNomProfil(),
            quotaPretTotal,
            quotaReservationTotal,
            quotaPretRestant,
            quotaReservationRestant,
            quotasParType,
            inscriptionActive,
            penalise
        );
    }
    
    /**
     * Calculer le nombre total de prêts en cours pour un adhérant
     */
    private Integer calculerPretsEnCours(Integer idAdherant) {
        List<TypePret> typePrets = typePretRepository.findAll();
        int totalPretsEnCours = 0;
        
        for (TypePret typePret : typePrets) {
            totalPretsEnCours += pretRepository.countPretsEnCours(idAdherant, typePret.getIdTypePret());
        }
        
        return totalPretsEnCours;
    }
    
    /**
     * Calculer les quotas par type de prêt
     */
    private List<QuotaParTypeDTO> calculerQuotasParType(Integer idAdherant, Integer idProfil) {
        List<QuotaParTypeDTO> quotasParType = new ArrayList<>();
        List<QuotaTypePret> quotas = quotaTypePretRepository.findByProfilId(idProfil);
        
        for (QuotaTypePret quota : quotas) {
            TypePret typePret = quota.getTypePret();
            Integer quotaAutorise = quota.getQuota();
            Integer quotaUtilise = pretRepository.countPretsEnCours(idAdherant, typePret.getIdTypePret());
            Integer quotaRestant = Math.max(0, quotaAutorise - quotaUtilise);
            
            quotasParType.add(new QuotaParTypeDTO(
                typePret.getIdTypePret(),
                typePret.getType(),
                quotaAutorise,
                quotaUtilise,
                quotaRestant
            ));
        }
        
        return quotasParType;
    }
}
