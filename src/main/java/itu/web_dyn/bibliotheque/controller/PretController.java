package itu.web_dyn.bibliotheque.controller;

import java.time.LocalDateTime;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import itu.web_dyn.bibliotheque.entities.Adherant;
import itu.web_dyn.bibliotheque.entities.Admin;
import itu.web_dyn.bibliotheque.entities.Exemplaire;
import itu.web_dyn.bibliotheque.entities.FinPret;
import itu.web_dyn.bibliotheque.entities.Inscription;
import itu.web_dyn.bibliotheque.entities.Livre;
import itu.web_dyn.bibliotheque.entities.Pret;
import itu.web_dyn.bibliotheque.entities.Reservation;
import itu.web_dyn.bibliotheque.entities.Retour;
import itu.web_dyn.bibliotheque.entities.StatutReservation;
import itu.web_dyn.bibliotheque.entities.TypePret;
import itu.web_dyn.bibliotheque.service.AdherantService;
import itu.web_dyn.bibliotheque.service.ExemplaireService;
import itu.web_dyn.bibliotheque.service.FinPretService;
import itu.web_dyn.bibliotheque.service.LivreService;
import itu.web_dyn.bibliotheque.service.PenaliteService;
import itu.web_dyn.bibliotheque.service.PretService;
import itu.web_dyn.bibliotheque.service.QuotaTypePretService;
import itu.web_dyn.bibliotheque.service.ReservationService;
import itu.web_dyn.bibliotheque.service.StatutReservationService;
import itu.web_dyn.bibliotheque.service.TypePretService;
import itu.web_dyn.bibliotheque.service.UtilService;
import itu.web_dyn.bibliotheque.repository.AdherantRepository;
import itu.web_dyn.bibliotheque.repository.InscriptionRepository;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/prets")
public class PretController {

    // @PostConstruct
    // public void forceStdOutToConsole() {
    //     System.setOut(new PrintStream(new FileOutputStream(FileDescriptor.out)));
    //     System.setErr(new PrintStream(new FileOutputStream(FileDescriptor.err)));
    // }

    // private static final Logger logger = LoggerFactory.getLogger(PretController.class);

    @Autowired
    private LivreService livreService;

    @Autowired
    private ExemplaireService exemplaireService;

    @Autowired
    private AdherantService adherantService;

    @Autowired
    private QuotaTypePretService quotaTypePretService;

    @Autowired 
    private TypePretService typePretService; 

    @Autowired
    private PretService pretService;

    @Autowired
    private PenaliteService penaliteService;

    @Autowired
    private FinPretService finPretService;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private StatutReservationService statutReservationService;

    @Autowired
    private AdherantRepository adherantRepository;

    @Autowired
    private InscriptionRepository inscriptionRepository;

    private void preparePretPage(Model model) {
        model.addAttribute("livres", livreService.findAll());
        model.addAttribute("adherants", adherantService.findAll());
        model.addAttribute("typesPret", typePretService.findAll());
    }

    // Formulaire de nouveau prêt
    @GetMapping("/new")
    public String newPret(Model model, HttpSession session) {
        // Vérifier les autorisations
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/prets?error=access-denied";
        }
        
