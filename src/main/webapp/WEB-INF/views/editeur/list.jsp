<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Éditeurs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Liste des Éditeurs</h2>
                    <a href="/editeurs/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouvel Éditeur
                    </a>
                </div>
                
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nom de l'Éditeur</th>
                                        <th>Localisation</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="editeur" items="${editeurs}">
                                        <tr>
                                            <td>${editeur.idEditeur}</td>
                                            <td><strong>${editeur.nomEditeur}</strong></td>
                                            <td>${editeur.localisation}</td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="/editeurs/view/${editeur.idEditeur}" class="btn btn-info btn-sm">
                                                        <i class="fas fa-eye"></i> Voir
                                                    </a>
                                                    <a href="/editeurs/edit/${editeur.idEditeur}" class="btn btn-warning btn-sm">
                                                        <i class="fas fa-edit"></i> Modifier
                                                    </a>
                                                    <a href="/editeurs/delete/${editeur.idEditeur}" 
                                                       class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet éditeur ?')">
                                                        <i class="fas fa-trash"></i> Supprimer
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <c:if test="${empty editeurs}">
                            <div class="text-center py-4">
                                <p class="text-muted">Aucun éditeur trouvé.</p>
                                <a href="/editeurs/new" class="btn btn-primary">Ajouter le premier éditeur</a>
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
