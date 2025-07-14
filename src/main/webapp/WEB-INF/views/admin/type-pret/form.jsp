<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire Type de Prêt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque - Administration
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/">Accueil</a>
                <a class="nav-link" href="/admin">Admin</a>
                <a class="nav-link" href="/admin/types-pret">Types de Prêt</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-tag"></i> 
                            <c:choose>
                                <c:when test="${typePret.idTypePret != null}">
                                    Modifier le Type de Prêt
                                </c:when>
                                <c:otherwise>
                                    Nouveau Type de Prêt
                                </c:otherwise>
                            </c:choose>
                        </h4>
                    </div>
                    <div class="card-body">
                        <form action="/admin/types-pret/save" method="post" class="needs-validation" novalidate>
                            <c:if test="${typePret.idTypePret != null}">
                                <input type="hidden" name="idTypePret" value="${typePret.idTypePret}">
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="type" class="form-label">
                                    <i class="fas fa-tag text-primary"></i> Nom du Type *
                                </label>
                                <input type="text" 
                                       class="form-control" 
                                       id="type" 
                                       name="type" 
                                       value="${typePret.type}" 
                                       placeholder="Ex: Prêt Standard, Prêt Étudiant, Prêt Enseignant..."
                                       required
                                       maxlength="50">
                                <div class="invalid-feedback">
                                    Veuillez entrer un nom pour le type de prêt.
                                </div>
                                <small class="form-text text-muted">
                                    Maximum 50 caractères
                                </small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="dureeJours" class="form-label">
                                    <i class="fas fa-calendar-alt text-success"></i> Durée en Jours *
                                </label>
                                <input type="number" 
                                       class="form-control" 
                                       id="dureeJours" 
                                       name="dureeJours" 
                                       value="${typePret.dureeJours}" 
                                       placeholder="Ex: 7, 14, 30..."
                                       required
                                       min="1"
                                       max="365">
                                <div class="invalid-feedback">
                                    Veuillez entrer une durée entre 1 et 365 jours.
                                </div>
                                <small class="form-text text-muted">
                                    Durée du prêt en jours (entre 1 et 365)
                                </small>
                            </div>
                            
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i>
                                <strong>Information :</strong> 
                                Cette durée sera automatiquement utilisée pour calculer la date de fin 
                                lors de la création d'un prêt avec ce type.
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="/admin/types-pret" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Annuler
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> 
                                    <c:choose>
                                        <c:when test="${typePret.idTypePret != null}">
                                            Modifier
                                        </c:when>
                                        <c:otherwise>
                                            Créer
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Exemples de types de prêt -->
                <div class="card shadow-sm mt-4">
                    <div class="card-header bg-info text-white">
                        <h6 class="mb-0"><i class="fas fa-lightbulb"></i> Exemples de Types de Prêt</h6>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="text-primary">Types Courants :</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-book text-success"></i> <strong>Prêt Standard</strong> - 14 jours</li>
                                    <li><i class="fas fa-graduation-cap text-info"></i> <strong>Prêt Étudiant</strong> - 21 jours</li>
                                    <li><i class="fas fa-chalkboard-teacher text-warning"></i> <strong>Prêt Enseignant</strong> - 30 jours</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6 class="text-primary">Types Spéciaux :</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-clock text-danger"></i> <strong>Prêt Express</strong> - 7 jours</li>
                                    <li><i class="fas fa-calendar-plus text-success"></i> <strong>Prêt Longue Durée</strong> - 60 jours</li>
                                    <li><i class="fas fa-search text-secondary"></i> <strong>Prêt Recherche</strong> - 45 jours</li>
                                </ul>
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
