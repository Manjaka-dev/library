<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails du Livre - ${livre.titre}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .book-cover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 350px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 4rem;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        }
        .book-details {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .reservation-card {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(40, 167, 69, 0.3);
        }
        .admin-actions {
            background: linear-gradient(135deg, #dc3545 0%, #fd7e14 100%);
            color: white;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
        }
        .info-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .category-badge {
            background: linear-gradient(45deg, #6f42c1, #e83e8c);
            color: white;
            border: none;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation adaptée au type d'utilisateur -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque
            </a>
            <div class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${sessionScope.userType == 'adherant'}">
                        <a class="nav-link" href="/adherant/dashboard">
                            <i class="fas fa-user"></i> Dashboard
                        </a>
                    </c:when>
                    <c:when test="${sessionScope.userType == 'admin'}">
                        <a class="nav-link" href="/admin/dashboard">
                            <i class="fas fa-user-shield"></i> Dashboard Admin
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="nav-link" href="/">
                            <i class="fas fa-home"></i> Accueil
                        </a>
                    </c:otherwise>
                </c:choose>
                <a class="nav-link" href="/livres">
                    <i class="fas fa-books"></i> Catalogue
                </a>
                <c:if test="${not empty sessionScope.userType}">
                    <a class="nav-link" href="/logout">
                        <i class="fas fa-sign-out-alt"></i> Déconnexion
                    </a>
                </c:if>
                <c:if test="${empty sessionScope.userType}">
                    <a class="nav-link" href="/login">
                        <i class="fas fa-sign-in-alt"></i> Connexion
                    </a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- En-tête avec titre et actions -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="text-primary">
                        <i class="fas fa-book-open"></i> Détails du Livre
                    </h2>
                    <div>
                        <!-- Actions pour les administrateurs uniquement -->
                        <c:if test="${sessionScope.userType == 'admin'}">
                            <a href="/livres/edit/${livre.idLivre}" class="btn btn-warning me-2">
                                <i class="fas fa-edit"></i> Modifier
                            </a>
                        </c:if>
                        <a href="/livres" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Retour au Catalogue
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Colonne gauche - Couverture et actions -->
            <div class="col-lg-4 mb-4">
                <!-- Couverture du livre -->
                <div class="book-cover mb-4">
                    <i class="fas fa-book-open"></i>
                </div>
                
                <!-- Actions pour les adhérents -->
                <c:if test="${sessionScope.userType == 'adherant'}">
                    <div class="card reservation-card mb-4">
                        <div class="card-body text-center">
                            <h5 class="card-title">
                                <i class="fas fa-calendar-check"></i> Réservation
                            </h5>
                            <p class="card-text">Ce livre est disponible pour vous</p>
                            <div class="d-grid gap-2">
                                <a href="/reservations/new?livreId=${livre.idLivre}" class="btn btn-light btn-lg">
                                    <i class="fas fa-plus"></i> Réserver ce Livre
                                </a>
                                <a href="/prets/new?livreId=${livre.idLivre}" class="btn btn-outline-light">
                                    <i class="fas fa-handshake"></i> Emprunter directement
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Actions administrateur -->
                <c:if test="${sessionScope.userType == 'admin'}">
                    <div class="card admin-actions">
                        <div class="card-body">
                            <h5 class="card-title">
                                <i class="fas fa-cogs"></i> Actions Administrateur
                            </h5>
                            <div class="d-grid gap-2">
                                <a href="/livres/edit/${livre.idLivre}" class="btn btn-light">
                                    <i class="fas fa-edit"></i> Modifier le Livre
                                </a>
                                <a href="/prets/new?livreId=${livre.idLivre}" class="btn btn-light">
                                    <i class="fas fa-handshake"></i> Créer un Prêt
                                </a>
                                <a href="/exemplaires?livreId=${livre.idLivre}" class="btn btn-light">
                                    <i class="fas fa-copies"></i> Gérer les Exemplaires
                                </a>
                                <hr>
                                <a href="/livres/delete/${livre.idLivre}" class="btn btn-outline-light"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce livre ?\nCette action est irréversible.')">
                                    <i class="fas fa-trash"></i> Supprimer
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Message pour les utilisateurs non connectés -->
                <c:if test="${empty sessionScope.userType}">
                    <div class="card">
                        <div class="card-body bg-light text-center">
                            <h6 class="card-title">
                                <i class="fas fa-user-slash text-muted"></i> Accès Invité
                            </h6>
                            <p class="card-text text-muted">
                                Vous consultez le catalogue en mode lecture seule.
                            </p>
                            <a href="/login" class="btn btn-primary btn-sm">
                                <i class="fas fa-sign-in-alt"></i> Se Connecter
                            </a>
                        </div>
                    </div>
                </c:if>
                
                <!-- Informations de disponibilité pour tous -->
                <div class="card info-card mt-4">
                    <div class="card-body">
                        <h6 class="card-title">
                            <i class="fas fa-info-circle text-info"></i> Disponibilité
                        </h6>
                        <div class="d-flex justify-content-between align-items-center">
                            <span>Exemplaires disponibles:</span>
                            <span class="badge bg-success fs-6">
                                ${livre.exemplaires != null ? livre.exemplaires.size() : 0}
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Colonne droite - Détails du livre -->
            <div class="col-lg-8">
                <div class="card info-card">
                    <div class="card-body">
                        <div class="row mb-4">
                            <div class="col-12">
                                <h3 class="card-title text-primary mb-1">${livre.titre}</h3>
                                <p class="text-muted fs-5 mb-3">
                                    <i class="fas fa-user"></i> ${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}
                                </p>
                                
                                <!-- Catégories -->
                                <div class="mb-3">
                                    <c:forEach var="categorie" items="${livre.categories}">
                                        <span class="badge category-badge me-2 p-2">
                                            <i class="fas fa-tag"></i> ${categorie.nomCategorie}
                                        </span>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        
                        <div class="book-details">
                            <div class="row">
                                <!-- Informations générales -->
                                <div class="col-md-6">
                                    <h6 class="text-primary mb-3">
                                        <i class="fas fa-info-circle"></i> Informations Générales
                                    </h6>
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="40%" class="text-muted">ID Livre:</th>
                                            <td><span class="badge bg-secondary">${livre.idLivre}</span></td>
                                        </tr>
                                        <tr>
                                            <th class="text-muted">ISBN:</th>
                                            <td><code>${livre.isbn}</code></td>
                                        </tr>
                                        <tr>
                                            <th class="text-muted">Langue:</th>
                                            <td>
                                                <i class="fas fa-language"></i> ${livre.langue}
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="text-muted">Année:</th>
                                            <td>
                                                <i class="fas fa-calendar"></i> ${livre.anneePublication}
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="text-muted">Pages:</th>
                                            <td>
                                                <i class="fas fa-file-alt"></i> ${livre.nbPage} pages
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <!-- Informations éditoriales -->
                                <div class="col-md-6">
                                    <h6 class="text-primary mb-3">
                                        <i class="fas fa-building"></i> Informations Éditoriales
                                    </h6>
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="40%" class="text-muted">Auteur:</th>
                                            <td>
                                                <strong>${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}</strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="text-muted">Éditeur:</th>
                                            <td>
                                                <i class="fas fa-building"></i> ${livre.editeur.nomEditeur}
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="text-muted">Localisation:</th>
                                            <td>
                                                <i class="fas fa-map-marker-alt"></i> ${livre.editeur.localisation}
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            
                            <!-- Synopsis -->
                            <div class="row mt-4">
                                <div class="col-12">
                                    <h6 class="text-primary mb-3">
                                        <i class="fas fa-align-left"></i> Synopsis
                                    </h6>
                                    <div class="bg-white p-4 border-start border-primary border-4 rounded">
                                        <p class="mb-0" style="text-align: justify; line-height: 1.6;">
                                            <c:choose>
                                                <c:when test="${empty livre.synopsis}">
                                                    <em class="text-muted">Aucun synopsis disponible pour ce livre.</em>
                                                </c:when>
                                                <c:otherwise>
                                                    ${livre.synopsis}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Statistiques pour les admins -->
                <c:if test="${sessionScope.userType == 'admin'}">
                    <div class="card info-card mt-4">
                        <div class="card-body">
                            <h6 class="text-primary mb-3">
                                <i class="fas fa-chart-bar"></i> Statistiques d'Usage
                            </h6>
                            <div class="row text-center">
                                <div class="col-md-3">
                                    <div class="border-end">
                                        <h4 class="text-info mb-1">0</h4>
                                        <small class="text-muted">Prêts en cours</small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="border-end">
                                        <h4 class="text-success mb-1">0</h4>
                                        <small class="text-muted">Réservations</small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="border-end">
                                        <h4 class="text-warning mb-1">0</h4>
                                        <small class="text-muted">Total prêts</small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <h4 class="text-primary mb-1">★ 4.5</h4>
                                    <small class="text-muted">Note moyenne</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
