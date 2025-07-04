<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Réservations</title>
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
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-calendar-check text-info"></i> Gestion des Réservations</h2>
                    <a href="/reservations/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouvelle Réservation
                    </a>
                </div>

                <div class="card shadow-sm">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty reservations}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Livre</th>
                                                <th>Adhérent</th>
                                                <th>Date de Réservation</th>
                                                <th>Statut</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="reservation" items="${reservations}">
                                                <tr>
                                                    <td>${reservation.idReservation}</td>
                                                    <td>
                                                        <strong>${reservation.livre.titre}</strong><br>
                                                        <small class="text-muted">ISBN: ${reservation.livre.isbn}</small>
                                                    </td>
                                                    <td>
                                                        ${reservation.adherant.nomAdherant} ${reservation.adherant.prenomAdherant}
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-secondary">
                                                            ${reservation.dateDeReservation}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${reservation.statutReservation.nomStatut == 'En attente'}">
                                                                <span class="badge bg-warning">${reservation.statutReservation.nomStatut}</span>
                                                            </c:when>
                                                            <c:when test="${reservation.statutReservation.nomStatut == 'Confirmée'}">
                                                                <span class="badge bg-success">${reservation.statutReservation.nomStatut}</span>
                                                            </c:when>
                                                            <c:when test="${reservation.statutReservation.nomStatut == 'Annulée'}">
                                                                <span class="badge bg-danger">${reservation.statutReservation.nomStatut}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">${reservation.statutReservation.nomStatut}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group btn-group-sm" role="group">
                                                            <a href="/reservations/view/${reservation.idReservation}" 
                                                               class="btn btn-outline-info" title="Voir">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="/reservations/edit/${reservation.idReservation}" 
                                                               class="btn btn-outline-warning" title="Modifier">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="/reservations/delete/${reservation.idReservation}" 
                                                               class="btn btn-outline-danger" title="Supprimer"
                                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette réservation ?')">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                    <h4 class="text-muted">Aucune réservation trouvée</h4>
                                    <p class="text-muted">Commencez par créer une nouvelle réservation.</p>
                                    <a href="/reservations/new" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Créer une Réservation
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