        preparePretPage(model);
        return "pret/form";
    }

    @GetMapping("/preter")
    public String preter(Model model) {

        preparePretPage(model);

        return "pret";
    }

    @PostMapping("/preter")
    public String preterLivre(@RequestParam("adherantId") int adherantId,
                              @RequestParam("typePret") int typePretId,  
                              @RequestParam("livre") int livreId,
                              @RequestParam("dateDebut") LocalDate dateDebut, 
                              HttpSession session,
                              Model model) {

        Adherant adherant = adherantService.findById(adherantId);
        Livre livre = livreService.findById(livreId);
        TypePret typePret = typePretService.findById(typePretId);
        List<Exemplaire> exemplaires = exemplaireService.findAllExemplaireByIdLivre(livre.getIdLivre());
        
        // Calculer automatiquement la date de fin basée sur le type de prêt
        LocalDate dateFin = dateDebut.plusDays(typePret.getDureeJours());
        
        Exemplaire exemplaireOpt = null;

        if (adherant.getIdAdherant() == null) {
            model.addAttribute("message", "Adhérant inexistant.");
            
            preparePretPage(model);

            return "pret";
        }

        // 2. L'adhérant doit être inscrit (à adapter selon ta logique d'inscription)
        System.out.println("--------- CHECK IF ADHERANT IS ACTIF -----------------");
        boolean inscrit = adherantService.isActif(adherant.getIdAdherant(), LocalDateTime.now());
        if (inscrit == false) {
            model.addAttribute("message", "Adhérant non inscrit ou inscription inactive.");

            preparePretPage(model);


            return "pret";
        }

        System.out.println("----------------- LOOP FOR EXEMPLAIRE");
        for (Exemplaire exemplaire : exemplaires) {
            // 3. Le numéro de l'exemplaire doit exister
            if (exemplaireService.isExemplaireDisponible(exemplaire.getIdExemplaire(), 
                    dateDebut.atStartOfDay(), 
                    dateFin.atStartOfDay())) {
                exemplaireOpt = exemplaire;
                break;
            }
        }


        if (exemplaireOpt == null) {
            model.addAttribute("message", "Il n'y a plus d'exemplaire disponible.");
            preparePretPage(model);
            return "pret";
        }

        // 5. Vérifier si l'adhérant n'est pas pénalisé
        System.out.println("----------------- CHECK IF ADHERANT IS PENALISED -----------------------------");
        boolean penalise = penaliteService.isPenalise(LocalDateTime.now(),adherant.getIdAdherant()); 
        if (penalise) {
            model.addAttribute("message", "Adhérant pénalisé, prêt impossible.");
            preparePretPage(model);

            return "pret";
        }

        // 6. Vérifier que l'adhérant ne dépasse pas le quota pour le type de prêt
        System.out.println("----------------- CHECK IF ADHERANT HAS MORE PRET THAN QUOTA  -----------------------------");
        boolean depasseQuota = quotaTypePretService.adherantDepasseQuota(
            adherant.getIdAdherant(),
            adherant.getProfil().getIdProfil(),
            typePretId
        ); 

        if (depasseQuota) {
            model.addAttribute("message", "Quota de prêt dépassé.");
            preparePretPage(model);
            
            return "pret";
        }


        // 7. L'adhérant peut-il prêter ce livre (ex: restrictions sur certains livres)
        System.out.println("----------------- CHECK IF ADHERANT CAN PRETER THE BOOK -----------------------------");

        Boolean peutPreter = livreService.peutPreterLivre(adherant, livre);

        if (!peutPreter) {
            model.addAttribute("message", "Vous ne pouvez pas emprunter ce livre a cause de votre age ou du type de votre profil");
            preparePretPage(model);
            return "pret";
        }

        // Récupérer l'admin connecté depuis la session
        Admin admin = null;
        Object user = session.getAttribute("user");
        String userType = (String) session.getAttribute("userType");
        
        if (user instanceof Admin && "admin".equals(userType)) {
            admin = (Admin) user;
        } else {
            // Si l'admin n'est pas trouvé, ajouter un message d'erreur
            model.addAttribute("error", "Vous devez être connecté en tant qu'administrateur pour créer un prêt.");
            preparePretPage(model);
            return "pret";
        }

        // Pret pret = new Pret(
        //     LocalDateTime.now(), // Date de début du prêt
        //     admin, // Admin (à définir selon votre logique, peut-être l'admin connecté)
        //     typePretService.findById(typePretId), // Type de prêt
        //     exemplaireOpt, // Exemplaire (le dernier exemplaire vérifié)
        //     adherant // Adhérant
        // );
        Pret pret = new Pret();
        pret.setAdherant(adherant);
        pret.setAdmin(admin);
        pret.setDateDebut(dateDebut.atStartOfDay()); // Convertir LocalDate en LocalDateTime
        pret.setExemplaire(exemplaireOpt);
        pret.setTypePret(typePret);


        FinPret finPret = new FinPret(dateFin.atStartOfDay(), pret);
        
        if (exemplaireOpt != null) {
            System.out.println("----------------- SAVE PRET -----------------------------");

            pretService.save(pret);
            finPretService.save(finPret);
            model.addAttribute("success", "Prêt validé et inséré");
        }

        preparePretPage(model);
        
        
        // Redirection vers la page de confirmation ou d'accueil après le prêt
        return "pret";
        
    }

    // Voir les détails d'un prêt
    @GetMapping("/view/{id}")
    public String viewPret(@PathVariable("id") Integer id, Model model, HttpSession session) {
        // Récupérer le type d'utilisateur depuis la session
        String userType = (String) session.getAttribute("userType");
        model.addAttribute("userType", userType);
        
        // Récupérer le prêt
        Pret pret = pretService.findById(id);
        if (pret == null) {
            return "redirect:/prets";
        }
        
        // Vérifier les autorisations
        if ("admin".equals(userType)) {
            // Admin peut voir tous les prêts
            model.addAttribute("pret", pret);
            return "pret/view";
        } else if ("adherant".equals(userType)) {
            // Adhérent ne peut voir que ses propres prêts
            Adherant adherant = (Adherant) session.getAttribute("user");
            if (adherant != null && pret.getAdherant().getIdAdherant().equals(adherant.getIdAdherant())) {
                model.addAttribute("pret", pret);
                return "pret/view";
            }
        }
        
        // Rediriger vers la liste des prêts si pas d'autorisation
        return "redirect:/prets";
    }

    // Modifier un prêt (formulaire)
    @GetMapping("/edit/{id}")
    public String editPretForm(@PathVariable("id") Integer id, Model model, HttpSession session) {
        // Seuls les admins peuvent modifier les prêts
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/prets";
        }
        
        Pret pret = pretService.findById(id);
        if (pret == null) {
            return "redirect:/prets";
        }
        
        preparePretPageForEdit(model, id);
        model.addAttribute("userType", userType);
        return "pret/edit";
    }

    // Supprimer un prêt
    @GetMapping("/delete/{id}")
    public String deletePret(@PathVariable("id") Integer id, HttpSession session) {
        // Seuls les admins peuvent supprimer les prêts
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/prets";
        }
        
        Pret pret = pretService.findById(id);
        if (pret != null) {
            pretService.deleteById(id);
        }
        
        return "redirect:/prets";
    }

    // Liste des prêts
    @GetMapping
    public String listPrets(Model model, HttpSession session) {
        // Récupérer le type d'utilisateur depuis la session
        String userType = (String) session.getAttribute("userType");
        model.addAttribute("userType", userType);
        
        if ("admin".equals(userType)) {
            // Admin peut voir tous les prêts
            List<Pret> prets = pretService.findAll();
            model.addAttribute("prets", prets);
            return "pret/list";
        } else if ("adherant".equals(userType)) {
            // Adhérent ne peut voir que ses propres prêts
            Adherant adherant = (Adherant) session.getAttribute("user");
            if (adherant != null) {
                List<Pret> prets = pretService.findByAdherant(adherant);
                model.addAttribute("prets", prets);
                return "pret/list";
            }
        }
        
        // Rediriger vers la page d'accueil si pas d'autorisation
        return "redirect:/";
    }

    // Modifier un prêt (traitement)
    @PostMapping("/update")
    public String updatePret(@RequestParam("idPret") Integer idPret,
                            @RequestParam("adherantId") int adherantId,
                            @RequestParam("typePret") int typePretId,  
                            @RequestParam("livre") int livreId,
                            @RequestParam("dateDebut") LocalDateTime dateDebut,
                            @RequestParam("dateFin") LocalDate dateFin, 
                            HttpSession session,
                            Model model) {
        // Seuls les admins peuvent modifier les prêts
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/prets";
        }
        
        try {
            Pret pret = pretService.findById(idPret);
            if (pret == null) {
                model.addAttribute("message", "Prêt non trouvé.");
                return "redirect:/prets";
            }
            
            // Vérifier l'adhérant
            Adherant adherant = adherantService.findById(adherantId);
            if (adherant == null) {
                model.addAttribute("message", "Adhérant inexistant.");
                preparePretPageForEdit(model, idPret);
                return "pret/edit";
            }
            
            // Vérifier le livre et les exemplaires
            Livre livre = livreService.findById(livreId);
            if (livre == null) {
                model.addAttribute("message", "Livre inexistant.");
                preparePretPageForEdit(model, idPret);
                return "pret/edit";
            }
            
            // Mettre à jour le prêt
            Admin admin = null;
            Object user = session.getAttribute("user");
            if (user instanceof Admin && "admin".equals(userType)) {
                admin = (Admin) user;
            } else {
                model.addAttribute("message", "Vous devez être connecté en tant qu'administrateur pour modifier un prêt.");
                preparePretPageForEdit(model, idPret);
                return "pret/edit";
            }
            
            pret.setAdherant(adherant);
            pret.setTypePret(typePretService.findById(typePretId));
            pret.setDateDebut(dateDebut);
            pret.setAdmin(admin);
            
            // Sauvegarder les modifications
            pretService.save(pret);
            
            // Mettre à jour la date de fin si nécessaire
            FinPret finPret = pretService.findFinPret(pret);
            if (finPret != null) {
                finPret.setDateFin(UtilService.toDateTimeWithCurrentTime(dateFin));
                finPretService.save(finPret);
            } else {
                FinPret newFinPret = new FinPret(UtilService.toDateTimeWithCurrentTime(dateFin), pret);
                finPretService.save(newFinPret);
            }
            
            model.addAttribute("message", "Prêt modifié avec succès !");
            return "redirect:/prets/view/" + idPret;
            
        } catch (Exception e) {
            model.addAttribute("message", "Erreur lors de la modification : " + e.getMessage());
            preparePretPageForEdit(model, idPret);
            return "pret/edit";
        }
    }
    
    private void preparePretPageForEdit(Model model, Integer idPret) {
        Pret pret = pretService.findById(idPret);
        model.addAttribute("pret", pret);
        model.addAttribute("livres", livreService.findAll());
        model.addAttribute("adherants", adherantService.findAll());
        model.addAttribute("typesPret", typePretService.findAll());
    }

    // Créer un prêt à partir d'une réservation
    @GetMapping("/new-from-reservation")
    public String newPretFromReservation(@RequestParam("reservationId") Integer reservationId, 
                                        Model model, HttpSession session) {
        // Vérifier les autorisations
        String userType = (String) session.getAttribute("userType");
        if (!"admin".equals(userType)) {
            return "redirect:/prets?error=access-denied";
        }
        
        try {
            // Récupérer la réservation
            Reservation reservation = reservationService.findById(reservationId);
            if (reservation == null) {
                model.addAttribute("message", "Réservation non trouvée.");
                preparePretPage(model);
                return "pret/form";
            }
            
            // Pré-remplir le formulaire avec les données de la réservation
            preparePretPage(model);
            model.addAttribute("selectedAdherant", reservation.getAdherant().getIdAdherant());
            model.addAttribute("selectedLivre", reservation.getLivre().getIdLivre());
            model.addAttribute("reservationId", reservationId);
            model.addAttribute("isFromReservation", true);
            
            return "pret/form-from-reservation";
            
        } catch (Exception e) {
            model.addAttribute("message", "Erreur lors du chargement de la réservation : " + e.getMessage());
            preparePretPage(model);
            return "pret/form";
        }
    }
    
    // Sauvegarder un prêt créé à partir d'une réservation
    @PostMapping("/save-from-reservation")
    public String savePretFromReservation(@RequestParam("reservationId") Integer reservationId,
                                         @RequestParam("typePret") int typePretId,  
                                         @RequestParam("dateDebut") LocalDate dateDebut, 
                                         HttpSession session,
                                         Model model) {
        try {
            // Vérifier les autorisations
            String userType = (String) session.getAttribute("userType");
            if (!"admin".equals(userType)) {
                return "redirect:/prets?error=access-denied";
            }
            
            // Récupérer la réservation
            Reservation reservation = reservationService.findById(reservationId);
            if (reservation == null) {
                model.addAttribute("message", "Réservation non trouvée.");
                return "redirect:/reservations";
            }
            
            Adherant adherant = reservation.getAdherant();
            Livre livre = reservation.getLivre();
            TypePret typePret = typePretService.findById(typePretId);
            
            // Calculer automatiquement la date de fin basée sur le type de prêt
            LocalDate dateFin = dateDebut.plusDays(typePret.getDureeJours());
            
            // Effectuer les vérifications habituelles du prêt
            boolean inscrit = adherantService.isActif(adherant.getIdAdherant(), LocalDateTime.now());
            if (!inscrit) {
                model.addAttribute("message", "Adhérant non inscrit ou inscription inactive.");
                return "redirect:/reservations/view/" + reservationId;
            }
            
            boolean penalise = penaliteService.isPenalise(LocalDateTime.now(), adherant.getIdAdherant()); 
            if (penalise) {
                model.addAttribute("message", "Adhérant pénalisé, prêt impossible.");
                return "redirect:/reservations/view/" + reservationId;
            }
            
            // Vérifier le quota pour le type de prêt
            boolean depasseQuota = quotaTypePretService.adherantDepasseQuota(
                adherant.getIdAdherant(),
                adherant.getProfil().getIdProfil(),
                typePretId
            ); 
            if (depasseQuota) {
                model.addAttribute("message", "Quota de prêt dépassé pour ce type de prêt.");
                return "redirect:/reservations/view/" + reservationId;
            }
            
            // Vérifier les restrictions d'âge et de profil
            System.out.println("==================== VERIFICATION RESTRICTIONS ====================");
            Boolean peutPreter = livreService.peutPreterLivre(adherant, livre);
            System.out.println("Résultat vérification restrictions : " + peutPreter);
            
            if (!peutPreter) {
                System.out.println("❌ TRANSFORMATION REJETÉE - Restrictions non respectées");
                model.addAttribute("message", "Vous ne pouvez pas emprunter ce livre à cause de votre âge ou du type de votre profil.");
                return "redirect:/reservations/view/" + reservationId;
            }
            
            System.out.println("✅ RESTRICTIONS VALIDÉES - Transformation peut continuer");
            
            // Trouver un exemplaire disponible
            // Commencer par vérifier l'exemplaire de la réservation
            Exemplaire exemplaireOpt = null;
            
            // Vérifier d'abord si l'exemplaire de la réservation est disponible
            if (reservation.getExemplaire() != null && 
                exemplaireService.isExemplaireDisponible(reservation.getExemplaire().getIdExemplaire(), 
                dateDebut.atStartOfDay(), dateFin.atStartOfDay())) {
                exemplaireOpt = reservation.getExemplaire();
            } else {
                // Sinon, chercher un autre exemplaire disponible
                List<Exemplaire> exemplaires = exemplaireService.findAllExemplaireByIdLivre(livre.getIdLivre());
                for (Exemplaire exemplaire : exemplaires) {
                    if (exemplaireService.isExemplaireDisponible(exemplaire.getIdExemplaire(), 
                        dateDebut.atStartOfDay(), dateFin.atStartOfDay())) {
                        exemplaireOpt = exemplaire;
                        break;
                    }
                }
            }
            
            if (exemplaireOpt == null) {
                model.addAttribute("message", "Il n'y a plus d'exemplaire disponible.");
                return "redirect:/reservations/view/" + reservationId;
            }
            
            // Récupérer l'admin connecté depuis la session
            Admin admin = null;
            Object user = session.getAttribute("user");
            
            if (user instanceof Admin && "admin".equals(userType)) {
                admin = (Admin) user;
            } else {
                model.addAttribute("message", "Vous devez être connecté en tant qu'administrateur pour créer un prêt.");
                return "redirect:/login";
            }
            
            // Créer le prêt
            Pret pret = new Pret();
            pret.setAdherant(adherant);
            pret.setAdmin(admin);
            pret.setDateDebut(dateDebut.atStartOfDay());
            pret.setExemplaire(exemplaireOpt);
            pret.setTypePret(typePret);
            
            // Sauvegarder le prêt d'abord pour obtenir l'ID
            pretService.save(pret);
            
            // Créer et sauvegarder FinPret après que le Pret ait un ID
            FinPret finPret = new FinPret(dateFin.atStartOfDay(), pret);
            finPretService.save(finPret);
            
            // Mettre à jour le statut de la réservation à "Confirmée"
            StatutReservation statutConfirme = statutReservationService.findByNomStatut("Confirmée");
            reservation.setStatut(statutConfirme);
            reservation.setStatutReservation(statutConfirme); // Assurer la synchronisation des deux champs
            reservation.setAdmin(admin);
            reservationService.save(reservation);
            
            return "redirect:/prets/view/" + pret.getIdPret() + "?success=pret-created-from-reservation";
            
        } catch (Exception e) {
            System.err.println("=== ERREUR TRANSFORMATION RESERVATION EN PRET ===");
            System.err.println("Reservation ID: " + reservationId);
            System.err.println("Type de prêt ID: " + typePretId);
            System.err.println("Date de début: " + dateDebut);
            System.err.println("Message d'erreur: " + e.getMessage());
            System.err.println("Stack trace:");
            e.printStackTrace();
            System.err.println("=================================================");
            
            model.addAttribute("message", "Erreur lors de la création du prêt : " + e.getMessage());
            return "redirect:/reservations/view/" + reservationId;
        }
    }

    // Méthode de diagnostic pour tester la transformation
    @GetMapping("/debug-transformation/{reservationId}")
    public String debugTransformation(@PathVariable Integer reservationId, Model model, HttpSession session) {
        try {
            System.out.println("=== DEBUG TRANSFORMATION RESERVATION → PRET ===");
            System.out.println("Reservation ID: " + reservationId);
            
            // 1. Vérifier les autorisations
            String userType = (String) session.getAttribute("userType");
            System.out.println("User type: " + userType);
            if (!"admin".equals(userType)) {
                System.out.println("❌ Accès refusé - pas admin");
                model.addAttribute("error", "Accès refusé - utilisateur non admin");
                return "pret/debug";
            }
            
            // 2. Récupérer la réservation
            Reservation reservation = reservationService.findById(reservationId);
            System.out.println("Reservation trouvée: " + (reservation != null));
            if (reservation == null) {
                System.out.println("❌ Réservation non trouvée");
                model.addAttribute("error", "Réservation non trouvée");
                return "pret/debug";
            }
            
            System.out.println("Statut réservation: " + reservation.getStatut().getNomStatut());
            System.out.println("Livre: " + reservation.getLivre().getTitre());
            System.out.println("Adhérant: " + reservation.getAdherant().getNomAdherant());
            
            // 3. Vérifier l'adhérant
            Adherant adherant = reservation.getAdherant();
            boolean inscrit = adherantService.isActif(adherant.getIdAdherant(), LocalDateTime.now());
            System.out.println("Adhérant actif: " + inscrit);
            
            boolean penalise = penaliteService.isPenalise(LocalDateTime.now(), adherant.getIdAdherant());
            System.out.println("Adhérant pénalisé: " + penalise);
            
            // 4. Vérifier les exemplaires
            Livre livre = reservation.getLivre();
            List<Exemplaire> exemplaires = exemplaireService.findAllExemplaireByIdLivre(livre.getIdLivre());
            System.out.println("Nombre d'exemplaires pour ce livre: " + exemplaires.size());
            
            // 5. Tester la disponibilité des exemplaires
            LocalDateTime dateDebut = LocalDateTime.now();
            LocalDateTime dateFin = dateDebut.plusDays(14); // Test avec 14 jours
            
            for (Exemplaire exemplaire : exemplaires) {
                boolean disponible = exemplaireService.isExemplaireDisponible(
                    exemplaire.getIdExemplaire(), dateDebut, dateFin);
                System.out.println("Exemplaire " + exemplaire.getIdExemplaire() + " disponible: " + disponible);
            }
            
            // 6. Vérifier spécifiquement l'exemplaire de la réservation
            if (reservation.getExemplaire() != null) {
                boolean exemplaireResaDisponible = exemplaireService.isExemplaireDisponible(
                    reservation.getExemplaire().getIdExemplaire(), dateDebut, dateFin);
                System.out.println("Exemplaire de la réservation (" + reservation.getExemplaire().getIdExemplaire() + ") disponible: " + exemplaireResaDisponible);
            } else {
                System.out.println("❌ Pas d'exemplaire assigné à la réservation");
            }
            
            // 7. Vérifier l'admin
            Admin admin = null;
            Object user = session.getAttribute("user");
            if (user instanceof Admin && "admin".equals(userType)) {
                admin = (Admin) user;
                System.out.println("Admin en session: " + admin.getNomAdmin());
            } else {
                System.out.println("❌ Admin non trouvé en session");
            }
            
            System.out.println("=== FIN DEBUG ===");
            
            model.addAttribute("debugInfo", "Vérification terminée - consultez les logs de la console");
            return "pret/debug";
            
        } catch (Exception e) {
            System.err.println("❌ ERREUR DURANT DEBUG: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Erreur durant le debug: " + e.getMessage());
            return "pret/debug";
        }
    }

    // Test simple pour vérifier la disponibilité d'un exemplaire
    @GetMapping("/test-exemplaire/{exemplaireId}")
    public String testExemplaire(@PathVariable Integer exemplaireId, Model model) {
        try {
            System.out.println("=== TEST EXEMPLAIRE " + exemplaireId + " ===");
            
            // Test avec différentes périodes
            LocalDateTime maintenant = LocalDateTime.now();
            LocalDateTime dans14jours = maintenant.plusDays(14);
            LocalDateTime dans30jours = maintenant.plusDays(30);
            
            // Test 1: Disponibilité maintenant pour 14 jours
            boolean dispo14j = exemplaireService.isExemplaireDisponible(exemplaireId, maintenant, dans14jours);
            System.out.println("Disponible maintenant pour 14 jours: " + dispo14j);
            
            // Test 2: Disponibilité maintenant pour 30 jours
            boolean dispo30j = exemplaireService.isExemplaireDisponible(exemplaireId, maintenant, dans30jours);
            System.out.println("Disponible maintenant pour 30 jours: " + dispo30j);
            
            // Test 3: Disponibilité juste maintenant (méthode à 1 paramètre)
            boolean dispoMaintenant = exemplaireService.isExemplaireDisponible(exemplaireId, maintenant);
            System.out.println("Disponible maintenant (simple): " + dispoMaintenant);
            
            // Récupérer les prêts pour cet exemplaire
            List<Pret> prets = pretService.findByIdExemplaire(exemplaireId);
            System.out.println("Nombre de prêts pour cet exemplaire: " + prets.size());
            
            for (Pret pret : prets) {
                System.out.println("Prêt ID: " + pret.getIdPret() + ", Date début: " + pret.getDateDebut());
                
                // Vérifier retour
                Retour retour = pretService.findRetourPret(pret);
                if (retour != null) {
                    System.out.println("  - Retour: " + retour.getDateRetour());
                } else {
                    System.out.println("  - Pas de retour");
                    
                    // Vérifier FinPret
                    FinPret finPret = pretService.findFinPret(pret);
                    if (finPret != null) {
                        System.out.println("  - Date fin prévue: " + finPret.getDateFin());
                    } else {
                        System.out.println("  - Pas de date de fin prévue");
                    }
                }
            }
            
            System.out.println("=== FIN TEST EXEMPLAIRE ===");
            
            model.addAttribute("exemplaireId", exemplaireId);
            model.addAttribute("dispo14j", dispo14j);
            model.addAttribute("dispo30j", dispo30j);
            model.addAttribute("dispoMaintenant", dispoMaintenant);
            model.addAttribute("nbPrets", prets.size());
            
            return "pret/debug";
            
        } catch (Exception e) {
            System.err.println("❌ ERREUR TEST EXEMPLAIRE: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Erreur test exemplaire: " + e.getMessage());
            return "pret/debug";
        }
    }
    
    @GetMapping("/create-test-inscription/{adherantId}")
    @ResponseBody
    public String createTestInscription(@PathVariable Integer adherantId) {
        try {
            // Vérifier si l'adhérant existe
            Optional<Adherant> adherantOpt = adherantRepository.findById(adherantId);
            if (!adherantOpt.isPresent()) {
                return "❌ Adhérant avec ID " + adherantId + " non trouvé";
            }
            
            Adherant adherant = adherantOpt.get();
            
            // Vérifier s'il a déjà une inscription active
            Inscription existingInscription = inscriptionRepository.findLastByAdherantId(adherantId);
            LocalDateTime now = LocalDateTime.now();
            
            if (existingInscription != null && 
                now.isAfter(existingInscription.getDateDebut()) && 
                now.isBefore(existingInscription.getDateFin())) {
                return "✅ Adhérant " + adherant.getNomAdherant() + " " + adherant.getPrenomAdherant() + 
                       " a déjà une inscription active du " + existingInscription.getDateDebut() + 
                       " au " + existingInscription.getDateFin();
            }
            
            // Créer une nouvelle inscription (valide 1 an)
            Inscription inscription = new Inscription();
            inscription.setAdherant(adherant);
            inscription.setDateDebut(now.minusDays(30)); // Commencée il y a 30 jours
            inscription.setDateFin(now.plusDays(335));   // Valide encore 335 jours
            
            inscriptionRepository.save(inscription);
            
            return "✅ Inscription créée pour " + adherant.getNomAdherant() + " " + adherant.getPrenomAdherant() + 
                   " - Valide du " + inscription.getDateDebut() + " au " + inscription.getDateFin() + 
                   "<br><br>🔄 Vous pouvez maintenant tester la transformation de réservation !";
                   
        } catch (Exception e) {
            return "❌ ERREUR lors de la création de l'inscription: " + e.getMessage();
        }
    }
    
    @GetMapping("/api/type-pret/{id}/duree")
    @ResponseBody
    public Map<String, Object> getTypePretDuree(@PathVariable Integer id) {
        try {
            TypePret typePret = typePretService.findById(id);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("duree", typePret.getDureeJours());
            response.put("type", typePret.getType());
            return response;
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("error", "Type de prêt non trouvé");
            return response;
        }
    }
}