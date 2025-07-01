<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails du Livre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3>Détails du Livre</h3>
                        <div>
                            <a href="/livres/edit/${livre.idLivre}" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Modifier
                            </a>
                            <a href="/livres" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Retour
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="30%">ID:</th>
                                        <td>${livre.idLivre}</td>
                                    </tr>
                                    <tr>
                                        <th>Titre:</th>
                                        <td><strong>${livre.titre}</strong></td>
                                    </tr>
                                    <tr>
                                        <th>ISBN:</th>
                                        <td>${livre.isbn}</td>
                                    </tr>
                                    <tr>
                                        <th>Auteur:</th>
                                        <td>${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}</td>
                                    </tr>
                                    <tr>
                                        <th>Éditeur:</th>
                                        <td>${livre.editeur.nomEditeur}</td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">Langue:</th>
                                        <td>${livre.langue}</td>
                                    </tr>
                                    <tr>
                                        <th>Année de Publication:</th>
                                        <td>${livre.anneePublication}</td>
                                    </tr>
                                    <tr>
                                        <th>Nombre de Pages:</th>
                                        <td>${livre.nbPage}</td>
                                    </tr>
                                    <tr>
                                        <th>Catégories:</th>
                                        <td>
                                            <c:if test="${not empty livre.categories}">
                                                <c:forEach var="categorie" items="${livre.categories}" varStatus="status">
                                                    <span class="badge bg-primary">Catégorie ${categorie.nomCategorie}</span>
                                                    <c:if test="${!status.last}"> </c:if>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${empty livre.categories}">
                                                <span class="text-muted">Aucune catégorie</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <c:if test="${not empty livre.synopsis}">
                            <div class="row mt-3">
                                <div class="col-12">
                                    <h5>Synopsis:</h5>
                                    <div class="card bg-light">
                                        <div class="card-body">
                                            <p class="card-text">${livre.synopsis}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="d-flex justify-content-between">
                                    <a href="/livres" class="btn btn-outline-secondary">
                                        <i class="fas fa-list"></i> Liste des livres
                                    </a>
                                    <div>
                                        <a href="/livres/edit/${livre.idLivre}" class="btn btn-warning">
                                            <i class="fas fa-edit"></i> Modifier
                                        </a>
                                        <a href="/livres/delete/${livre.idLivre}" 
                                           class="btn btn-danger"
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce livre ?')">
                                            <i class="fas fa-trash"></i> Supprimer
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
