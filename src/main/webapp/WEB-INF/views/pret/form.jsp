<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire de Prêt</title>
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
                        <!-- Messages -->
                        <c:if test="${not empty message}">
                            <div class="alert ${message.contains('succès') || message.contains('validé') ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                                <i class="fas ${message.contains('succès') || message.contains('validé') ? 'fa-check-circle' : 'fa-exclamation-triangle'}"></i>
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
                                            <option value="">-- Sélectionner un adhérent --</option>
                                            <c:forEach var="adherant" items="${adherants}">
                                                <option value="${adherant.idAdherant}">
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
                                            <option value="">-- Sélectionner un type --</option>
                                            <c:forEach var="type" items="${typesPret}">
                                                <option value="${type.idTypePret}" data-duree="${type.dureeJours}">
                                                    ${type.type} (${type.dureeJours} jours)
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un type de prêt.</div>
                                        <div id="dureeInfo" class="form-text text-primary d-none">
                                            <i class="fas fa-clock"></i> Durée du prêt : <span id="dureeDays"></span> jours
                                        </div>
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
                                            <option value="">-- Sélectionner un livre --</option>
                                            <c:forEach var="livre" items="${livres}">
                                                <option value="${livre.idLivre}">
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
                                            <i class="fas fa-calendar text-success"></i> Date de début de prêt *
                                        </label>
                                        <input type="date" class="form-control" id="dateDebut" name="dateDebut" required>
                                        <div class="invalid-feedback">Veuillez sélectionner une date de début.</div>
                                        <small class="form-text text-muted">
                                            La date de fin sera automatiquement calculée selon le type de prêt choisi.
                                        </small>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="d-flex justify-content-between">
                                        <a href="/prets" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i> Annuler
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Créer le Prêt
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                
                <div class="card shadow-sm mt-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-info-circle"></i> Informations</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="text-muted">Règles de Prêt</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success"></i> Vérifiez que l'adhérent n'a pas de pénalités</li>
                                    <li><i class="fas fa-check text-success"></i> Respectez les quotas par type de prêt</li>
                                    <li><i class="fas fa-check text-success"></i> Le livre doit être disponible</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6 class="text-muted">Actions Rapides</h6>
                                <div class="d-grid gap-2">
                                    <a href="/adherants" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-users"></i> Gérer les Adhérents
                                    </a>
                                    <a href="/livres" class="btn btn-outline-success btn-sm">
                                        <i class="fas fa-book"></i> Gérer les Livres
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
    </script>
</body>
</html>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="livre" class="form-label">Livre à prêter *</label>
                                <select class="form-select" id="livre" name="livre" required>
                                    <option value="">-- Sélectionner un livre --</option>
                                    <c:forEach var="livre" items="${livres}">
                                        <option value="${livre.idLivre}">
                                            ${livre.titre} - ${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="/" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Retour
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-handshake"></i> Créer le prêt
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
    <script>
        // Définir la date minimale à aujourd'hui et gérer le calcul automatique
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const dateDebutInput = document.getElementById('dateDebut');
            const typePretSelect = document.getElementById('typePret');
            const dureeInfo = document.getElementById('dureeInfo');
            const dureeDays = document.getElementById('dureeDays');
            
            // Définir la date minimale à aujourd'hui
            dateDebutInput.min = today.toISOString().split('T')[0];
            
            // Définir la date par défaut à aujourd'hui
            dateDebutInput.value = today.toISOString().split('T')[0];
            
            // Fonction pour calculer et afficher la date de fin
            function calculateEndDate() {
                const startDate = dateDebutInput.value;
                const selectedType = typePretSelect.options[typePretSelect.selectedIndex];
                
                if (startDate && selectedType.value) {
                    const duree = parseInt(selectedType.dataset.duree);
                    const startDateObj = new Date(startDate);
                    const endDateObj = new Date(startDateObj);
                    endDateObj.setDate(startDateObj.getDate() + duree);
                    
                    dureeDays.textContent = duree;
                    dureeInfo.classList.remove('d-none');
                    
                    // Ajouter un élément pour afficher la date de fin calculée
                    let dateFinPreview = document.getElementById('dateFinPreview');
                    if (!dateFinPreview) {
                        dateFinPreview = document.createElement('div');
                        dateFinPreview.id = 'dateFinPreview';
                        dateFinPreview.className = 'form-text text-success';
                        dureeInfo.parentNode.appendChild(dateFinPreview);
                    }
                    
                    const endDateStr = endDateObj.toLocaleDateString('fr-FR', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric'
                    });
                    
                    dateFinPreview.innerHTML = '<i class="fas fa-calendar-check"></i> Date de fin prévue : <strong>' + endDateStr + '</strong>';
                } else {
                    dureeInfo.classList.add('d-none');
                    const dateFinPreview = document.getElementById('dateFinPreview');
                    if (dateFinPreview) {
                        dateFinPreview.remove();
                    }
                }
            }
            
            // Écouter les changements
            typePretSelect.addEventListener('change', calculateEndDate);
            dateDebutInput.addEventListener('change', calculateEndDate);
        });
    </script>
</body>
</html>