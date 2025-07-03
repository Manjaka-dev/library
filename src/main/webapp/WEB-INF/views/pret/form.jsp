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
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3>Nouveau Prêt</h3>
                    </div>
                    <div class="card-body">
                        <!-- Messages -->
                        <c:if test="${not empty message}">
                            <div class="alert ${message.contains('succès') || message.contains('validé') ? 'alert-success' : 'alert-danger'}" role="alert">
                                <i class="fas ${message.contains('succès') || message.contains('validé') ? 'fa-check-circle' : 'fa-exclamation-triangle'}"></i>
                                ${message}
                            </div>
                        </c:if>

                        <form action="/prets/save" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="adherantId" class="form-label">Adhérent *</label>
                                        <select class="form-select" id="adherantId" name="adherantId" required>
                                            <option value="">-- Sélectionner un adhérent --</option>
                                            <c:forEach var="adherant" items="${adherants}">
                                                <option value="${adherant.idAdherant}">
                                                    ${adherant.nomAdherant} ${adherant.prenomAdherant}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="typePret" class="form-label">Type de prêt *</label>
                                        <select class="form-select" id="typePret" name="typePret" required>
                                            <option value="">-- Sélectionner un type --</option>
                                            <c:forEach var="type" items="${typesPret}">
                                                <option value="${type.idTypePret}">${type.type}</option>
                                            </c:forEach>
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

                            <div class="mb-3">
                                <label for="dateFin" class="form-label">Date de fin du prêt *</label>
                                <input type="date" class="form-control" id="dateFin" name="dateFin" required>
                                <div class="form-text">Sélectionnez la date de fin prévue pour ce prêt.</div>
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
        // Définir la date minimale à aujourd'hui
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.getElementById('dateFin');
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            dateInput.min = tomorrow.toISOString().split('T')[0];
            
            // Définir une date par défaut (14 jours plus tard)
            const defaultDate = new Date(today);
            defaultDate.setDate(defaultDate.getDate() + 14);
            dateInput.value = defaultDate.toISOString().split('T')[0];
        });
    </script>
</body>
</html>