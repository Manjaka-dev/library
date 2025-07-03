package itu.web_dyn.bibliotheque.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Retour;
import itu.web_dyn.bibliotheque.repository.RetourRepository;

import java.util.List;

@Service
public class RetourService {
    @Autowired
    private RetourRepository retourRepository;

    public List<Retour> findAll() { return retourRepository.findAll(); }
    public Retour save(Retour retour) { return retourRepository.save(retour); }
    public void deleteById(Integer id) { retourRepository.deleteById(id); }
    public Retour findById(Integer id) { return retourRepository.findById(id).orElse(null); }
}