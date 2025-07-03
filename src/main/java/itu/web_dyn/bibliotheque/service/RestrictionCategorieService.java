package itu.web_dyn.bibliotheque.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.RestrictionCategorie;
import itu.web_dyn.bibliotheque.entities.RestrictionCategorieId;
import itu.web_dyn.bibliotheque.repository.RestrictionCategorieRepository;

import java.util.List;

@Service
public class RestrictionCategorieService {
    @Autowired
    private RestrictionCategorieRepository restrictionCategorieRepository;

    public int isRestreint(Integer idCategorie, Integer idProfil) {
        return restrictionCategorieRepository.existsRestriction(idCategorie, idProfil);
    }

    public List<RestrictionCategorie> findAll() {
        return restrictionCategorieRepository.findAll();
    }

    public void save(RestrictionCategorie restrictionCategorie) {
        restrictionCategorieRepository.save(restrictionCategorie);
    }

    public void deleteById(RestrictionCategorieId id) {
        restrictionCategorieRepository.deleteById(id);
    }
}
