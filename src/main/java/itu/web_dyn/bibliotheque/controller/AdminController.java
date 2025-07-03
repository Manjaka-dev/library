package itu.web_dyn.bibliotheque.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import itu.web_dyn.bibliotheque.entities.Admin;
import itu.web_dyn.bibliotheque.entities.Auteur;
import itu.web_dyn.bibliotheque.entities.Categorie;
import itu.web_dyn.bibliotheque.entities.Editeur;
import itu.web_dyn.bibliotheque.entities.Profil;
import itu.web_dyn.bibliotheque.entities.StatutReservation;
import itu.web_dyn.bibliotheque.entities.TypePret;
import itu.web_dyn.bibliotheque.entities.TypeRetour;
import itu.web_dyn.bibliotheque.repository.AdminRepository;
import itu.web_dyn.bibliotheque.repository.AuteurRepository;
import itu.web_dyn.bibliotheque.repository.CategorieRepository;
import itu.web_dyn.bibliotheque.repository.EditeurRepository;
import itu.web_dyn.bibliotheque.repository.ProfilRepository;
import itu.web_dyn.bibliotheque.repository.StatutReservationRepository;
import itu.web_dyn.bibliotheque.repository.TypePretRepository;
import itu.web_dyn.bibliotheque.repository.TypeRetourRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private AdminRepository adminRepository;
    @Autowired private AuteurRepository auteurRepository;
    @Autowired private CategorieRepository categorieRepository;
    @Autowired private EditeurRepository editeurRepository;
    @Autowired private ProfilRepository profilRepository;
    @Autowired private StatutReservationRepository statutReservationRepository;
    @Autowired private TypePretRepository typePretRepository;
    @Autowired private TypeRetourRepository typeRetourRepository;

    // ==== ADMIN ====
    @GetMapping("/admins")
    public String listAdmins(Model model) {
        model.addAttribute("admins", adminRepository.findAll());
        return "admin/admin/list";
    }

    @GetMapping("/admins/new")
    public String newAdmin(Model model) {
        model.addAttribute("admin", new Admin());
        return "admin/admin/form";
    }

    @PostMapping("/admins/save")
    public String saveAdmin(@ModelAttribute Admin admin) {
        adminRepository.save(admin);
        return "redirect:/admin/admins";
    }

    @GetMapping("/admins/edit/{id}")
    public String editAdmin(@PathVariable Integer id, Model model) {
        Admin admin = adminRepository.findById(id).orElse(null);
        if (admin != null) {
            model.addAttribute("admin", admin);
            return "admin/admin/form";
        }
        return "redirect:/admin/admins";
    }

    @GetMapping("/admins/delete/{id}")
    public String deleteAdmin(@PathVariable Integer id) {
        adminRepository.deleteById(id);
        return "redirect:/admin/admins";
    }

    // ==== AUTEUR ====
    @GetMapping("/auteurs")
    public String listAuteurs(Model model) {
        model.addAttribute("auteurs", auteurRepository.findAll());
        return "admin/auteur/list";
    }

    @GetMapping("/auteurs/new")
    public String newAuteur(Model model) {
        model.addAttribute("auteur", new Auteur());
        return "admin/auteur/form";
    }

    @PostMapping("/auteurs/save")
    public String saveAuteur(@ModelAttribute Auteur auteur) {
        auteurRepository.save(auteur);
        return "redirect:/admin/auteurs";
    }

    @GetMapping("/auteurs/edit/{id}")
    public String editAuteur(@PathVariable Integer id, Model model) {
        Auteur auteur = auteurRepository.findById(id).orElse(null);
        if (auteur != null) {
            model.addAttribute("auteur", auteur);
            return "admin/auteur/form";
        }
        return "redirect:/admin/auteurs";
    }

    @GetMapping("/auteurs/delete/{id}")
    public String deleteAuteur(@PathVariable Integer id) {
        auteurRepository.deleteById(id);
        return "redirect:/admin/auteurs";
    }

    // ==== CATEGORIE ====
    @GetMapping("/categories")
    public String listCategories(Model model) {
        model.addAttribute("categories", categorieRepository.findAll());
        return "admin/categorie/list";
    }

    @GetMapping("/categories/new")
    public String newCategorie(Model model) {
        model.addAttribute("categorie", new Categorie());
        return "admin/categorie/form";
    }

    @PostMapping("/categories/save")
    public String saveCategorie(@ModelAttribute Categorie categorie) {
        categorieRepository.save(categorie);
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/edit/{id}")
    public String editCategorie(@PathVariable Integer id, Model model) {
        Categorie categorie = categorieRepository.findById(id).orElse(null);
        if (categorie != null) {
            model.addAttribute("categorie", categorie);
            return "admin/categorie/form";
        }
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/delete/{id}")
    public String deleteCategorie(@PathVariable Integer id) {
        categorieRepository.deleteById(id);
        return "redirect:/admin/categories";
    }

    // ==== EDITEUR ====
    @GetMapping("/editeurs")
    public String listEditeurs(Model model) {
        model.addAttribute("editeurs", editeurRepository.findAll());
        return "admin/editeur/list";
    }

    @GetMapping("/editeurs/new")
    public String newEditeur(Model model) {
        model.addAttribute("editeur", new Editeur());
        return "admin/editeur/form";
    }

    @PostMapping("/editeurs/save")
    public String saveEditeur(@ModelAttribute Editeur editeur) {
        editeurRepository.save(editeur);
        return "redirect:/admin/editeurs";
    }

    @GetMapping("/editeurs/edit/{id}")
    public String editEditeur(@PathVariable Integer id, Model model) {
        Editeur editeur = editeurRepository.findById(id).orElse(null);
        if (editeur != null) {
            model.addAttribute("editeur", editeur);
            return "admin/editeur/form";
        }
        return "redirect:/admin/editeurs";
    }

    @GetMapping("/editeurs/delete/{id}")
    public String deleteEditeur(@PathVariable Integer id) {
        editeurRepository.deleteById(id);
        return "redirect:/admin/editeurs";
    }

    // ==== PROFIL ====
    @GetMapping("/profils")
    public String listProfils(Model model) {
        model.addAttribute("profils", profilRepository.findAll());
        return "admin/profil/list";
    }

    @GetMapping("/profils/new")
    public String newProfil(Model model) {
        model.addAttribute("profil", new Profil());
        return "admin/profil/form";
    }

    @PostMapping("/profils/save")
    public String saveProfil(@ModelAttribute Profil profil) {
        profilRepository.save(profil);
        return "redirect:/admin/profils";
    }

    @GetMapping("/profils/edit/{id}")
    public String editProfil(@PathVariable Integer id, Model model) {
        Profil profil = profilRepository.findById(id).orElse(null);
        if (profil != null) {
            model.addAttribute("profil", profil);
            return "admin/profil/form";
        }
        return "redirect:/admin/profils";
    }

    @GetMapping("/profils/delete/{id}")
    public String deleteProfil(@PathVariable Integer id) {
        profilRepository.deleteById(id);
        return "redirect:/admin/profils";
    }

    // ==== TYPE PRET ====
    @GetMapping("/types-pret")
    public String listTypesPret(Model model) {
        model.addAttribute("typesPret", typePretRepository.findAll());
        return "admin/type-pret/list";
    }

    @GetMapping("/types-pret/new")
    public String newTypePret(Model model) {
        model.addAttribute("typePret", new TypePret());
        return "admin/type-pret/form";
    }

    @PostMapping("/types-pret/save")
    public String saveTypePret(@ModelAttribute TypePret typePret) {
        typePretRepository.save(typePret);
        return "redirect:/admin/types-pret";
    }

    @GetMapping("/types-pret/edit/{id}")
    public String editTypePret(@PathVariable Integer id, Model model) {
        TypePret typePret = typePretRepository.findById(id).orElse(null);
        if (typePret != null) {
            model.addAttribute("typePret", typePret);
            return "admin/type-pret/form";
        }
        return "redirect:/admin/types-pret";
    }

    @GetMapping("/types-pret/delete/{id}")
    public String deleteTypePret(@PathVariable Integer id) {
        typePretRepository.deleteById(id);
        return "redirect:/admin/types-pret";
    }

    // ==== TYPE RETOUR ====
    @GetMapping("/types-retour")
    public String listTypesRetour(Model model) {
        model.addAttribute("typesRetour", typeRetourRepository.findAll());
        return "admin/type-retour/list";
    }

    @GetMapping("/types-retour/new")
    public String newTypeRetour(Model model) {
        model.addAttribute("typeRetour", new TypeRetour());
        return "admin/type-retour/form";
    }

    @PostMapping("/types-retour/save")
    public String saveTypeRetour(@ModelAttribute TypeRetour typeRetour) {
        typeRetourRepository.save(typeRetour);
        return "redirect:/admin/types-retour";
    }

    @GetMapping("/types-retour/edit/{id}")
    public String editTypeRetour(@PathVariable Integer id, Model model) {
        TypeRetour typeRetour = typeRetourRepository.findById(id).orElse(null);
        if (typeRetour != null) {
            model.addAttribute("typeRetour", typeRetour);
            return "admin/type-retour/form";
        }
        return "redirect:/admin/types-retour";
    }

    @GetMapping("/types-retour/delete/{id}")
    public String deleteTypeRetour(@PathVariable Integer id) {
        typeRetourRepository.deleteById(id);
        return "redirect:/admin/types-retour";
    }

    // ==== STATUT RESERVATION ====
    @GetMapping("/statuts-reservation")
    public String listStatutsReservation(Model model) {
        model.addAttribute("statutsReservation", statutReservationRepository.findAll());
        return "admin/statut-reservation/list";
    }

    @GetMapping("/statuts-reservation/new")
    public String newStatutReservation(Model model) {
        model.addAttribute("statutReservation", new StatutReservation());
        return "admin/statut-reservation/form";
    }

    @PostMapping("/statuts-reservation/save")
    public String saveStatutReservation(@ModelAttribute StatutReservation statutReservation) {
        statutReservationRepository.save(statutReservation);
        return "redirect:/admin/statuts-reservation";
    }

    @GetMapping("/statuts-reservation/edit/{id}")
    public String editStatutReservation(@PathVariable Integer id, Model model) {
        StatutReservation statutReservation = statutReservationRepository.findById(id).orElse(null);
        if (statutReservation != null) {
            model.addAttribute("statutReservation", statutReservation);
            return "admin/statut-reservation/form";
        }
        return "redirect:/admin/statuts-reservation";
    }

    @GetMapping("/statuts-reservation/delete/{id}")
    public String deleteStatutReservation(@PathVariable Integer id) {
        statutReservationRepository.deleteById(id);
        return "redirect:/admin/statuts-reservation";
    }

    // Dashboard principal
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalAdmins", adminRepository.count());
        model.addAttribute("totalAuteurs", auteurRepository.count());
        model.addAttribute("totalCategories", categorieRepository.count());
        model.addAttribute("totalEditeurs", editeurRepository.count());
        model.addAttribute("totalProfils", profilRepository.count());
        return "admin/dashboard";
    }
}
