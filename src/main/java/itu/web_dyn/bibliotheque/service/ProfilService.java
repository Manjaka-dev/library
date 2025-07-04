package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Profil;
import itu.web_dyn.bibliotheque.repository.ProfilRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class ProfilService {
    @Autowired
    private ProfilRepository profilRepository;


    public Profil findById(Integer id){
        return profilRepository.findById(id).get();
    }

    public List<Profil> findAll(){
        return profilRepository.findAll();
    }

    public void save(Profil profil){
        profilRepository.save(profil);
    }

    public void deleteById(Integer id) {
        profilRepository.deleteById(id);
    }
}