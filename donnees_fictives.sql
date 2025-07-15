-- Script de génération de données fictives pour le système de bibliothèque
-- Basé sur les entité-- 6. Types de prêt avec durées (7 types)
-- Les durées sont en jours et reflètent les besoins de chaque type d'utilisateur
INSERT INTO type_pret (type, duree_jours) VALUES
('Standard', 14),        -- 2 semaines : durée classique pour le grand public
('Court terme', 7),      -- 1 semaine : pour les emprunts rapides ou très demandés
('Long terme', 30),      -- 1 mois : pour les ouvrages spécialisés ou volumineux
('Prêt Étudiant', 21),   -- 3 semaines : adapté au rythme scolaire et universitaire
('Prêt Enseignant', 45), -- 6-7 semaines : pour préparation de cours et recherche
('Prêt Express', 3),     -- 3 jours : consultation rapide, magazines, guides
('Prêt Recherche', 60);  -- 2 mois : pour travaux de recherche approfondistuelles
-- Date de création : 14 juillet 2025

-- Nettoyage des données existantes (dans l'ordre inverse des dépendances)
DELETE FROM reservation_statut;
DELETE FROM quota_type_pret;
DELETE FROM categorie_livre;
DELETE FROM retour;
DELETE FROM fin_pret;
DELETE FROM pret;
DELETE FROM reservation;
DELETE FROM exemplaire;
DELETE FROM livre;
DELETE FROM inscription;
DELETE FROM penalite;
DELETE FROM adherant;
DELETE FROM duree_pret;
DELETE FROM restriction_categorie;
DELETE FROM profil;
DELETE FROM admin;
DELETE FROM type_pret;
DELETE FROM statut_reservation;
DELETE FROM categorie;
DELETE FROM editeur;
DELETE FROM auteur;

-- Réinitialisation des séquences (PostgreSQL)
ALTER SEQUENCE IF EXISTS auteur_id_auteur_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS editeur_id_editeur_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS categorie_id_categorie_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS profil_id_profil_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS admin_id_admin_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS adherant_id_adherant_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS livre_id_livre_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS exemplaire_id_exemplaire_seq RESTART WITH 1;

-- ===== DONNÉES DE BASE =====

-- 1. Auteurs (15 auteurs variés)
INSERT INTO auteur (nom_auteur, prenom_auteur) VALUES
('Hugo', 'Victor'),
('Camus', 'Albert'),
('Proust', 'Marcel'),
('Zola', 'Émile'),
('Balzac', 'Honoré'),
('Flaubert', 'Gustave'),
('Maupassant', 'Guy'),
('Voltaire', ''),
('Molière', ''),
('Racine', 'Jean'),
('Corneille', 'Pierre'),
('Sartre', 'Jean-Paul'),
('Beauvoir', 'Simone'),
('Duras', 'Marguerite'),
('Céline', 'Louis-Ferdinand');

-- 2. Éditeurs (10 éditeurs)
INSERT INTO editeur (nom_editeur, localisation) VALUES
('Gallimard', 'Paris'),
('Flammarion', 'Paris'),
('Seuil', 'Paris'),
('Grasset', 'Paris'),
('Albin Michel', 'Paris'),
('Fayard', 'Paris'),
('Robert Laffont', 'Paris'),
('Plon', 'Paris'),
('Éditions de Minuit', 'Paris'),
('Livre de Poche', 'Paris');

-- 3. Catégories (12 catégories)
INSERT INTO categorie (nom_categorie) VALUES
('Roman'),
('Théâtre'),
('Poésie'),
('Philosophie'),
('Histoire'),
('Sciences'),
('Biographie'),
('Essai'),
('Littérature classique'),
('Littérature contemporaine'),
('Fiction'),
('Non-fiction');

-- 4. Profils utilisateur (4 profils)
INSERT INTO profil (nom_profil, quota_pret, quota_reservation) VALUES
('Étudiant', 5, 3),
('Enseignant', 10, 5),
('Chercheur', 15, 8),
('Grand Public', 3, 2);

-- 5. Administrateurs (3 admins)
INSERT INTO admin (nom_admin, prenom_admin, password) VALUES
('Dubois', 'Marie', 'admin123'),
('Martin', 'Pierre', 'admin456'),
('Durand', 'Sophie', 'admin789');

-- 6. Type de prêt (3 types)
INSERT INTO type_pret (type, duree_jours) VALUES
('Standard', 14),
('Court terme', 7),
('Long terme', 30),
('Prêt Étudiant', 21),
('Prêt Enseignant', 45),
('Prêt Express', 3),
('Prêt Recherche', 60);

-- 7. Statut de réservation (4 statuts)
INSERT INTO statut_reservation (nom_statut) VALUES
('En attente'),
('Confirmée'),
('Annulée'),
('Expirée');

-- 8. Durée de prêt par profil
INSERT INTO duree_pret (duree, id_profil) VALUES
(14, 1), -- Étudiant: 14 jours
(21, 2), -- Enseignant: 21 jours  
(30, 3), -- Chercheur: 30 jours
(7, 4);  -- Grand Public: 7 jours

-- 9. Quota par type de prêt et profil
INSERT INTO quota_type_pret (id_profil, id_type_pret, quota) VALUES
-- Étudiant
(1, 1, 3), -- Standard: 3
(1, 2, 2), -- Court terme: 2
(1, 3, 1), -- Long terme: 1
(1, 4, 5), -- Prêt Étudiant: 5
(1, 5, 0), -- Prêt Enseignant: 0 (réservé aux enseignants)
(1, 6, 3), -- Prêt Express: 3
(1, 7, 1), -- Prêt Recherche: 1
-- Enseignant  
(2, 1, 6), -- Standard: 6
(2, 2, 3), -- Court terme: 3
(2, 3, 2), -- Long terme: 2
(2, 4, 4), -- Prêt Étudiant: 4
(2, 5, 8), -- Prêt Enseignant: 8
(2, 6, 5), -- Prêt Express: 5
(2, 7, 3), -- Prêt Recherche: 3
-- Chercheur
(3, 1, 10), -- Standard: 10
(3, 2, 5),  -- Court terme: 5
(3, 3, 3),  -- Long terme: 3
(3, 4, 6),  -- Prêt Étudiant: 6
(3, 5, 10), -- Prêt Enseignant: 10
(3, 6, 8),  -- Prêt Express: 8
(3, 7, 15), -- Prêt Recherche: 15 (priorité recherche)
-- Grand Public
(4, 1, 2), -- Standard: 2
(4, 2, 1), -- Court terme: 1
(4, 3, 0), -- Long terme: 0
(4, 4, 0), -- Prêt Étudiant: 0
(4, 5, 0), -- Prêt Enseignant: 0
(4, 6, 2), -- Prêt Express: 2
(4, 7, 0); -- Prêt Recherche: 0

-- ===== ADHÉRENTS =====

-- 10. Adhérents (20 adhérents)
INSERT INTO adherant (numero_adherant, nom_adherant, prenom_adherant, password, date_naissance, id_profil) VALUES
(1001, 'Dupont', 'Jean', 'pass123', '1995-05-15', 1),
(1002, 'Moreau', 'Alice', 'pass456', '1998-03-22', 1),
(1003, 'Bernard', 'Paul', 'pass789', '1990-11-08', 2),
(1004, 'Petit', 'Emma', 'pass101', '1985-07-12', 2),
(1005, 'Robert', 'Lucas', 'pass202', '1975-09-30', 3),
(1006, 'Richard', 'Julie', 'pass303', '1992-01-18', 1),
(1007, 'Michel', 'Antoine', 'pass404', '1988-04-25', 2),
(1008, 'Garcia', 'Sofia', 'pass505', '1996-12-03', 1),
(1009, 'David', 'Thomas', 'pass606', '1983-06-14', 3),
(1010, 'Bertrand', 'Camille', 'pass707', '1999-08-27', 4),
(1011, 'Roux', 'Alexandre', 'pass808', '1991-02-09', 1),
(1012, 'Vincent', 'Léa', 'pass909', '1987-10-16', 2),
(1013, 'Leroy', 'Hugo', 'pass010', '1994-05-21', 1),
(1014, 'Fournier', 'Chloé', 'pass111', '1986-09-07', 4),
(1015, 'Girard', 'Maxime', 'pass212', '1993-12-19', 1),
(1016, 'Andre', 'Manon', 'pass313', '1989-03-11', 2),
(1017, 'Lefebvre', 'Nathan', 'pass414', '1997-07-04', 1),
(1018, 'Lambert', 'Océane', 'pass515', '1984-11-28', 3),
(1019, 'Lopez', 'Julien', 'pass616', '1995-01-15', 4),
(1020, 'Martin', 'Inès', 'pass717', '1990-06-23', 2);

-- ===== LIVRES ET EXEMPLAIRES =====

-- 11. Livres (25 livres variés)
INSERT INTO livre (titre, isbn, langue, annee_publication, synopsis, nb_page, age_requis, id_editeur, id_auteur) VALUES
('Les Misérables', '978-2-07-040570-8', 'Français', 1862, 'Une épopée de la condition humaine dans la France du XIXe siècle.', 1088, 14, 1, 1),
('L''Étranger', '978-2-07-036002-1', 'Français', 1942, 'L''histoire de Meursault, un homme indifférent au monde qui l''entoure.', 186, 16, 1, 2),
('Du côté de chez Swann', '978-2-07-037067-9', 'Français', 1913, 'Premier tome de À la recherche du temps perdu.', 531, 18, 1, 3),
('Germinal', '978-2-253-00135-7', 'Français', 1885, 'La condition ouvrière dans les mines du Nord de la France.', 592, 15, 10, 4),
('Le Père Goriot', '978-2-253-08200-2', 'Français', 1835, 'Un père dévoué ruiné par l''ingratitude de ses filles.', 384, 16, 10, 5),
('Madame Bovary', '978-2-253-00696-3', 'Français', 1857, 'L''histoire d''Emma Bovary et de ses rêves romantiques.', 496, 17, 10, 6),
('Boule de Suif', '978-2-253-00124-1', 'Français', 1880, 'Nouvelles sur la guerre franco-prussienne.', 192, 15, 10, 7),
('Candide', '978-2-253-00029-9', 'Français', 1759, 'Conte philosophique sur l''optimisme.', 128, 14, 10, 8),
('Le Misanthrope', '978-2-253-00547-8', 'Français', 1666, 'Comédie sur Alceste et sa misanthropie.', 96, 15, 10, 9),
('Phèdre', '978-2-253-00123-4', 'Français', 1677, 'Tragédie inspirée de la mythologie grecque.', 112, 16, 10, 10),
('Le Cid', '978-2-253-00458-7', 'Français', 1637, 'Tragi-comédie sur l''honneur et l''amour.', 128, 15, 10, 11),
('La Nausée', '978-2-07-036001-4', 'Français', 1938, 'Roman philosophique sur l''existence.', 256, 17, 1, 12),
('Le Deuxième Sexe', '978-2-07-020011-0', 'Français', 1949, 'Essai fondateur du féminisme moderne.', 654, 18, 1, 13),
('L''Amant', '978-2-7073-0268-9', 'Français', 1984, 'Roman autobiographique sur l''amour et l''Indochine.', 144, 16, 9, 14),
('Voyage au bout de la nuit', '978-2-07-036003-8', 'Français', 1932, 'Odyssée nihiliste de Ferdinand Bardamu.', 505, 18, 1, 15),
('Notre-Dame de Paris', '978-2-253-00614-7', 'Français', 1831, 'Roman gothique autour de la cathédrale parisienne.', 688, 14, 10, 1),
('La Peste', '978-2-07-036004-5', 'Français', 1947, 'Allégorie de la condition humaine face à l''absurde.', 329, 16, 1, 2),
('Le Temps retrouvé', '978-2-07-037068-6', 'Français', 1927, 'Dernier tome de À la recherche du temps perdu.', 387, 18, 1, 3),
('La Bête humaine', '978-2-253-00416-7', 'Français', 1890, 'Roman sur la violence et les passions destructrices.', 448, 17, 10, 4),
('Eugénie Grandet', '978-2-253-00567-6', 'Français', 1833, 'Portrait de l''avarice et de ses conséquences.', 256, 15, 10, 5),
('Salammbô', '978-2-253-00698-7', 'Français', 1862, 'Roman historique sur Carthage antique.', 432, 16, 10, 6),
('Pierre et Jean', '978-2-253-00125-8', 'Français', 1888, 'Roman psychologique sur la jalousie fraternelle.', 192, 16, 10, 7),
('Zadig', '978-2-253-00030-5', 'Français', 1747, 'Conte philosophique oriental.', 96, 14, 10, 8),
('L''Avare', '978-2-253-00548-5', 'Français', 1668, 'Comédie sur l''avarice d''Harpagon.', 112, 15, 10, 9),
('Britannicus', '978-2-253-00124-8', 'Français', 1669, 'Tragédie sur le pouvoir et la tyrannie.', 96, 16, 10, 10);

-- 12. Relations livre-catégorie
INSERT INTO categorie_livre (id_livre, id_categorie) VALUES
-- Les Misérables
(1, 1), (1, 9),
-- L'Étranger  
(2, 1), (2, 4),
-- Du côté de chez Swann
(3, 1), (3, 9),
-- Germinal
(4, 1), (4, 5),
-- Le Père Goriot
(5, 1), (5, 9),
-- Madame Bovary
(6, 1), (6, 9),
-- Boule de Suif
(7, 1), (7, 5),
-- Candide
(8, 4), (8, 9),
-- Le Misanthrope
(9, 2), (9, 9),
-- Phèdre
(10, 2), (10, 9),
-- Le Cid
(11, 2), (11, 9),
-- La Nausée
(12, 1), (12, 4),
-- Le Deuxième Sexe
(13, 8), (13, 4),
-- L'Amant
(14, 1), (14, 10),
-- Voyage au bout de la nuit
(15, 1), (15, 10),
-- Notre-Dame de Paris
(16, 1), (16, 9),
-- La Peste
(17, 1), (17, 4),
-- Le Temps retrouvé
(18, 1), (18, 9),
-- La Bête humaine
(19, 1), (19, 9),
-- Eugénie Grandet
(20, 1), (20, 9),
-- Salammbô
(21, 1), (21, 5),
-- Pierre et Jean
(22, 1), (22, 9),
-- Zadig
(23, 4), (23, 9),
-- L'Avare
(24, 2), (24, 9),
-- Britannicus
(25, 2), (25, 9);

-- 13. Exemplaires (2-4 exemplaires par livre)
INSERT INTO exemplaire (id_livre) VALUES
-- Les Misérables (3 exemplaires)
(1), (1), (1),
-- L'Étranger (4 exemplaires)
(2), (2), (2), (2),
-- Du côté de chez Swann (2 exemplaires)
(3), (3),
-- Germinal (3 exemplaires)
(4), (4), (4),
-- Le Père Goriot (3 exemplaires)
(5), (5), (5),
-- Madame Bovary (4 exemplaires)
(6), (6), (6), (6),
-- Boule de Suif (2 exemplaires)
(7), (7),
-- Candide (4 exemplaires)
(8), (8), (8), (8),
-- Le Misanthrope (2 exemplaires)
(9), (9),
-- Phèdre (2 exemplaires)
(10), (10),
-- Le Cid (3 exemplaires)
(11), (11), (11),
-- La Nausée (3 exemplaires)
(12), (12), (12),
-- Le Deuxième Sexe (2 exemplaires)
(13), (13),
-- L'Amant (3 exemplaires)
(14), (14), (14),
-- Voyage au bout de la nuit (2 exemplaires)
(15), (15),
-- Notre-Dame de Paris (4 exemplaires)
(16), (16), (16), (16),
-- La Peste (3 exemplaires)
(17), (17), (17),
-- Le Temps retrouvé (2 exemplaires)
(18), (18),
-- La Bête humaine (3 exemplaires)
(19), (19), (19),
-- Eugénie Grandet (3 exemplaires)
(20), (20), (20),
-- Salammbô (2 exemplaires)
(21), (21),
-- Pierre et Jean (3 exemplaires)
(22), (22), (22),
-- Zadig (4 exemplaires)
(23), (23), (23), (23),
-- L'Avare (2 exemplaires)
(24), (24),
-- Britannicus (2 exemplaires)
(25), (25);

-- ===== INSCRIPTIONS =====

-- 14. Inscriptions des adhérents (tous actifs pour juillet 2025)
-- Date actuelle : 14 juillet 2025 - Toutes les inscriptions sont valides à cette date
INSERT INTO inscription (date_debut, date_fin, id_adherant) VALUES
-- Inscriptions commencées en 2024 et se terminant en fin 2025 ou 2026
('2024-06-01 00:00:00', '2025-12-31 23:59:59', 1),  -- Dupont Jean (Étudiant) - Actif jusqu'à fin 2025
('2024-07-15 00:00:00', '2026-01-15 23:59:59', 2),  -- Moreau Alice (Étudiant) - Actif jusqu'à janvier 2026
('2024-05-01 00:00:00', '2025-11-01 23:59:59', 3),  -- Bernard Paul (Enseignant) - Actif jusqu'à novembre 2025
('2024-08-10 00:00:00', '2026-02-10 23:59:59', 4),  -- Petit Emma (Enseignant) - Actif jusqu'à février 2026
('2024-04-15 00:00:00', '2025-10-15 23:59:59', 5),  -- Robert Lucas (Chercheur) - Actif jusqu'à octobre 2025

-- Inscriptions commencées en 2025 et se terminant en 2026
('2025-01-01 00:00:00', '2026-06-01 23:59:59', 6),  -- Richard Julie (Étudiant) - Actif jusqu'à juin 2026
('2025-02-01 00:00:00', '2026-08-01 23:59:59', 7),  -- Michel Antoine (Enseignant) - Actif jusqu'à août 2026
('2025-03-01 00:00:00', '2026-09-01 23:59:59', 8),  -- Garcia Sofia (Étudiant) - Actif jusqu'à septembre 2026
('2025-01-15 00:00:00', '2026-07-15 23:59:59', 9),  -- David Thomas (Chercheur) - Actif jusqu'à juillet 2026
('2025-04-01 00:00:00', '2026-10-01 23:59:59', 10), -- Bertrand Camille (Grand Public) - Actif jusqu'à octobre 2026

-- Inscriptions récentes (commencées en juin/juillet 2025)
('2025-06-01 00:00:00', '2026-12-01 23:59:59', 11), -- Roux Alexandre (Étudiant) - Actif jusqu'à décembre 2026
('2025-06-15 00:00:00', '2026-12-15 23:59:59', 12), -- Vincent Léa (Enseignant) - Actif jusqu'à décembre 2026
('2025-07-01 00:00:00', '2027-01-01 23:59:59', 13), -- Leroy Hugo (Étudiant) - Actif jusqu'à janvier 2027
('2025-05-15 00:00:00', '2026-11-15 23:59:59', 14), -- Fournier Chloé (Grand Public) - Actif jusqu'à novembre 2026
('2025-07-10 00:00:00', '2027-01-10 23:59:59', 15), -- Girard Maxime (Étudiant) - Actif jusqu'à janvier 2027

-- Inscriptions très récentes (juillet 2025)
('2025-07-01 00:00:00', '2026-07-01 23:59:59', 16), -- Andre Manon (Enseignant) - Actif 1 an
('2025-07-05 00:00:00', '2026-07-05 23:59:59', 17), -- Lefebvre Nathan (Étudiant) - Actif 1 an  
('2025-06-20 00:00:00', '2026-06-20 23:59:59', 18), -- Lambert Océane (Chercheur) - Actif 1 an
('2025-07-12 00:00:00', '2026-07-12 23:59:59', 19), -- Lopez Julien (Grand Public) - Actif 1 an
('2025-07-01 00:00:00', '2026-07-01 23:59:59', 20); -- Martin Inès (Enseignant) - Actif 1 an

-- ===== ADHÉRENTS SUPPLÉMENTAIRES POUR TESTS =====

-- Ajout d'adhérents avec inscriptions expirées (pour tester les validations)
INSERT INTO adherant (numero_adherant, nom_adherant, prenom_adherant, password, date_naissance, id_profil) VALUES
(1021, 'Teste', 'Expire', 'pass818', '1995-03-12', 1),
(1022, 'Inactive', 'Marie', 'pass919', '1990-08-05', 4);

-- Inscriptions expirées pour tests
INSERT INTO inscription (date_debut, date_fin, id_adherant) VALUES
('2024-01-01 00:00:00', '2025-01-01 23:59:59', 21), -- Teste Expire - EXPIRÉ (fin janvier 2025)
('2023-06-01 00:00:00', '2024-06-01 23:59:59', 22); -- Inactive Marie - EXPIRÉ (fin juin 2024)

-- ===== RESTRICTIONS =====

-- 15. Restrictions par catégorie et profil (quelques restrictions)
INSERT INTO restriction_categorie (id_categorie, id_profil) VALUES
-- Les étudiants ne peuvent pas emprunter certains livres de philosophie avancée
(4, 1),
-- Le grand public ne peut pas emprunter certains ouvrages spécialisés
(6, 4),
(8, 4);

-- ===== ACTIVITÉS (PRÊTS ET RÉSERVATIONS) =====

-- 16. Prêts actifs (15 prêts en cours)
INSERT INTO pret (date_debut, id_admin, id_type_pret, id_exemplaire, id_adherant) VALUES
('2025-07-01', 1, 1, 1, 1),   -- Les Misérables
('2025-07-03', 2, 1, 5, 2),   -- L'Étranger  
('2025-07-05', 1, 2, 10, 3),  -- Germinal
('2025-07-07', 3, 1, 15, 4),  -- Le Père Goriot
('2025-07-08', 2, 1, 19, 5),  -- Madame Bovary
('2025-07-10', 1, 3, 25, 6),  -- Candide
('2025-07-12', 3, 1, 30, 7),  -- Le Cid
('2025-07-13', 2, 1, 35, 8),  -- La Nausée
('2025-07-14', 1, 2, 40, 9),  -- L'Amant
('2025-07-09', 3, 1, 45, 10), -- Notre-Dame de Paris
('2025-07-11', 2, 1, 50, 11), -- La Peste
('2025-07-06', 1, 1, 55, 12), -- La Bête humaine
('2025-07-04', 3, 2, 60, 13), -- Eugénie Grandet
('2025-07-02', 2, 1, 65, 14), -- Pierre et Jean
('2025-07-08', 1, 1, 70, 15); -- Zadig

-- 17. Réservations (8 réservations en attente)
INSERT INTO reservation (date_de_reservation, id_admin, id_exemplaire, id_adherant) VALUES
('2025-07-14', 1, 2, 16),  -- Les Misérables
('2025-07-13', 2, 6, 17),  -- L'Étranger
('2025-07-12', 3, 11, 18), -- Germinal  
('2025-07-11', 1, 16, 19), -- Le Père Goriot
('2025-07-10', 2, 20, 20), -- Madame Bovary
('2025-07-09', 3, 26, 1),  -- Candide
('2025-07-08', 1, 31, 2),  -- Le Cid
('2025-07-07', 2, 36, 3);  -- La Nausée

-- 18. Statuts des réservations
INSERT INTO reservation_statut (id_reservation, id_statut_reservation) VALUES
(1, 1), -- En attente
(2, 1), -- En attente
(3, 2), -- Confirmée
(4, 1), -- En attente
(5, 2), -- Confirmée
(6, 1), -- En attente
(7, 2), -- Confirmée
(8, 1); -- En attente

-- ===== HISTORIQUE =====

-- 19. Quelques retours déjà effectués (5 prêts terminés)
INSERT INTO retour (date_retour, id_pret) VALUES
('2025-06-15', 1),  -- Retour fictif pour test
('2025-06-20', 2),  -- Retour fictif pour test
('2025-06-25', 3),  -- Retour fictif pour test
('2025-06-28', 4),  -- Retour fictif pour test
('2025-07-02', 5);  -- Retour fictif pour test

-- Note: Ces prêts avec ID 1-5 sont fictifs pour l'historique
-- Les vrais prêts actifs commencent avec les données insérées plus haut

-- ===== VÉRIFICATIONS =====

-- Affichage de quelques statistiques pour vérifier les données
SELECT 
    'Auteurs' as Type, COUNT(*) as Nombre FROM auteur
UNION ALL SELECT 
    'Éditeurs' as Type, COUNT(*) as Nombre FROM editeur  
UNION ALL SELECT
    'Livres' as Type, COUNT(*) as Nombre FROM livre
UNION ALL SELECT
    'Exemplaires' as Type, COUNT(*) as Nombre FROM exemplaire
UNION ALL SELECT
    'Adhérents' as Type, COUNT(*) as Nombre FROM adherant
UNION ALL SELECT
    'Prêts actifs' as Type, COUNT(*) as Nombre FROM pret WHERE id_pret NOT IN (SELECT id_pret FROM retour)
UNION ALL SELECT
    'Réservations' as Type, COUNT(*) as Nombre FROM reservation;

-- Message de fin
SELECT 'Script de données fictives exécuté avec succès !' as Message;

-- ===== JOURS FÉRIÉS =====

-- Jours fériés fixes (récurrents chaque année)
INSERT INTO jour_ferier (nom_jour, date_ferier, annee, recurrent) VALUES
('Nouvel An', '2025-01-01', 2025, true),
('Fête du Travail', '2025-05-01', 2025, true),
('Fête de la Victoire', '2025-05-08', 2025, true),
('Fête Nationale', '2025-07-14', 2025, true),
('Assomption', '2025-08-15', 2025, true),
('Toussaint', '2025-11-01', 2025, true),
('Armistice', '2025-11-11', 2025, true),
('Noël', '2025-12-25', 2025, true);

-- Jours fériés variables pour 2025 (non récurrents)
INSERT INTO jour_ferier (nom_jour, date_ferier, annee, recurrent) VALUES
('Lundi de Pâques', '2025-04-21', 2025, false),
('Ascension', '2025-05-29', 2025, false),
('Lundi de Pentecôte', '2025-06-09', 2025, false);

-- Jours fériés variables pour 2026 (exemples)
INSERT INTO jour_ferier (nom_jour, date_ferier, annee, recurrent) VALUES
('Lundi de Pâques', '2026-04-06', 2026, false),
('Ascension', '2026-05-14', 2026, false),
('Lundi de Pentecôte', '2026-05-25', 2026, false);

-- ===== DONNÉES DE BASE =====
