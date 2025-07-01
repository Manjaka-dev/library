<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails de l'Éditeur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3>Détails de l'Éditeur</h3>
                        <div>
                            <a href="/editeurs/edit/${editeur.idEditeur}" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Modifier
                            </a>
                            <a href="/editeurs" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Retour
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <table class="table table-borderless">
                            <tr>
                                <th width="30%">ID:</th>
                                <td>${editeur.idEditeur}</td>
                            </tr>
                            <tr>
                                <th>Nom de l'Éditeur:</th>
                                <td><strong>${editeur.nomEditeur}</strong></td>
                            </tr>
                            <tr>
                                <th>Localisation:</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty editeur.localisation}">
                                            ${editeur.localisation}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Non renseignée</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                        
                        <div class="mt-4">
                            <div class="d-flex justify-content-between">
                                <a href="/editeurs" class="btn btn-outline-secondary">
                                    <i class="fas fa-list"></i> Liste des éditeurs
                                </a>
                                <div>
                                    <a href="/editeurs/edit/${editeur.idEditeur}" class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Modifier
                                    </a>
                                    <a href="/editeurs/delete/${editeur.idEditeur}" 
                                       class="btn btn-danger"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet éditeur ?')">
                                        <i class="fas fa-trash"></i> Supprimer
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Section des livres publiés par cet éditeur (optionnel) -->
                <div class="card mt-3">
                    <div class="card-header">
                        <h5>Livres publiés par cet éditeur</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">
                            <i class="fas fa-info-circle"></i> 
                            Cette section pourrait afficher la liste des livres publiés par cet éditeur.
                        </p>
                        <a href="/livres?editeur=${editeur.idEditeur}" class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-book"></i> Voir les livres de cet éditeur
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
