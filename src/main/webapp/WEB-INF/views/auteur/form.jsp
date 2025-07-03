<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${auteur.idAuteur != null ? 'Modifier' : 'Nouvel'} Auteur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h3>${auteur.idAuteur != null ? 'Modifier' : 'Nouvel'} Auteur</h3>
                    </div>
                    <div class="card-body">
                        <form action="/auteurs/save" method="post">
                            <!-- ID caché pour la modification -->
                            <c:if test="${auteur.idAuteur != null}">
                                <input type="hidden" name="idAuteur" value="${auteur.idAuteur}">
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="nomAuteur" class="form-label">Nom de l'Auteur *</label>
                                <input type="text" class="form-control" id="nomAuteur" name="nomAuteur" 
                                       value="${auteur.nomAuteur}" required maxlength="50"
                                       placeholder="Entrez le nom de l'auteur">
                            </div>
                            
                            <div class="mb-3">
                                <label for="prenomAuteur" class="form-label">Prénom de l'Auteur</label>
                                <input type="text" class="form-control" id="prenomAuteur" name="prenomAuteur" 
                                       value="${auteur.prenomAuteur}" maxlength="50"
                                       placeholder="Entrez le prénom de l'auteur">
                            </div>
                            
                            <div class="mb-3">
                                <label for="nationalite" class="form-label">Nationalité</label>
                                <input type="text" class="form-control" id="nationalite" name="nationalite" 
                                       value="${auteur.nationalite}" maxlength="50"
                                       placeholder="Entrez la nationalité">
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="/auteurs" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Retour
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${auteur.idAuteur != null ? 'Modifier' : 'Ajouter'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
