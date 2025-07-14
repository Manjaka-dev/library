package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.entities.Reservation;
import itu.web_dyn.bibliotheque.entities.StatutReservation;
import itu.web_dyn.bibliotheque.service.AdherantService;
import itu.web_dyn.bibliotheque.service.ExemplaireService;
import itu.web_dyn.bibliotheque.service.LivreService;
import itu.web_dyn.bibliotheque.service.ReservationService;
import itu.web_dyn.bibliotheque.service.StatutReservationService;
import itu.web_dyn.bibliotheque.service.UtilService;

@Controller
@RequestMapping("/reservations")
public class ReservationController {

    @Autowired
    private LivreService livreService;

    @Autowired
    private ReservationService reservationService;
    
    @Autowired
    private AdherantService adherantService;
    
    @Autowired
    private StatutReservationService statutReservationService;

    @Autowired
    private ExemplaireService exemplaireService;

    // Liste des réservations
    @GetMapping
    public String listReservations(Model model) {
        List<Reservation> reservations = reservationService.findAll();
        model.addAttribute("reservations", reservations);
        return "reservation/list";
    }

    // Formulaire de nouvelle réservation
    @GetMapping("/new")
    public String newReservation(Model model) {
        model.addAttribute("reservation", new Reservation());
        model.addAttribute("livres", livreService.findAll());
        model.addAttribute("adherants", adherantService.findAll());
        model.addAttribute("statuts", statutReservationService.findAll());
        return "reservation/form";
    }

    // Sauvegarde d'une réservation
    @PostMapping("/save")
    public String saveReservation(@ModelAttribute Reservation reservation, RedirectAttributes redirectAttributes) {
        try {
            if (reservation.getDateDeReservation() == null) {
                reservation.setDateDeReservation(LocalDateTime.now());
            }
            
            // Si aucun exemplaire n'est assigné, en trouver un automatiquement
            if (reservation.getExemplaire() == null && reservation.getLivre() != null) {
                List<Exemplaire> exemplairesLivre = exemplaireService.findAllExemplaireByIdLivre(reservation.getLivre().getIdLivre());
                Exemplaire exemplaireDisponible = null;
                
                for (Exemplaire exemplaire : exemplairesLivre) {
                    if (exemplaireService.isExemplaireDisponible(exemplaire.getIdExemplaire(), reservation.getDateDeReservation())) {
                        exemplaireDisponible = exemplaire;
                        break;
                    }
                }
                
                if (exemplaireDisponible == null) {
                    redirectAttributes.addFlashAttribute("error", "Aucun exemplaire disponible pour ce livre.");
                    return "redirect:/reservations/new";
                }
                
                reservation.setExemplaire(exemplaireDisponible);
            }
            
            reservationService.save(reservation);
            redirectAttributes.addFlashAttribute("success", "Réservation créée avec succès !");
            return "redirect:/reservations";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la création de la réservation : " + e.getMessage());
            return "redirect:/reservations/new";
        }
    }

    // Formulaire d'édition
    @GetMapping("/edit/{id}")
    public String editReservation(@PathVariable Integer id, Model model) {
        Reservation reservation = reservationService.findById(id);
        if (reservation != null) {
            model.addAttribute("reservation", reservation);
            model.addAttribute("livres", livreService.findAll());
            model.addAttribute("adherants", adherantService.findAll());
            model.addAttribute("statuts", statutReservationService.findAll());
            return "reservation/form";
        }
        return "redirect:/reservations";
    }

    // Détails d'une réservation
    @GetMapping("/view/{id}")
    public String viewReservation(@PathVariable Integer id, Model model) {
        Reservation reservation = reservationService.findById(id);
        if (reservation != null) {
            model.addAttribute("reservation", reservation);
            return "reservation/view";
        }
        return "redirect:/reservations";
    }

    // Suppression d'une réservation
    @GetMapping("/delete/{id}")
    public String deleteReservation(@PathVariable Integer id) {
        reservationService.deleteById(id);
        return "redirect:/reservations";
    }

    // Route héritée pour compatibilité
    @GetMapping("/form")
    public String formResa(Model model) {
        List<Livre> livres = livreService.findAll();
        model.addAttribute("books", livres);
        return "reservation/form";

    }

    @PostMapping("/reserveBook")
    public String reserverLivre(@RequestParam("livre") int id_livre,
                                @RequestParam("date") LocalDate date,
                                RedirectAttributes redirectAttributes) {
        try {
            Integer id_adherant = 1;
            LocalDateTime dateTime = UtilService.toDateTimeWithCurrentTime(date);
            reservationService.reserverUnLivre(id_adherant, id_livre, dateTime);
            redirectAttributes.addFlashAttribute("success", "Reservation reussi, passez au bibliotheque le ".concat(date.toString()));
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Echec lors de la reservation du livre");
        }
        return "redirect:/livres/view/" + id_livre;
    }

