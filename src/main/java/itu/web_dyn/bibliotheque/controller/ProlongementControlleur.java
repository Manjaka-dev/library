package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import itu.web_dyn.bibliotheque.service.ProlongementService;

import org.springframework.web.bind.annotation.PostMapping;


@Controller
@RequestMapping("/Prolongement")
public class ProlongementControlleur {
    @PostMapping
    public String prolonger(
        @RequestParam("idPret") Integer idPret,
        @RequestParam("date") LocalDateTime date
    ) {
        ProlongementService prolongementService = new ProlongementService();
        try {
            prolongementService.prologerPret(idPret, date);
        } catch (Exception e) {
            return "error";
        }      
        return "";
    }
    
}
