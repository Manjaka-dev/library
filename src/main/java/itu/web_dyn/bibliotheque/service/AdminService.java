package itu.web_dyn.bibliotheque.service;

import org.springframework.stereotype.Service;

import itu.web_dyn.bibliotheque.entities.Admin;
import itu.web_dyn.bibliotheque.repository.AdminRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@Service
public class AdminService {
    @Autowired
    private AdminRepository adminRepository;

    public Admin findById(Integer id){
        return adminRepository.findById(id).get();
    }

    public List<Admin> findAll(){
        return adminRepository.findAll();
    }

    public void save(Admin admin){
        adminRepository.save(admin);
    }

    public void deleteById(Integer id) {
        adminRepository.deleteById(id);
    }
}
