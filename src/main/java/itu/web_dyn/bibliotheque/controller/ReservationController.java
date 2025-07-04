package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

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

import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.entities.Reservation;
import itu.web_dyn.bibliotheque.service.AdherantService;
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
    public String saveReservation(@ModelAttribute Reservation reservation) {
        if (reservation.getDateDeReservation() == null) {
            reservation.setDateDeReservation(LocalDateTime.now());
        }
        reservationService.save(reservation);
        return "redirect:/reservations";
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
}