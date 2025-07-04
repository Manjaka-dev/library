<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulaire de Retour</title>
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
                <a class="nav-link" href="/retours">Retours</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-danger text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-undo"></i>
                            <c:choose>
                                <c:when test="${retour.idRetour != null}">
                                    Modifier le Retour #${retour.idRetour}
                                </c:when>
                                <c:otherwise>
                                    Nouveau Retour
                                </c:otherwise>
                            </c:choose>
                        </h4>
                    </div>
                    <div class="card-body">
                        <form action="/retours/save" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="idRetour" value="${retour.idRetour}" />
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="pret" class="form-label">
                                            <i class="fas fa-handshake text-primary"></i> Prêt à retourner *
                                        </label>
                                        <select class="form-select" id="pret" name="pret.idPret" required>
                                            <option value="">-- Sélectionner un prêt --</option>
                                            <c:forEach var="pret" items="${prets}">
                                                <option value="${pret.idPret}" 
                                                        <c:if test="${retour.pret.idPret == pret.idPret}">selected</c:if>>
                                                    Prêt #${pret.idPret} - ${pret.exemplaire.livre.titre} 
                                                    (${pret.adherant.nomAdherant} ${pret.adherant.prenomAdherant})
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un prêt.</div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="typeRetour" class="form-label">
                                            <i class="fas fa-tag text-warning"></i> Type de Retour *
                                        </label>
                                        <select class="form-select" id="typeRetour" name="typeRetour.idTypeRetour" required>
                                            <option value="">-- Sélectionner un type --</option>
                                            <c:forEach var="type" items="${typesRetour}">
                                                <option value="${type.idTypeRetour}" 
                                                        <c:if test="${retour.typeRetour.idTypeRetour == type.idTypeRetour}">selected</c:if>>
                                                    ${type.nom}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Veuillez sélectionner un type de retour.</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="dateRetour" class="form-label">
                                            <i class="fas fa-calendar text-info"></i> Date de Retour
                                        </label>
                                        <input type="datetime-local" class="form-control" id="dateRetour" 
                                               name="dateRetour" value="${retour.dateRetour}">
                                        <div class="form-text">Si non spécifiée, la date actuelle sera utilisée.</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="d-flex justify-content-between">
                                        <a href="/retours" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i> Annuler
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i>
                                            <c:choose>
                                                <c:when test="${retour.idRetour != null}">
                                                    Modifier
                                                </c:when>
                                                <c:otherwise>
                                                    Enregistrer le Retour
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
