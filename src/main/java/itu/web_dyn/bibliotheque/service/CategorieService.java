package itu.web_dyn.bibliotheque.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Categorie;
import itu.web_dyn.bibliotheque.repository.CategorieRepository;

@Service
public class CategorieService {
    @Autowired
    private CategorieRepository categorieRepository;

    public Categorie findById(Integer id){
        return categorieRepository.findById(id).get();
    }

    public List<Categorie> findAll(){
        return categorieRepository.findAll();
    }

    public void save(Categorie categorie){
        categorieRepository.save(categorie);
    }
}
