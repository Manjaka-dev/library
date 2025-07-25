package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.QuotaTypePret;
import itu.web_dyn.bibliotheque.repository.PretRepository;
import itu.web_dyn.bibliotheque.repository.QuotaTypePretRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class QuotaTypePretService {
    @Autowired
    private QuotaTypePretRepository quotaTypePretRepository;

    @Autowired
    private PretRepository pretRepository;


    // public QuotaTypePret findById(Integer id){
    //     return quotaTypePretRepository.findById(id).;
    // }

    public List<QuotaTypePret> findAll(){
        return quotaTypePretRepository.findAll();
    }

    public void save(QuotaTypePret quotaTypePret){
        quotaTypePretRepository.save(quotaTypePret);
    }

    public boolean adherantDepasseQuota(Integer idAdherant, Integer idProfil, Integer idTypePret) {
        System.out.println(">>> APPEL DE adherantDepasseQuota <<< adherant=" + idAdherant + ", profil=" + idProfil + ", typePret=" + idTypePret);
        Integer quota = quotaTypePretRepository.findQuota(idProfil, idTypePret);
        if (quota == null) {
            System.out.println("Pas de quota défini pour profil " + idProfil + " et type " + idTypePret);
            return true;
        }
        int nbPrets = pretRepository.countPretsEnCours(idAdherant, idTypePret);
        System.out.println("Quota autorisé : " + quota + ", prêts en cours : " + nbPrets);
        return nbPrets >= quota;
    }
}
