<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire de Réservation</title>
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
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-info text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-calendar-plus"></i>
                            <c:choose>
                                <c:when test="${reservation.idReservation != null}">
                                    Modifier la Réservation #${reservation.idReservation}
                                </c:when>
                                <c:otherwise>
                                    Nouvelle Réservation
                                </c:otherwise>
                            </c:choose>
                        </h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i> ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="/reservations/save" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="idReservation" value="${reservation.idReservation}" />
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="livre" class="form-label">
                                            <i class="fas fa-book text-success"></i> Livre *
                                        </label>
                                        <select class="form-select" id="livre" name="livre.idLivre" required>
                                            <option value="">-- Sélectionner un livre --</option>
                                            <c:forEach var="livre" items="${livres}">
                                                <option value="${livre.idLivre}" 
                                                        <c:if test="${reservation.livre.idLivre == livre.idLivre}">selected</c:if>>
                                                    ${livre.titre} (${livre.auteur.nomAuteur})
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un livre.</div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="adherant" class="form-label">
                                            <i class="fas fa-user text-primary"></i> Adhérent *
                                        </label>
                                        <select class="form-select" id="adherant" name="adherant.idAdherant" required>
                                            <option value="">-- Sélectionner un adhérent --</option>
                                            <c:forEach var="adherant" items="${adherants}">
                                                <option value="${adherant.idAdherant}" 
                                                        <c:if test="${reservation.adherant.idAdherant == adherant.idAdherant}">selected</c:if>>
                                                    ${adherant.nomAdherant} ${adherant.prenomAdherant}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un adhérent.</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="statutReservation" class="form-label">
                                            <i class="fas fa-flag text-warning"></i> Statut *
                                        </label>
                                        <select class="form-select" id="statutReservation" name="statutReservation.idStatutReservation" required>
                                            <option value="">-- Sélectionner un statut --</option>
                                            <c:forEach var="statut" items="${statuts}">
                                                <option value="${statut.idStatutReservation}" 
                                                        <c:if test="${reservation.statutReservation.idStatutReservation == statut.idStatutReservation}">selected</c:if>>
                                                    ${statut.nomStatut}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un statut.</div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="dateDeReservation" class="form-label">
                                            <i class="fas fa-calendar text-info"></i> Date de Réservation
                                        </label>
                                        <input type="datetime-local" class="form-control" id="dateDeReservation" 
                                               name="dateDeReservation" value="${reservation.dateDeReservation}">
                                        <div class="form-text">Si non spécifiée, la date actuelle sera utilisée.</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="d-flex justify-content-between">
                                        <a href="/reservations" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i> Annuler
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i>
                                            <c:choose>
                                                <c:when test="${reservation.idReservation != null}">
                                                    Modifier
                                                </c:when>
                                                <c:otherwise>
                                                    Créer la Réservation
                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validation Bootstrap
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
</body>
</html>