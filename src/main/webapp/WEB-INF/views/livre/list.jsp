<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Livres</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Liste des Livres</h2>
                    <a href="/livres/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouveau Livre
                    </a>
                </div>
                
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Titre</th>
                                        <th>ISBN</th>
                                        <th>Auteur</th>
                                        <th>Éditeur</th>
                                        <th>Année</th>
                                        <th>Langue</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="livre" items="${livres}">
                                        <tr>
                                            <td>${livre.idLivre}</td>
                                            <td>${livre.titre}</td>
                                            <td>${livre.isbn}</td>
                                            <td>${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}</td>
                                            <td>${livre.editeur.nomEditeur}</td>
                                            <td>${livre.anneePublication}</td>
                                            <td>${livre.langue}</td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="/livres/view/${livre.idLivre}" class="btn btn-info btn-sm">
                                                        <i class="fas fa-eye"></i> Voir
                                                    </a>
                                                    <a href="/livres/edit/${livre.idLivre}" class="btn btn-warning btn-sm">
                                                        <i class="fas fa-edit"></i> Modifier
                                                    </a>
                                                    <a href="/livres/delete/${livre.idLivre}" 
                                                       class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce livre ?')">
                                                        <i class="fas fa-trash"></i> Supprimer
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <c:if test="${empty livres}">
                            <div class="text-center py-4">
                                <p class="text-muted">Aucun livre trouvé.</p>
                                <a href="/livres/new" class="btn btn-primary">Ajouter le premier livre</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
