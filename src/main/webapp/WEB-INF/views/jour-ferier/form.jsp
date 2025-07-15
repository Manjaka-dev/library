<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jour Férié - Bibliothèque</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-calendar-plus"></i> 
                            ${jourFerier.idJourFerier != null ? 'Modifier' : 'Nouveau'} Jour Férié
                        </h3>
                    </div>
                    <div class="card-body">
                        <!-- Messages d'erreur -->
                        <c:if test="${error != null}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>

                        <form action="/jours-ferier/save" method="post">
                            <c:if test="${jourFerier.idJourFerier != null}">
                                <input type="hidden" name="idJourFerier" value="${jourFerier.idJourFerier}" />
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="nomJour" class="form-label">Nom du Jour Férié *</label>
                                <input type="text" class="form-control" id="nomJour" name="nomJour" 
                                       value="${jourFerier.nomJour}" required
                                       placeholder="Ex: Nouvel An, Fête du Travail, etc.">
                            </div>

                            <div class="mb-3">
                                <label for="dateFerier" class="form-label">Date *</label>
                                <input type="date" class="form-control" id="dateFerier" name="dateFerier" 
                                       value="${jourFerier.dateFerier}" required>
                            </div>

                            <div class="mb-3">
                                <label for="annee" class="form-label">Année *</label>
                                <input type="number" class="form-control" id="annee" name="annee" 
                                       value="${jourFerier.annee}" required min="2020" max="2030"
                                       placeholder="Ex: 2025">
                            </div>

                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="recurrent" name="recurrent" 
                                           ${jourFerier.recurrent ? 'checked' : ''}>
                                    <label class="form-check-label" for="recurrent">
                                        Jour férié récurrent (chaque année)
                                    </label>
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle"></i> 
                                    Cochez cette case si ce jour férié se répète chaque année à la même date 
                                    (ex: Noël, Nouvel An, etc.)
                                </div>
                            </div>

                            <div class="mb-3">
                                <h6>Exemples de jours fériés :</h6>
                                <div class="row">
                                    <div class="col-md-6">
                                        <strong>Jours récurrents :</strong>
                                        <ul class="list-unstyled">
                                            <li><i class="fas fa-circle text-success"></i> Nouvel An (1er janvier)</li>
                                            <li><i class="fas fa-circle text-success"></i> Fête du Travail (1er mai)</li>
                                            <li><i class="fas fa-circle text-success"></i> Fête Nationale (14 juillet)</li>
                                            <li><i class="fas fa-circle text-success"></i> Noël (25 décembre)</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Jours variables :</strong>
                                        <ul class="list-unstyled">
                                            <li><i class="fas fa-circle text-warning"></i> Lundi de Pâques</li>
                                            <li><i class="fas fa-circle text-warning"></i> Ascension</li>
                                            <li><i class="fas fa-circle text-warning"></i> Lundi de Pentecôte</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="/jours-ferier" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times"></i> Annuler
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Enregistrer
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-fill année when date is selected
        document.getElementById('dateFerier').addEventListener('change', function() {
            const dateValue = this.value;
            if (dateValue) {
                const year = new Date(dateValue).getFullYear();
                document.getElementById('annee').value = year;
            }
        });
    </script>
</body>
</html>
