package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.InscriptionProfil;
import itu.web_dyn.bibliotheque.entities.Profil;
import itu.web_dyn.bibliotheque.repository.InscriptionProfilRepository;
import itu.web_dyn.bibliotheque.repository.ProfilRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class ProfilService {
    @Autowired
    private ProfilRepository profilRepository;
    @Autowired
    private InscriptionProfilRepository inscriptionProfilRepository;

    public Profil findById(Integer id){
        return profilRepository.findById(id).get();
    }

    public List<Profil> findAll(){
        return profilRepository.findAll();
    }

    public void save(Profil profil){
        profilRepository.save(profil);
    }

    public InscriptionProfil getInscriptionProfilByProfil(Profil profil) {
        return inscriptionProfilRepository.findAll()
            .stream()
            .filter(ip -> ip.getProfil().getIdProfil().equals(profil.getIdProfil()))
            .findFirst()
            .orElse(null);
    }
}