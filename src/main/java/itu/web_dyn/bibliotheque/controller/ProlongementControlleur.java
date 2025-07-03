package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.repository.PretRepository;
import itu.web_dyn.bibliotheque.repository.FinPretRepository;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;



@Controller
@RequestMapping("/Prolongement")
public class ProlongementControlleur {

    @Autowired
    private PretRepository pretRepository;

    @Autowired
    private FinPretRepository finPretRepository;

    @PostMapping("/save")
    public String prolonger(
        @RequestParam("idPret") Integer idPret,
        @RequestParam("nouvelleDateFin") String nouvelleDateFin,
        @RequestParam(value = "motif", required = false) String motif,
        Model model,
        RedirectAttributes redirectAttributes
    ) {
        try {
            // Trouver le prêt
            Pret pret = pretRepository.findById(idPret).orElse(null);
            if (pret == null) {
                redirectAttributes.addFlashAttribute("error", "Prêt introuvable.");
                return "redirect:/Prolongement";
            }

            // Convertir la date
            LocalDate nouvelleDate = LocalDate.parse(nouvelleDateFin);
            LocalDateTime nouvelleDateHeure = nouvelleDate.atTime(23, 59); // Fin de journée
            
            // Vérifier que la nouvelle date est postérieure à aujourd'hui
            if (nouvelleDate.isBefore(LocalDate.now())) {
                redirectAttributes.addFlashAttribute("error", "La nouvelle date doit être postérieure à aujourd'hui.");
                return "redirect:/Prolongement";
            }

            // Trouver la fin de prêt existante ou en créer une nouvelle
            List<FinPret> finsPret = finPretRepository.findByPretId(idPret);
            FinPret finPret;
            
            if (finsPret.isEmpty()) {
                // Créer une nouvelle fin de prêt
                finPret = new FinPret(nouvelleDateHeure, pret);
            } else {
                // Modifier la fin de prêt existante
                finPret = finsPret.get(0);
                finPret.setDateFin(nouvelleDateHeure);
            }
            
            finPretRepository.save(finPret);
            
            redirectAttributes.addFlashAttribute("success", 
                "Le prêt de \"" + pret.getExemplaire().getLivre().getTitre() + 
                "\" pour " + pret.getAdherant().getNomAdherant() + " " + pret.getAdherant().getPrenomAdherant() +
                " a été prolongé jusqu'au " + nouvelleDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")));
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors du prolongement : " + e.getMessage());
        }
        
        return "redirect:/Prolongement";
    }

    @GetMapping
    public String prolongerForm(Model model) {
        // Récupérer tous les prêts
        List<Pret> tousPrets = pretRepository.findAll();
        
        // Créer une liste de prêts avec leur date de fin (simulée pour l'affichage)
        List<PretAvecDateFin> pretsEnCours = tousPrets.stream()
            .map(pret -> {
                List<FinPret> finsPret = finPretRepository.findByPretId(pret.getIdPret());
                LocalDateTime dateFin = finsPret.isEmpty() ? 
                    pret.getDateDebut().plusWeeks(2) : // Date par défaut : 2 semaines après le début
                    finsPret.get(0).getDateFin();
                
                // Ne garder que les prêts dont la date de fin est dans le futur
                if (dateFin.isAfter(LocalDateTime.now())) {
                    return new PretAvecDateFin(pret, dateFin);
                }
                return null;
            })
            .filter(pretAvecFin -> pretAvecFin != null)
            .collect(Collectors.toList());

        model.addAttribute("pretsEnCours", pretsEnCours);
        return "prolongement/form";
    }
    
    // Classe interne pour représenter un prêt avec sa date de fin
    public static class PretAvecDateFin {
        private Pret pret;
        private LocalDateTime dateFin;
        
        public PretAvecDateFin(Pret pret, LocalDateTime dateFin) {
            this.pret = pret;
            this.dateFin = dateFin;
        }
        
        // Getters
        public Integer getIdPret() { return pret.getIdPret(); }
        public Adherant getAdherant() { return pret.getAdherant(); }
        public itu.web_dyn.bibliotheque.entities.Exemplaire getExemplaire() { return pret.getExemplaire(); }
        public LocalDateTime getDateDebut() { return pret.getDateDebut(); }
        public Date getDateFin() { return java.sql.Timestamp.valueOf(dateFin); }
    }
}
