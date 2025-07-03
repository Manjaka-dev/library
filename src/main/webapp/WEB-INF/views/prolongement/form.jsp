<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Prolongement de Prêt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3>Prolongement de Prêt</h3>
                    </div>
                    <div class="card-body">
                        <!-- Messages d'erreur/succès -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle"></i>
                                ${error}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle"></i>
                                ${success}
                            </div>
                        </c:if>

                        <!-- Formulaire de prolongement -->
                        <form action="${pageContext.request.contextPath}/Prolongement/save" method="post">
                            <div class="mb-3">
                                <label for="pretSelect" class="form-label">Sélectionner un prêt à prolonger *</label>
                                <select class="form-select" id="pretSelect" name="idPret" required>
                                    <option value="">-- Choisissez un prêt en cours --</option>
                                    <c:forEach var="pret" items="${pretsEnCours}">
                                        <option value="${pret.idPret}" data-adherant="${pret.adherant.nomAdherant} ${pret.adherant.prenomAdherant}" 
                                                data-livre="${pret.exemplaire.livre.titre}" 
                                                data-debut="<fmt:formatDate value='${pret.dateDebut}' pattern='dd/MM/yyyy'/>"
                                                data-fin="<fmt:formatDate value='${pret.dateFin}' pattern='dd/MM/yyyy'/>">
                                            ${pret.adherant.nomAdherant} ${pret.adherant.prenomAdherant} - 
                                            ${pret.exemplaire.livre.titre} 
                                            (Fin: <fmt:formatDate value="${pret.dateFin}" pattern="dd/MM/yyyy"/>)
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Informations du prêt sélectionné -->
                            <div id="pretDetails" class="alert alert-info d-none">
                                <h5><i class="fas fa-info-circle"></i> Détails du prêt</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <strong>Adhérant:</strong> <span id="detailAdherant"></span><br>
                                        <strong>Livre:</strong> <span id="detailLivre"></span>
                                    </div>
                                    <div class="col-md-6">
                                        <strong>Date de début:</strong> <span id="detailDebut"></span><br>
                                        <strong>Date de fin actuelle:</strong> <span id="detailFin"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="nouvelleDateFin" class="form-label">Nouvelle date de fin *</label>
                                <input type="date" class="form-control" id="nouvelleDateFin" name="nouvelleDateFin" required>
                                <div class="form-text">La nouvelle date doit être postérieure à la date de fin actuelle.</div>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="/" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Retour
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-clock"></i> Prolonger le prêt
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
        // Affichage des détails du prêt sélectionné
        document.getElementById('pretSelect').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const detailsDiv = document.getElementById('pretDetails');
            
            if (selectedOption.value) {
                document.getElementById('detailAdherant').textContent = selectedOption.dataset.adherant;
                document.getElementById('detailLivre').textContent = selectedOption.dataset.livre;
                document.getElementById('detailDebut').textContent = selectedOption.dataset.debut;
                document.getElementById('detailFin').textContent = selectedOption.dataset.fin;
                
                detailsDiv.classList.remove('d-none');
                
                // Définir la date minimale pour le prolongement
                const finActuelle = new Date(selectedOption.dataset.fin.split('/').reverse().join('-'));
                finActuelle.setDate(finActuelle.getDate() + 1);
                document.getElementById('nouvelleDateFin').min = finActuelle.toISOString().split('T')[0];
            } else {
                detailsDiv.classList.add('d-none');
                document.getElementById('nouvelleDateFin').min = '';
            }
        });

        // Validation du formulaire
        document.querySelector('form').addEventListener('submit', function(e) {
            const pretSelect = document.getElementById('pretSelect').value;
            const nouvelleDateFin = document.getElementById('nouvelleDateFin').value;
            
            if (!pretSelect) {
                e.preventDefault();
                alert('Veuillez sélectionner un prêt à prolonger.');
                return;
            }
            
            if (!nouvelleDateFin) {
                e.preventDefault();
                alert('Veuillez saisir une nouvelle date de fin.');
                return;
            }
            
            // Vérifier que la nouvelle date est postérieure à la date actuelle de fin
            const selectedOption = document.getElementById('pretSelect').options[document.getElementById('pretSelect').selectedIndex];
            const finActuelle = new Date(selectedOption.dataset.fin.split('/').reverse().join('-'));
            const nouvelleDate = new Date(nouvelleDateFin);
            
            if (nouvelleDate <= finActuelle) {
                e.preventDefault();
                alert('La nouvelle date de fin doit être postérieure à la date de fin actuelle.');
                return;
            }
        });
    </script>
</body>
</html>
