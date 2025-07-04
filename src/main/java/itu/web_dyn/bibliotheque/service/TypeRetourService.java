package itu.web_dyn.bibliotheque.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.TypeRetour;
import itu.web_dyn.bibliotheque.repository.TypeRetourRepository;

@Service
public class TypeRetourService {
    @Autowired
    private TypeRetourRepository typeRetourRepository;

    public List<TypeRetour> findAll() {
        return typeRetourRepository.findAll();
    }

    public TypeRetour findById(Integer id) {
        return typeRetourRepository.findById(id).orElse(null);
    }

    public TypeRetour save(TypeRetour typeRetour) {
        return typeRetourRepository.save(typeRetour);
    }

    public void deleteById(Integer id) {
        typeRetourRepository.deleteById(id);
    }
}
