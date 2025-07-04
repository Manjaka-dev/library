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
            height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            border-radius: 10px;
        }
        .book-details {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
        .reservation-card {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border-radius: 15px;
        }
        .admin-actions {
            background: linear-gradient(135deg, #dc3545 0%, #fd7e14 100%);
            color: white;
            border-radius: 15px;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation adaptée au type d'utilisateur -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque
            </a>
            <div class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${userType == 'adherant'}">
                        <a class="nav-link" href="/adherant/dashboard">Dashboard</a>
                    </c:when>
                    <c:otherwise>
                        <a class="nav-link" href="/">Accueil</a>
                    </c:otherwise>
                </c:choose>
                <a class="nav-link" href="/livres">Catalogue</a>
                <a class="nav-link" href="/logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>
                        <i class="fas fa-book text-primary"></i> Détails du Livre
                    </h2>
                    <div>
                        <!-- Actions pour les administrateurs uniquement -->
                        <c:if test="${userType == 'admin'}">
                            <a href="/livres/edit/${livre.idLivre}" class="btn btn-warning">
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
            <!-- Couverture du livre -->
            <div class="col-md-4">
                <div class="book-cover">
                    <i class="fas fa-book-open"></i>
                </div>
                
                <!-- Actions pour les adhérents -->
                <c:if test="${userType == 'adherant'}">
                    <div class="card reservation-card mt-4">
                        <div class="card-body text-center">
                            <h5 class="card-title">
                                <i class="fas fa-calendar-check"></i> Réservation
                            </h5>
                            <c:choose>
                                <c:when test="${peutPreter}">
                                    <p class="card-text">Vous pouvez réserver ce livre</p>
                                    <a href="/reservations/new?livreId=${livre.idLivre}" class="btn btn-light btn-lg">
                                        <i class="fas fa-plus"></i> Réserver ce Livre
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <p class="card-text">
                                        <i class="fas fa-exclamation-triangle"></i> 
                                        Vous ne pouvez pas emprunter ce livre
                                    </p>
                                    <small>Restriction d'âge ou de profil</small>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>
                
                <!-- Actions administrateur -->
                <c:if test="${userType == 'admin'}">
                    <div class="card admin-actions mt-4">
                        <div class="card-body">
                            <h5 class="card-title">
                                <i class="fas fa-cogs"></i> Actions Administrateur
                            </h5>
                            <div class="d-grid gap-2">
                                <a href="/livres/edit/${livre.idLivre}" class="btn btn-light">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="/prets/new?livreId=${livre.idLivre}" class="btn btn-light">
                                    <i class="fas fa-handshake"></i> Créer un Prêt
                                </a>
                                <a href="/livres/delete/${livre.idLivre}" class="btn btn-outline-light"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce livre ?')">
                                    <i class="fas fa-trash"></i> Supprimer
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Détails du livre -->
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h3 class="card-title text-primary">${livre.titre}</h3>
                        <p class="text-muted mb-4">${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}</p>
                        
                        <div class="book-details">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6 class="text-muted">Informations Générales</h6>
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="40%">ID:</th>
                                            <td>${livre.idLivre}</td>
                                        </tr>
                                        <tr>
                                            <th>ISBN:</th>
                                            <td>${livre.isbn}</td>
                                        </tr>
                                        <tr>
                                            <th>Langue:</th>
                                            <td>${livre.langue}</td>
                                        </tr>
                                        <tr>
                                            <th>Éditeur:</th>
                                            <td>${livre.editeur.nomEditeur}</td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <div class="col-md-6">
                                    <h6 class="text-muted">Détails Techniques</h6>
                                    <table class="table table-borderless">
                                        <tr>
                                            <th width="50%">Année de Publication:</th>
                                            <td>${livre.anneePublication}</td>
                                        </tr>
                                        <tr>
                                            <th>Nombre de Pages:</th>
                                            <td>${livre.nbPage}</td>
                                        </tr>
                                        <c:if test="${not empty livre.ageRequis}">
                                        <tr>
                                            <th>Âge Requis:</th>
                                            <td>
                                                <span class="badge bg-warning">${livre.ageRequis}+ ans</span>
                                            </td>
                                        </tr>
                                        </c:if>
                                    </table>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Catégories -->
                        <c:if test="${not empty livre.categories}">
                            <div class="mt-4">
                                <h6 class="text-muted">Catégories</h6>
                                <div>
                                    <c:forEach var="categorie" items="${livre.categories}">
                                        <span class="badge bg-secondary me-2">${categorie.nomCategorie}</span>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- Synopsis -->
                        <c:if test="${not empty livre.synopsis}">
                            <div class="mt-4">
                                <h6 class="text-muted">Synopsis</h6>
                                <p class="text-justify">${livre.synopsis}</p>
                            </div>
                        </c:if>
                        
                        <!-- Message pour les adhérents connectés -->
                        <c:if test="${userType == 'adherant'}">
                            <div class="alert alert-info mt-4">
                                <h6><i class="fas fa-info-circle"></i> Information</h6>
                                <p class="mb-0">
                                    Connecté en tant que : <strong>${adherant.nomAdherant} ${adherant.prenomAdherant}</strong><br>
                                    Profil : <span class="badge bg-primary">${adherant.profil.nomProfil}</span>
                                </p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">Langue:</th>
                                        <td>${livre.langue}</td>
                                    </tr>
                                    <tr>
                                        <th>Année de Publication:</th>
                                        <td>${livre.anneePublication}</td>
                                    </tr>
                                    <tr>
                                        <th>Nombre de Pages:</th>
                                        <td>${livre.nbPage}</td>
                                    </tr>
                                    <tr>
                                        <th>Catégories:</th>
                                        <td>
                                            <c:if test="${not empty livre.categories}">
                                                <c:forEach var="categorie" items="${livre.categories}" varStatus="status">
                                                    <span class="badge bg-primary">Catégorie ${categorie.nomCategorie}</span>
                                                    <c:if test="${!status.last}"> </c:if>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty livre.categories}">
                                                <span class="text-muted">Aucune catégorie</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <c:if test="${not empty livre.synopsis}">
                            <div class="row mt-3">
                                <div class="col-12">
                                    <h5>Synopsis:</h5>
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <p class="card-text">${livre.synopsis}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="d-flex justify-content-between">
                                    <a href="/livres" class="btn btn-outline-secondary">
                                        <i class="fas fa-list"></i> Liste des livres
                                    </a>
                                    <div>
                                        <a href="/livres/edit/${livre.idLivre}" class="btn btn-warning">
                                            <i class="fas fa-edit"></i> Modifier
                                        </a>
                                        <a href="/livres/delete/${livre.idLivre}" 
                                           class="btn btn-danger"
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce livre ?')">
                                            <i class="fas fa-trash"></i> Supprimer
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
