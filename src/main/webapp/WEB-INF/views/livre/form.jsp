<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${livre.idLivre != null ? 'Modifier' : 'Nouveau'} Livre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3>${livre.idLivre != null ? 'Modifier' : 'Nouveau'} Livre</h3>
                    </div>
                    <div class="card-body">
                        <form action="/livres/save" method="post">
                            <!-- ID caché pour la modification -->
                            <c:if test="${livre.idLivre != null}">
                                <input type="hidden" name="idLivre" value="${livre.idLivre}">
                            </c:if>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="titre" class="form-label">Titre *</label>
                                        <input type="text" class="form-control" id="titre" name="titre" 
                                               value="${livre.titre}" required maxlength="50">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="isbn" class="form-label">ISBN *</label>
                                        <input type="text" class="form-control" id="isbn" name="isbn" 
                                               value="${livre.isbn}" required maxlength="50">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="auteur" class="form-label">Auteur *</label>
                                        <select class="form-select" id="auteur" name="auteur.idAuteur" required>
                                            <option value="">Sélectionner un auteur</option>
                                            <c:forEach var="auteur" items="${auteurs}">
                                                <option value="${auteur.idAuteur}" 
                                                    ${livre.auteur != null && livre.auteur.idAuteur == auteur.idAuteur ? 'selected' : ''}>
                                                    ${auteur.nomAuteur} ${auteur.prenomAuteur}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="editeur" class="form-label">Éditeur *</label>
                                        <select class="form-select" id="editeur" name="editeur.idEditeur" required>
                                            <option value="">Sélectionner un éditeur</option>
                                            <c:forEach var="editeur" items="${editeurs}">
                                                <option value="${editeur.idEditeur}" 
                                                    ${livre.editeur != null && livre.editeur.idEditeur == editeur.idEditeur ? 'selected' : ''}>
                                                    ${editeur.nomEditeur}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="langue" class="form-label">Langue</label>
                                        <input type="text" class="form-control" id="langue" name="langue" 
                                               value="${livre.langue}" maxlength="50">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="anneePublication" class="form-label">Année de Publication</label>
                                        <input type="number" class="form-control" id="anneePublication" name="anneePublication" 
                                               value="${livre.anneePublication}" min="1000" max="2100">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="nbPage" class="form-label">Nombre de Pages</label>
                                <input type="number" class="form-control" id="nbPage" name="nbPage" 
                                       value="${livre.nbPage}" min="1">
                            </div>
                            
                            <div class="mb-3">
                                <label for="synopsis" class="form-label">Synopsis</label>
                                <textarea class="form-control" id="synopsis" name="synopsis" rows="4" 
                                          maxlength="1000">${livre.synopsis}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Catégories</label>
                                <div class="row">
                                    <c:forEach var="categorie" items="${categories}">
                                        <div class="col-md-4">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" 
                                                       name="categorieIds" value="${categorie.idCategorie}" 
                                                       id="cat${categorie.idCategorie}"
                                                       <c:if test="${livre.categories != null}">
                                                           <c:forEach var="livreCategorie" items="${livre.categories}">
                                                               ${livreCategorie.idCategorie == categorie.idCategorie ? 'checked' : ''}
                                                           </c:forEach>
                                                       </c:if>>
                                                <label class="form-check-label" for="cat${categorie.idCategorie}">
                                                    Catégorie ${categorie.nomCategorie}
                                                </label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="/livres" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Retour
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${livre.idLivre != null ? 'Modifier' : 'Ajouter'}
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
