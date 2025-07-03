<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${adherant.idAdherant != null ? 'Modifier' : 'Ajouter'} un Adhérent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            ${adherant.idAdherant != null ? 'Modifier' : 'Ajouter'} un Adhérent
                        </h3>
                    </div>
                    <div class="card-body">
                        <form action="/adherants/save" method="post">
                            <input type="hidden" name="idAdherant" value="${adherant.idAdherant}">
                            
                            <div class="mb-3">
                                <label for="nomAdherant" class="form-label">Nom *</label>
                                <input type="text" class="form-control" id="nomAdherant" name="nomAdherant" 
                                       value="${adherant.nomAdherant}" required maxlength="50">
                            </div>
                            
                            <div class="mb-3">
                                <label for="prenomAdherant" class="form-label">Prénom *</label>
                                <input type="text" class="form-control" id="prenomAdherant" name="prenomAdherant" 
                                       value="${adherant.prenomAdherant}" required maxlength="50">
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">Mot de passe *</label>
                                <input type="password" class="form-control" id="password" name="password" 
                                       value="${adherant.password}" required maxlength="50">
                            </div>
                            
                            <div class="mb-3">
                                <label for="profil" class="form-label">Profil *</label>
                                <select class="form-select" id="profil" name="profil.idProfil" required>
                                    <option value="">-- Sélectionner un profil --</option>
                                    <c:forEach var="profil" items="${profils}">
                                        <option value="${profil.idProfil}" 
                                                ${adherant.profil != null && adherant.profil.idProfil == profil.idProfil ? 'selected' : ''}>
                                            Profil ${profil.nomProfil} 
                                            (Quota prêt: ${profil.quotaPret}, Quota réservation: ${profil.quotaReservation})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="/adherants" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Annuler
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</body>
</html>
