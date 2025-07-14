<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Livres</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation adaptée au type d'utilisateur -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
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
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>
                        <i class="fas fa-book text-primary"></i> Catalogue des Livres
                    </h2>
                    <!-- Bouton d'ajout uniquement pour les administrateurs -->
                    <c:if test="${sessionScope.userType == 'admin'}">
                        <a href="/livres/new" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Nouveau Livre
                        </a>
                    </c:if>
                    
                    <!-- Message informatif pour les adhérents -->
                    <c:if test="${sessionScope.userType == 'adherant'}">
                        <div class="alert alert-info mb-3">
                            <i class="fas fa-info-circle"></i>
                            <strong>Mode Adhérant :</strong> Vous pouvez consulter le catalogue et réserver des livres, 
                            mais vous ne pouvez pas ajouter, modifier ou supprimer des livres.
                        </div>
                    </c:if>
                    
                    <!-- Message pour les utilisateurs non connectés -->
                    <c:if test="${empty sessionScope.userType}">
                        <div class="alert alert-warning mb-3">
                            <i class="fas fa-user-slash"></i>
                            <strong>Accès Invité :</strong> Vous consultez le catalogue en mode lecture seule. 
                            <a href="/login" class="alert-link">Connectez-vous</a> pour accéder à toutes les fonctionnalités.
                        </div>
                    </c:if>
                </div>
                
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Titre</th>
                                        <th>ISBN</th>
                                        <th>Auteur</th>
                                        <th>Éditeur</th>
                                        <th>Année</th>
                                        <th>Langue</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="livre" items="${livres}">
                                        <tr>
                                            <td>${livre.idLivre}</td>
                                            <td>${livre.titre}</td>
                                            <td>${livre.isbn}</td>
                                            <td>${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}</td>
                                            <td>${livre.editeur.nomEditeur}</td>
                                            <td>${livre.anneePublication}</td>
                                            <td>${livre.langue}</td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <!-- Bouton voir - accessible à tous -->
                                                    <a href="/livres/view/${livre.idLivre}" class="btn btn-info btn-sm">
                                                        <i class="fas fa-eye"></i> Détails
                                                    </a>
                                                    
                                                    <!-- Boutons admin uniquement -->
                                                    <c:if test="${sessionScope.userType == 'admin'}">
                                                        <a href="/livres/edit/${livre.idLivre}" class="btn btn-warning btn-sm">
                                                            <i class="fas fa-edit"></i> Modifier
                                                        </a>
                                                        <a href="/livres/delete/${livre.idLivre}" 
                                                           class="btn btn-danger btn-sm"
                                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce livre ?')">
                                                            <i class="fas fa-trash"></i> Supprimer
                                                        </a>
                                                    </c:if>
                                                    
                                                    <!-- Bouton réservation pour les adhérents -->
                                                    <c:if test="${sessionScope.userType == 'adherant'}">
                                                        <a href="/reservations/new?livreId=${livre.idLivre}" class="btn btn-success btn-sm">
                                                            <i class="fas fa-calendar-plus"></i> Réserver
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <c:if test="${empty livres}">
                            <div class="text-center py-4">
                                <p class="text-muted">Aucun livre trouvé.</p>
                                <c:if test="${sessionScope.userType == 'admin'}">
                                    <a href="/livres/new" class="btn btn-primary">Ajouter le premier livre</a>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
