<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Système de Gestion de Bibliothèque</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .stats-card {
            transition: transform 0.2s;
        }
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .menu-card {
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s;
        }
        .menu-card:hover {
            color: inherit;
            transform: scale(1.05);
        }
        .bg-outline {
            background-color: #f8f9fa;
            border: 2px solid #6c757d;
        }
        .bg-outline:hover {
            background-color: #e9ecef;
        }
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/adherants">Adhérents</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/livres">Livres</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/prets">
                            <i class="fas fa-handshake"></i> Prêts
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/auteurs">Auteurs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/editeurs">Éditeurs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/categories">Catégories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/Prolongement">
                            <i class="fas fa-clock"></i> Prolongements
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/reservations">
                            <i class="fas fa-calendar-check"></i> Réservations
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/retours">
                            <i class="fas fa-undo"></i> Retours
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                            Administration
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/admin/admins">Administrateurs</a></li>
                            <li><a class="dropdown-item" href="/admin/auteurs">Auteurs</a></li>
                            <li><a class="dropdown-item" href="/admin/editeurs">Éditeurs</a></li>
                            <li><a class="dropdown-item" href="/admin/categories">Catégories</a></li>
                            <li><a class="dropdown-item" href="/admin/profils">Profils</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/admin/types-pret">Types de Prêt</a></li>
                            <li><a class="dropdown-item" href="/admin/types-retour">Types de Retour</a></li>
                            <li><a class="dropdown-item" href="/admin/statuts-reservation">Statuts Réservation</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="jumbotron bg-white p-5 rounded shadow-sm text-center mb-5">
                    <h1 class="display-4">
                        <i class="fas fa-book text-primary"></i>
                        Système de Gestion de Bibliothèque
                    </h1>
                    <p class="lead">Gérez facilement votre bibliothèque, vos adhérents et vos livres</p>
                </div>
            </div>
        </div>

        <!-- Statistiques -->
        <div class="row mb-5">
            <div class="col-md-4">
                <div class="card stats-card border-0 shadow-sm">
                    <div class="card-body text-center">
                        <div class="text-primary mb-3">
                            <i class="fas fa-users fa-3x"></i>
                        </div>
                        <h3 class="text-primary">${totalAdherants}</h3>
                        <p class="text-muted">Adhérents Inscrits</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stats-card border-0 shadow-sm">
                    <div class="card-body text-center">
                        <div class="text-success mb-3">
                            <i class="fas fa-book fa-3x"></i>
                        </div>
                        <h3 class="text-success">${totalLivres}</h3>
                        <p class="text-muted">Livres Disponibles</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stats-card border-0 shadow-sm">
                    <div class="card-body text-center">
                        <div class="text-warning mb-3">
                            <i class="fas fa-handshake fa-3x"></i>
                        </div>
                        <h3 class="text-warning">${totalPrets}</h3>
                        <p class="text-muted">Prêts Actifs</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Menu principal -->
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4 text-center">Gestion</h2>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <a href="/adherants" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-primary text-white">
                        <div class="text-center">
                            <i class="fas fa-users fa-4x mb-3"></i>
                            <h4>Gestion des Adhérents</h4>
                            <p>Ajouter, modifier, consulter les adhérents</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <a href="/livres" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-success text-white">
                        <div class="text-center">
                            <i class="fas fa-book fa-4x mb-3"></i>
                            <h4>Gestion des Livres</h4>
                            <p>Catalogue, gestion des ouvrages</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <a href="/prets" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-dark text-white">
                        <div class="text-center">
                            <i class="fas fa-handshake fa-4x mb-3"></i>
                            <h4>Gestion des Prêts</h4>
                            <p>Créer et suivre les prêts de livres</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <a href="/reservations" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-info text-white">
                        <div class="text-center">
                            <i class="fas fa-calendar-check fa-4x mb-3"></i>
                            <h4>Gestion des Réservations</h4>
                            <p>Réserver et gérer les réservations</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <a href="/retours" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-danger text-white">
                        <div class="text-center">
                            <i class="fas fa-undo fa-4x mb-3"></i>
                            <h4>Gestion des Retours</h4>
                            <p>Traiter les retours de livres</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <a href="/Prolongement" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-gradient text-white" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <div class="text-center">
                            <i class="fas fa-clock fa-4x mb-3"></i>
                            <h4>Prolongement de Prêt</h4>
                            <p>Prolonger la durée des prêts</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <a href="/auteurs" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-secondary text-white">
                        <div class="text-center">
                            <i class="fas fa-pen-fancy fa-4x mb-3"></i>
                            <h4>Gestion des Auteurs</h4>
                            <p>Ajouter, modifier les auteurs</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <a href="/editeurs" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-warning text-white">
                        <div class="text-center">
                            <i class="fas fa-building fa-4x mb-3"></i>
                            <h4>Gestion des Éditeurs</h4>
                            <p>Ajouter, modifier les maisons d'édition</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <a href="/categories" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-outline text-dark">
                        <div class="text-center">
                            <i class="fas fa-tags fa-4x mb-3"></i>
                            <h4>Gestion des Catégories</h4>
                            <p>Organiser les livres par catégories</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <a href="/admin/dashboard" class="text-decoration-none">
                    <div class="card menu-card border-0 shadow-sm bg-dark text-white">
                        <div class="text-center">
                            <i class="fas fa-cogs fa-4x mb-3"></i>
                            <h4>Administration</h4>
                            <p>Configuration du système</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <!-- Actions rapides -->
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4 text-center">Actions Rapides</h2>
            </div>
        </div>

        <div class="row mb-5">
            <div class="col-md-3 mb-3">
                <a href="/adherants/new" class="btn btn-outline-primary btn-lg w-100">
                    <i class="fas fa-user-plus mb-2"></i><br>
                    Nouvel Adhérent
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="/livres/new" class="btn btn-outline-success btn-lg w-100">
                    <i class="fas fa-book-open mb-2"></i><br>
                    Nouveau Livre
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="/prets/new" class="btn btn-outline-primary btn-lg w-100">
                    <i class="fas fa-handshake mb-2"></i><br>
                    Nouveau Prêt
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="/reservations/new" class="btn btn-outline-info btn-lg w-100">
                    <i class="fas fa-calendar-check mb-2"></i><br>
                    Nouvelle Réservation
                </a>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <div class="container">
            <p>&copy; 2025 Système de Gestion de Bibliothèque. Tous droits réservés.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
