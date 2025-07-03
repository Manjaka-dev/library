package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.TypePret;
import itu.web_dyn.bibliotheque.repository.TypePretRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class TypePretService {
    @Autowired
    private TypePretRepository typePretRepository;

    public TypePret findById(Integer id){
        return typePretRepository.findById(id).get();
    }

    public List<TypePret> findAll(){
        return typePretRepository.findAll();
    }

    public void save(TypePret typePret){
        typePretRepository.save(typePret);
    }
}
