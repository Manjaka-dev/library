<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Réserver un Livre</title>
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
                <a class="nav-link" href="/adherants/dashboard">Tableau de bord</a>
                <a class="nav-link" href="/livres">Catalogue</a>
                <a class="nav-link" href="/reservations">Mes Réservations</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-calendar-plus"></i> Réserver un Livre
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Messages -->
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

                        <!-- Formulaire simplifié -->
                        <form action="/reservations/adherant/save" method="post" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="livre" class="form-label">
                                    <i class="fas fa-book text-success"></i> Livre à réserver *
                                </label>
                                <select class="form-select" id="livre" name="livreId" required>
                                    <option value="">-- Choisissez un livre --</option>
                                    <c:forEach var="livre" items="${livres}">
                                        <option value="${livre.idLivre}" 
                                                <c:if test="${param.livreId == livre.idLivre}">selected</c:if>>
                                            ${livre.titre} - ${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Veuillez sélectionner un livre.</div>
                                <div class="form-text">Choisissez le livre que vous souhaitez réserver.</div>
                            </div>

                            <div class="mb-3">
                                <label for="dateReservation" class="form-label">
                                    <i class="fas fa-calendar text-info"></i> Date de réservation souhaitée *
                                </label>
                                <input type="date" class="form-control" id="dateReservation" 
                                       name="dateReservation" required>
                                <div class="invalid-feedback">Veuillez sélectionner une date.</div>
                                <div class="form-text">Indiquez quand vous souhaitez venir récupérer le livre.</div>
                            </div>

                            <div class="alert alert-info">
                                <h6><i class="fas fa-info-circle"></i> Information importante</h6>
                                <p class="mb-0">Votre réservation sera en attente jusqu'à ce qu'un bibliothécaire la valide. 
                                Vous recevrez une confirmation une fois votre demande traitée.</p>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-calendar-plus"></i> Réserver ce livre
                                </button>
                                <a href="/livres" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left"></i> Retour au catalogue
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Informations sur les réservations -->
                <div class="card shadow-sm mt-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-question-circle"></i> Comment ça marche ?</h5>
                    </div>
                    <div class="card-body">
                        <ol class="list-unstyled">
                            <li><i class="fas fa-1 text-primary"></i> Vous choisissez un livre et une date</li>
                            <li><i class="fas fa-2 text-warning"></i> Le bibliothécaire valide votre demande</li>
                            <li><i class="fas fa-3 text-success"></i> Vous venez récupérer votre livre</li>
                        </ol>
                        
                        <hr>
                        
                        <h6 class="text-muted">Vos limites de réservation</h6>
                        <p class="mb-0">
                            <i class="fas fa-calendar-check text-success"></i> 
                            Vous pouvez réserver jusqu'à <strong>${sessionScope.user.profil.quotaReservation}</strong> livre(s) à la fois.
                        </p>
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

        // Définir la date minimale à aujourd'hui
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const dateInput = document.getElementById('dateReservation');
            dateInput.min = today.toISOString().split('T')[0];
            
            // Définir une date par défaut (demain)
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            dateInput.value = tomorrow.toISOString().split('T')[0];
        });
    </script>
</body>
</html>
