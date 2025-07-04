<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord - Adhérent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .dashboard-card {
            transition: transform 0.2s;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .feature-card {
            height: 180px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s;
            border-radius: 15px;
        }
        .feature-card:hover {
            color: inherit;
            transform: scale(1.05);
        }
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/adherant/dashboard">
                <i class="fas fa-book"></i> Bibliothèque - Espace Adhérent
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/adherant/dashboard">
                            <i class="fas fa-home"></i> Accueil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/livres">
                            <i class="fas fa-book"></i> Catalogue
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/reservations/new">
                            <i class="fas fa-calendar-check"></i> Réserver
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user"></i> ${sessionScope.userName}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/logout">
                                <i class="fas fa-sign-out-alt"></i> Déconnexion
                            </a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Section de bienvenue -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="welcome-section p-4 text-center">
                    <h1 class="display-5">
                        <i class="fas fa-user-circle"></i>
                        Bienvenue, ${adherant.prenomAdherant} !
                    </h1>
                    <p class="lead">
                        Accédez à votre espace personnel pour consulter le catalogue et effectuer vos réservations
                    </p>
                </div>
            </div>
        </div>

        <!-- Informations personnelles -->
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="card dashboard-card shadow-sm">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-id-card"></i> Vos Informations</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Nom complet :</strong> ${adherant.nomAdherant} ${adherant.prenomAdherant}</p>
                                <p><strong>Numéro d'adhérent :</strong> ${adherant.numeroAdherant}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Profil :</strong> 
                                    <span class="badge bg-primary">${adherant.profil.nomProfil}</span>
                                </p>
                                <p><strong>Date de naissance :</strong> ${adherant.dateNaissance}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card dashboard-card shadow-sm">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="fas fa-chart-bar"></i> Vos Quotas</h5>
                    </div>
                    <div class="card-body text-center">
                        <p><strong>Prêts autorisés :</strong><br>
                            <span class="h4 text-success">${adherant.profil.quotaPret}</span>
                        </p>
                        <p><strong>Réservations autorisées :</strong><br>
                            <span class="h4 text-info">${adherant.profil.quotaReservation}</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Fonctionnalités disponibles -->
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4 text-center">Que souhaitez-vous faire ?</h2>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-6 mb-3">
                <a href="/livres" class="text-decoration-none">
                    <div class="card feature-card border-0 shadow-sm bg-success text-white">
                        <div class="text-center">
                            <i class="fas fa-book fa-4x mb-3"></i>
                            <h4>Consulter le Catalogue</h4>
                            <p>Parcourez tous les livres disponibles</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 mb-3">
                <a href="/reservations/new" class="text-decoration-none">
                    <div class="card feature-card border-0 shadow-sm bg-info text-white">
                        <div class="text-center">
                            <i class="fas fa-calendar-check fa-4x mb-3"></i>
                            <h4>Réserver un Livre</h4>
                            <p>Effectuez une nouvelle réservation</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <!-- Instructions -->
        <div class="row">
            <div class="col-12">
                <div class="card dashboard-card shadow-sm">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0"><i class="fas fa-info-circle"></i> Instructions</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="text-primary">Consultation du catalogue</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success"></i> Parcourez tous les livres disponibles</li>
                                    <li><i class="fas fa-check text-success"></i> Consultez les détails de chaque ouvrage</li>
                                    <li><i class="fas fa-check text-success"></i> Vérifiez la disponibilité</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6 class="text-info">Réservations</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success"></i> Réservez jusqu'à ${adherant.profil.quotaReservation} livre(s)</li>
                                    <li><i class="fas fa-check text-success"></i> Venez récupérer vos livres réservés</li>
                                    <li><i class="fas fa-check text-success"></i> Respectez les délais de retrait</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <div class="container">
            <p>&copy; 2025 Système de Gestion de Bibliothèque. Espace Adhérent.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
