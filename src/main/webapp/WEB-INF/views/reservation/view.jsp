<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails de la Réservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/">Accueil</a>
                <a class="nav-link" href="/reservations">Réservations</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-calendar-check text-info"></i> Détails de la Réservation #${reservation.idReservation}</h2>
                    <div>
                        <a href="/reservations/edit/${reservation.idReservation}" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Modifier
                        </a>
                        <a href="/reservations" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Retour
                        </a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card shadow-sm">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-info-circle"></i> Informations de la Réservation</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">ID Réservation</h6>
                                        <p class="fw-bold">#${reservation.idReservation}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Date de Réservation</h6>
                                        <p class="fw-bold">
                                            <i class="fas fa-calendar"></i> ${reservation.dateDeReservation}
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Statut</h6>
                                        <p>
                                            <c:choose>
                                                <c:when test="${reservation.statut.nomStatut == 'En attente'}">
                                                    <span class="badge bg-warning fs-6">${reservation.statut.nomStatut}</span>
                                                </c:when>
                                                <c:when test="${reservation.statut.nomStatut == 'Confirmée'}">
                                                    <span class="badge bg-success fs-6">${reservation.statut.nomStatut}</span>
                                                </c:when>
                                                <c:when test="${reservation.statut.nomStatut == 'Annulée'}">
                                                    <span class="badge bg-danger fs-6">${reservation.statut.nomStatut}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary fs-6">${reservation.statut.nomStatut}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Informations du Livre -->
                        <div class="card shadow-sm mt-4">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-book"></i> Livre Réservé</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Titre</h6>
                                        <p class="fw-bold">${reservation.livre.titre}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted">ISBN</h6>
                                        <p>${reservation.livre.isbn}</p>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Auteur</h6>
                                        <p>${reservation.livre.auteur.nomAuteur} ${reservation.livre.auteur.prenomAuteur}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Éditeur</h6>
                                        <p>${reservation.livre.editeur.nomEditeur}</p>
                                    </div>
                                </div>
                                
                                <c:if test="${not empty reservation.livre.synopsis}">
                                    <div class="row">
                                        <div class="col-12">
                                            <h6 class="text-muted">Synopsis</h6>
                                            <p class="text-justify">${reservation.livre.synopsis}</p>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <!-- Informations de l'Adhérent -->
                        <div class="card shadow-sm">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-user"></i> Adhérent</h5>
                            </div>
                            <div class="card-body">
                                <h6 class="text-muted">Nom complet</h6>
                                <p class="fw-bold">${reservation.adherant.nomAdherant} ${reservation.adherant.prenomAdherant}</p>
                                
                                <h6 class="text-muted">ID Adhérent</h6>
                                <p>#${reservation.adherant.idAdherant}</p>
                                
                                <c:if test="${not empty reservation.adherant.profil}">
                                    <h6 class="text-muted">Profil</h6>
                                    <p><span class="badge bg-info">${reservation.adherant.profil.nomProfil}</span></p>
                                </c:if>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="card shadow-sm mt-4">
                            <div class="card-header bg-dark text-white">
                                <h5 class="mb-0"><i class="fas fa-cogs"></i> Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <!-- Bouton Valider pour les admins si le statut est "En attente" -->
                                    <c:if test="${sessionScope.userType == 'admin' && reservation.statut.nomStatut == 'En attente'}">
                                        <a href="/reservations/valider/${reservation.idReservation}" 
                                           class="btn btn-success"
                                           onclick="return confirm('Êtes-vous sûr de vouloir valider cette réservation et créer un prêt ?')">
                                            <i class="fas fa-check"></i> Valider et créer le prêt
                                        </a>
                                        <hr>
                                    </c:if>
                                    
                                    <a href="/reservations/edit/${reservation.idReservation}" class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Modifier
                                    </a>
                                    <a href="/reservations/delete/${reservation.idReservation}" 
                                       class="btn btn-danger"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette réservation ?')">
                                        <i class="fas fa-trash"></i> Supprimer
                                    </a>
                                    <a href="/livres/view/${reservation.livre.idLivre}" class="btn btn-info">
                                        <i class="fas fa-book"></i> Voir le Livre
                                    </a>
                                    <a href="/adherants/view/${reservation.adherant.idAdherant}" class="btn btn-primary">
                                        <i class="fas fa-user"></i> Voir l'Adhérent
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
