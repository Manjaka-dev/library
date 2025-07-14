<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouveau Prêt</title>
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
                <a class="nav-link" href="/prets">Prêts</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-handshake"></i> Nouveau Prêt
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Messages de succès -->
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i>
                                ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Messages d'erreur -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle"></i>
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="/prets/preter" method="post" class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="adherantId" class="form-label">
                                            <i class="fas fa-user text-primary"></i> Adhérent *
                                        </label>
                                        <select class="form-select" id="adherantId" name="adherantId" required>
                                            <option value="">-- Choisir un adhérent --</option>
                                            <c:forEach var="adherant" items="${adherants}">
                                                <option value="${adherant.idAdherant}">${adherant.nomAdherant} ${adherant.prenomAdherant}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">
                                            Veuillez sélectionner un adhérent.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="livreId" class="form-label">
                                            <i class="fas fa-book text-primary"></i> Livre *
                                        </label>
                                        <select class="form-select" id="livreId" name="livreId" required>
                                            <option value="">-- Choisir un livre --</option>
                                            <c:forEach var="livre" items="${livres}">
                                                <option value="${livre.idLivre}">${livre.titre} - ${livre.auteur.nomAuteur}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">
                                            Veuillez sélectionner un livre.
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="typePretId" class="form-label">
                                            <i class="fas fa-clock text-primary"></i> Type de Prêt *
                                        </label>
                                        <select class="form-select" id="typePretId" name="typePretId" required onchange="updateDuration()">
                                            <option value="">-- Choisir un type de prêt --</option>
                                            <c:forEach var="type" items="${typesPret}">
                                                <option value="${type.idTypePret}" data-duree="${type.dureeJours}">
                                                    ${type.type} (${type.dureeJours} jours)
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">
                                            Veuillez sélectionner un type de prêt.
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="dateDebut" class="form-label">
                                            <i class="fas fa-calendar-alt text-primary"></i> Date de début *
                                        </label>
                                        <input type="date" class="form-control" id="dateDebut" name="dateDebut" 
                                               value="${param.dateDebut}" required onchange="calculateEndDate()">
                                        <div class="invalid-feedback">
                                            Veuillez sélectionner une date de début.
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Affichage de la durée et date de fin calculée -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-hourglass-half text-info"></i> Durée du prêt
                                        </label>
                                        <div class="form-control-plaintext bg-light p-2 rounded" id="dureeDisplay">
                                            <span class="text-muted">Sélectionnez un type de prêt</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <i class="fas fa-calendar-check text-success"></i> Date de fin prévue
                                        </label>
                                        <div class="form-control-plaintext bg-light p-2 rounded" id="dateFinDisplay">
                                            <span class="text-muted">Sélectionnez une date de début</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary btn-lg me-2">
                                    <i class="fas fa-handshake"></i> Créer le Prêt
                                </button>
                                <a href="/prets" class="btn btn-secondary btn-lg">
                                    <i class="fas fa-times"></i> Annuler
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateDuration() {
            const typePretSelect = document.getElementById('typePretId');
            const dureeDisplay = document.getElementById('dureeDisplay');
            const selectedOption = typePretSelect.options[typePretSelect.selectedIndex];
            
            if (selectedOption.value && selectedOption.dataset.duree) {
                const duree = selectedOption.dataset.duree;
                dureeDisplay.innerHTML = `<strong class="text-primary">${duree} jours</strong>`;
            } else {
                dureeDisplay.innerHTML = '<span class="text-muted">Sélectionnez un type de prêt</span>';
            }
            
            calculateEndDate();
        }

        function calculateEndDate() {
            const dateDebutInput = document.getElementById('dateDebut');
            const typePretSelect = document.getElementById('typePretId');
            const dateFinDisplay = document.getElementById('dateFinDisplay');
            const selectedOption = typePretSelect.options[typePretSelect.selectedIndex];
            
            if (dateDebutInput.value && selectedOption.value && selectedOption.dataset.duree) {
                const dateDebut = new Date(dateDebutInput.value);
                const duree = parseInt(selectedOption.dataset.duree);
                const dateFin = new Date(dateDebut);
                dateFin.setDate(dateFin.getDate() + duree);
                
                const options = { 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric',
                    weekday: 'long'
                };
                const dateFinStr = dateFin.toLocaleDateString('fr-FR', options);
                dateFinDisplay.innerHTML = `<strong class="text-success">${dateFinStr}</strong>`;
            } else {
                dateFinDisplay.innerHTML = '<span class="text-muted">Sélectionnez une date de début et un type de prêt</span>';
            }
        }

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

        // Mettre la date d'aujourd'hui par défaut
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.getElementById('dateDebut');
            if (!dateInput.value) {
                const today = new Date().toISOString().split('T')[0];
                dateInput.value = today;
            }
        });
    </script>
</body>
</html>
