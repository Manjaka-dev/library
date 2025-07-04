package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.service.LivreService;
import itu.web_dyn.bibliotheque.service.ReservationService;
import itu.web_dyn.bibliotheque.service.UtilService;

@RequestMapping("/reservation")
@Controller
public class ReservationController {

    @Autowired
    private LivreService livreService;

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/form")
    public String formResa(Model model) {
        List<Livre> livres = livreService.findAll();

        model.addAttribute("books", livres);
        return "reservation/form"; // Redirection vers la page d'accueil
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
            redirectAttributes.addFlashAttribute("success", "Echec lors de la reservation du livre");
        }
        return "redirect:/livre/view/" + id_livre;
    }

}