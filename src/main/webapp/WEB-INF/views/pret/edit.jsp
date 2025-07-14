<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier le Prêt #${pret.idPret}</title>
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
                    <div class="card-header bg-warning text-dark">
                        <h4 class="mb-0">
                            <i class="fas fa-edit"></i> Modifier le Prêt #${pret.idPret}
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Messages -->
                        <c:if test="${not empty message}">
                            <div class="alert ${message.contains('succès') || message.contains('modifié') ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                                <i class="fas ${message.contains('succès') || message.contains('modifié') ? 'fa-check-circle' : 'fa-exclamation-triangle'}"></i>
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Informations actuelles du prêt (lecture seule) -->
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-info-circle"></i> Informations actuelles</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>Adhérent :</strong> ${pret.adherant.nomAdherant} ${pret.adherant.prenomAdherant}</p>
                                        <p><strong>Livre :</strong> ${pret.exemplaire.livre.titre}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>Date de début :</strong> ${pret.dateDebutFormatteeLongue}</p>
                                        <p><strong>Type de prêt :</strong> ${pret.typePret.type}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Formulaire de modification -->
                        <form action="/prets/update" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="idPret" value="${pret.idPret}" />
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="adherantId" class="form-label">
                                            <i class="fas fa-user text-primary"></i> Adhérent *
                                        </label>
                                        <select class="form-select" id="adherantId" name="adherantId" required>
                                            <c:forEach var="adherant" items="${adherants}">
                                                <option value="${adherant.idAdherant}" 
                                                        <c:if test="${pret.adherant.idAdherant == adherant.idAdherant}">selected</c:if>>
                                                    ${adherant.nomAdherant} ${adherant.prenomAdherant}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un adhérent.</div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="typePret" class="form-label">
                                            <i class="fas fa-tag text-warning"></i> Type de Prêt *
                                        </label>
                                        <select class="form-select" id="typePret" name="typePret" required>
                                            <c:forEach var="type" items="${typesPret}">
                                                <option value="${type.idTypePret}" 
                                                        <c:if test="${pret.typePret.idTypePret == type.idTypePret}">selected</c:if>>
                                                    ${type.type}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un type de prêt.</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-12">
                                    <div class="mb-3">
                                        <label for="livre" class="form-label">
                                            <i class="fas fa-book text-success"></i> Livre *
                                        </label>
                                        <select class="form-select" id="livre" name="livre" required>
                                            <c:forEach var="livre" items="${livres}">
                                                <option value="${livre.idLivre}" 
                                                        <c:if test="${pret.exemplaire.livre.idLivre == livre.idLivre}">selected</c:if>>
                                                    ${livre.titre} - ${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}
                                                    <c:if test="${not empty livre.isbn}"> (ISBN: ${livre.isbn})</c:if>
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un livre.</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="dateDebut" class="form-label">
                                            <i class="fas fa-calendar text-info"></i> Date de début *
                                        </label>
                                        <input type="datetime-local" class="form-control" id="dateDebut" 
                                               name="dateDebut" value="${pret.dateDebut}" required>
                                        <div class="invalid-feedback">Veuillez spécifier la date de début.</div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="dateFin" class="form-label">
                                            <i class="fas fa-calendar-times text-danger"></i> Date de fin *
                                        </label>
                                        <input type="date" class="form-control" id="dateFin" 
                                               name="dateFin" required>
                                        <div class="form-text">La date de fin prévue pour le retour du livre.</div>
                                        <div class="invalid-feedback">Veuillez spécifier la date de fin.</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="d-flex justify-content-between">
                                        <a href="/prets/view/${pret.idPret}" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i> Annuler
                                        </a>
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-save"></i> Modifier le Prêt
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Informations d'aide -->
                <div class="card shadow-sm mt-4">
                    <div class="card-header bg-light">
                        <h5 class="mb-0"><i class="fas fa-info-circle"></i> Informations</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="text-muted">Règles de Modification</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success"></i> Vérifiez la disponibilité des nouveaux livres</li>
                                    <li><i class="fas fa-check text-success"></i> Respectez les quotas par type de prêt</li>
                                    <li><i class="fas fa-check text-success"></i> Assurez-vous que l'adhérent n'a pas de pénalités</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6 class="text-muted">Actions Rapides</h6>
                                <div class="d-grid gap-2">
                                    <a href="/prets" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-list"></i> Liste des Prêts
                                    </a>
                                    <a href="/prets/view/${pret.idPret}" class="btn btn-outline-info btn-sm">
                                        <i class="fas fa-eye"></i> Voir le Prêt
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

        // Définir la date minimale à aujourd'hui pour la date de fin
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            const dateFinInput = document.getElementById('dateFin');
            dateFinInput.min = tomorrow.toISOString().split('T')[0];
            
            // Définir une date par défaut (14 jours plus tard)
            const defaultDate = new Date(today);
            defaultDate.setDate(defaultDate.getDate() + 14);
            dateFinInput.value = defaultDate.toISOString().split('T')[0];
        });
    </script>
</body>
</html>
