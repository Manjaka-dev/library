<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Créer un Prêt depuis une Réservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .reservation-header {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            border-radius: 15px;
        }
        .form-floating > .form-control:focus ~ label {
            color: #11998e;
        }
        .btn-create-loan {
            background: linear-gradient(45deg, #11998e, #38ef7d);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            transition: all 0.3s ease;
        }
        .btn-create-loan:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.3);
        }
        .reservation-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
        }
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque - Administration
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/reservations">
                    <i class="fas fa-calendar-check"></i> Réservations
                </a>
                <a class="nav-link" href="/prets">
                    <i class="fas fa-handshake"></i> Prêts
                </a>
                <a class="nav-link" href="/">
                    <i class="fas fa-home"></i> Accueil
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <!-- En-tête -->
                <div class="text-center mb-4">
                    <h1 class="display-6 text-success">
                        <i class="fas fa-magic"></i> Transformation Réservation → Prêt
                    </h1>
                    <p class="lead text-muted">Création d'un prêt à partir de la réservation validée</p>
                </div>

                <!-- Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        <i class="fas fa-info-circle"></i> ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="row">
                    <!-- Informations de la réservation -->
                    <div class="col-lg-4">
                        <div class="card reservation-card border-0 shadow-sm">
                            <div class="card-body text-white">
                                <h5 class="card-title mb-3">
                                    <i class="fas fa-calendar-check"></i> Réservation #${reservationId}
                                </h5>
                                
                                <div class="mb-3">
                                    <h6><i class="fas fa-user"></i> Adhérent :</h6>
                                    <p class="mb-1"><strong>Prérempli automatiquement</strong></p>
                                    <small>Basé sur la réservation</small>
                                </div>

                                <div class="mb-3">
                                    <h6><i class="fas fa-book"></i> Livre :</h6>
                                    <p class="mb-1"><strong>Prérempli automatiquement</strong></p>
                                    <small>Livre réservé</small>
                                </div>

                                <div class="alert alert-light text-dark mt-3">
                                    <small>
                                        <i class="fas fa-lightbulb"></i> 
                                        <strong>Info :</strong> Les informations de l'adhérent et du livre 
                                        sont automatiquement récupérées depuis la réservation.
                                    </small>
                                </div>
                            </div>
                        </div>

                        <!-- Workflow -->
                        <div class="card mt-3 border-0 shadow-sm">
                            <div class="card-body">
                                <h6 class="card-title text-center">
                                    <i class="fas fa-tasks"></i> Processus
                                </h6>
                                <div class="timeline">
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="badge bg-success rounded-pill me-2">1</span>
                                        <small>Réservation validée ✓</small>
                                    </div>
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="badge bg-warning rounded-pill me-2">2</span>
                                        <small>Création du prêt</small>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-secondary rounded-pill me-2">3</span>
                                        <small>Statut → "Confirmée"</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Formulaire de création de prêt -->
                    <div class="col-lg-8">
                        <div class="card shadow-lg border-0">
                            <div class="card-header reservation-header">
                                <h4 class="mb-0 text-center">
                                    <i class="fas fa-handshake"></i> Nouveau Prêt
                                </h4>
                            </div>
                            <div class="card-body p-4">
                                <form action="/prets/save-from-reservation" method="post" class="needs-validation" novalidate>
                                    <input type="hidden" name="reservationId" value="${reservationId}">

                                    <div class="row">
                                        <!-- Type de prêt -->
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <select class="form-select" id="typePret" name="typePret" required style="height: 58px;">
                                                    <option value="">-- Sélectionner un type --</option>
                                                    <c:forEach var="type" items="${typesPret}">
                                                        <option value="${type.idTypePret}">${type.type}</option>
                                                    </c:forEach>
                                                </select>
                                                <label for="typePret">
                                                    <i class="fas fa-tag text-warning"></i> Type de Prêt *
                                                </label>
                                                <div class="invalid-feedback">Veuillez sélectionner un type de prêt.</div>
                                            </div>
                                        </div>

                                        <!-- Date de début -->
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="date" class="form-control" id="dateDebut" 
                                                       name="dateDebut" required>
                                                <label for="dateDebut">
                                                    <i class="fas fa-calendar-plus text-success"></i> Date de début *
                                                </label>
                                                <div class="form-text">
                                                    Date de début du prêt
                                                </div>
                                                <div class="invalid-feedback">Veuillez indiquer la date de début.</div>
                                            </div>
                                        </div>
                                        
                                        <!-- Date de fin -->
                                        <div class="col-md-6 mb-3">
                                            <div class="form-floating">
                                                <input type="date" class="form-control" id="dateFin" 
                                                       name="dateFin" readonly>
                                                <label for="dateFin">
                                                    <i class="fas fa-calendar-minus text-danger"></i> Date de fin (calculée automatiquement)
                                                </label>
                                                <div class="form-text">
                                                    Date calculée automatiquement selon le type de prêt
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Informations automatiques -->
                                    <div class="alert alert-info border-0 mb-4">
                                        <h6 class="alert-heading">
                                            <i class="fas fa-magic"></i> Informations automatiques
                                        </h6>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <ul class="mb-0 small">
                                                    <li><strong>Adhérent :</strong> Récupéré de la réservation</li>
                                                    <li><strong>Livre :</strong> Récupéré de la réservation</li>
                                                    <li><strong>Date de début :</strong> Maintenant</li>
                                                </ul>
                                            </div>
                                            <div class="col-md-6">
                                                <ul class="mb-0 small">
                                                    <li><strong>Exemplaire :</strong> Choisi automatiquement</li>
                                                    <li><strong>Admin :</strong> Utilisateur connecté</li>
                                                    <li><strong>Statut réservation :</strong> → Confirmée</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Vérifications -->
                                    <div class="alert alert-warning border-0 mb-4">
                                        <h6 class="alert-heading">
                                            <i class="fas fa-shield-alt"></i> Vérifications automatiques
                                        </h6>
                                        <div class="row small">
                                            <div class="col-md-6">
                                                <ul class="mb-0">
                                                    <li>Inscription adhérent active</li>
                                                    <li>Adhérent non pénalisé</li>
                                                    <li>Quota de prêt respecté</li>
                                                </ul>
                                            </div>
                                            <div class="col-md-6">
                                                <ul class="mb-0">
                                                    <li>Restrictions d'âge/profil</li>
                                                    <li>Disponibilité exemplaire</li>
                                                    <li>Période de prêt valide</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Boutons d'action -->
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-between">
                                        <a href="/reservations/view/${reservationId}" class="btn btn-outline-secondary btn-lg">
                                            <i class="fas fa-arrow-left"></i> Retour à la réservation
                                        </a>
                                        <button type="submit" class="btn btn-create-loan btn-lg text-white">
                                            <i class="fas fa-magic"></i> Créer le prêt et confirmer la réservation
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Définir la date de début minimale à aujourd'hui
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const todayString = today.toISOString().split('T')[0];
            
            document.getElementById('dateDebut').min = todayString;
            document.getElementById('dateDebut').value = todayString;
            
            // Calculer automatiquement la date de fin quand le type ou la date de début change
            function calculateEndDate() {
                const dateDebut = document.getElementById('dateDebut').value;
                const typePretSelect = document.getElementById('typePret');
                
                if (dateDebut && typePretSelect.value) {
                    fetch('/prets/api/type-pret/' + typePretSelect.value + '/duree')
                        .then(response => response.json())
                        .then(data => {
                            if (data.duree) {
                                const startDate = new Date(dateDebut);
                                const endDate = new Date(startDate);
                                endDate.setDate(startDate.getDate() + data.duree);
                                
                                const endDateString = endDate.toISOString().split('T')[0];
                                document.getElementById('dateFin').value = endDateString;
                            }
                        })
                        .catch(error => {
                            console.error('Erreur lors du calcul de la date de fin:', error);
                        });
                }
            }
            
            // Écouter les changements
            document.getElementById('dateDebut').addEventListener('change', calculateEndDate);
            document.getElementById('typePret').addEventListener('change', calculateEndDate);
            
            // Calculer initial si des valeurs sont déjà sélectionnées
            calculateEndDate();
        });

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