    // Formulaire de réservation simplifié pour les adhérents
    @GetMapping("/adherant/new")
    public String newReservationAdherant(Model model, HttpSession session,
                                         @RequestParam(value = "livreId", required = false) Integer livreId) {
        // Vérifier que c'est un adhérant connecté
        String userType = (String) session.getAttribute("userType");
        if (!"adherant".equals(userType)) {
            return "redirect:/login";
        }
        
        model.addAttribute("livres", livreService.findAll());
        if (livreId != null) {
            model.addAttribute("selectedLivreId", livreId);
        }
        return "reservation/adherant-form";
    }

    // Sauvegarde de réservation par un adhérant (simplifié)
    @PostMapping("/adherant/save")
    public String saveReservationAdherant(@RequestParam("livreId") Integer livreId,
                                         @RequestParam("dateReservation") LocalDate dateReservation,
                                         HttpSession session,
                                         RedirectAttributes redirectAttributes) {
        try {
            // Vérifier que c'est un adhérant connecté
            String userType = (String) session.getAttribute("userType");
            Adherant adherant = (Adherant) session.getAttribute("user");
            
            if (!"adherant".equals(userType) || adherant == null) {
                redirectAttributes.addFlashAttribute("error", "Accès non autorisé.");
                return "redirect:/login";
            }
            
            // Créer la réservation avec statut "En attente"
            LocalDateTime dateTime = UtilService.toDateTimeWithCurrentTime(dateReservation);
            Livre livre = livreService.findById(livreId);
            StatutReservation statutEnAttente = statutReservationService.findByNomStatut("En attente");
            
            // Vérifier les restrictions d'âge et de profil AVANT de créer la réservation
            Boolean peutPreter = livreService.peutPreterLivre(adherant, livre);
            if (!peutPreter) {
                redirectAttributes.addFlashAttribute("error", 
                    "Vous ne pouvez pas réserver ce livre à cause de votre âge ou du type de votre profil.");
                return "redirect:/reservations/adherant/new";
            }
            
            // Trouver un exemplaire disponible
            List<Exemplaire> exemplairesLivre = exemplaireService.findAllExemplaireByIdLivre(livreId);
            Exemplaire exemplaireDisponible = null;
            for (Exemplaire exemplaire : exemplairesLivre) {
                if (exemplaireService.isExemplaireDisponible(exemplaire.getIdExemplaire(), dateTime)) {
                    exemplaireDisponible = exemplaire;
                    break;
                }
            }
            
            if (exemplaireDisponible == null) {
                redirectAttributes.addFlashAttribute("error", 
                    "Aucun exemplaire disponible pour ce livre actuellement.");
                return "redirect:/reservations/adherant/new";
            }
            
            Reservation reservation = new Reservation();
            reservation.setDateDeReservation(dateTime);
            reservation.setLivre(livre);
            reservation.setAdherant(adherant);
            reservation.setStatut(statutEnAttente);
            reservation.setExemplaire(exemplaireDisponible);
            reservation.setAdmin(null); // Pas d'admin assigné pour l'instant
            
            reservationService.save(reservation);
            
            redirectAttributes.addFlashAttribute("success", 
                "Votre réservation a été créée avec succès ! Elle est en attente de validation par un bibliothécaire.");
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Erreur lors de la création de la réservation : " + e.getMessage());
        }
        
        return "redirect:/reservations/adherant/new";
    }
    
    // Valider une réservation et créer un prêt
    @GetMapping("/valider/{id}")
    public String validerReservation(@PathVariable Integer id, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            // Vérifier que c'est un admin
            String userType = (String) session.getAttribute("userType");
            if (!"admin".equals(userType)) {
                redirectAttributes.addFlashAttribute("error", "Accès non autorisé.");
                return "redirect:/reservations";
            }
            
            Reservation reservation = reservationService.findById(id);
            if (reservation == null) {
                redirectAttributes.addFlashAttribute("error", "Réservation non trouvée.");
                return "redirect:/reservations";
            }
            
            // Vérifier que la réservation est en attente
            if (!"En attente".equals(reservation.getStatut().getNomStatut())) {
                redirectAttributes.addFlashAttribute("error", "Cette réservation ne peut plus être validée.");
                return "redirect:/reservations/view/" + id;
            }
            
            // Rediriger vers un formulaire de création de prêt pré-rempli
            redirectAttributes.addFlashAttribute("reservation", reservation);
            return "redirect:/prets/new-from-reservation?reservationId=" + id;
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la validation : " + e.getMessage());
            return "redirect:/reservations/view/" + id;
        }
    }
}