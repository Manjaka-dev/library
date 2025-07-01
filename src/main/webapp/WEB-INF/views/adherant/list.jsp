<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Adhérents</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>Liste des Adhérents</h2>
                    <a href="/adherants/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouvel Adhérent
                    </a>
                </div>
                
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nom</th>
                                        <th>Prénom</th>
                                        <th>Profil</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="adherant" items="${adherants}">
                                        <tr>
                                            <td>${adherant.idAdherant}</td>
                                            <td>${adherant.nomAdherant}</td>
                                            <td>${adherant.prenomAdherant}</td>
                                            <td>${adherant.profil.nomProfil}</td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="/adherants/view/${adherant.idAdherant}" 
                                                       class="btn btn-sm btn-info">
                                                        <i class="fas fa-eye"></i> Voir
                                                    </a>
                                                    <a href="/adherants/edit/${adherant.idAdherant}" 
                                                       class="btn btn-sm btn-warning">
                                                        <i class="fas fa-edit"></i> Modifier
                                                    </a>
                                                    <a href="/adherants/delete/${adherant.idAdherant}" 
                                                       class="btn btn-sm btn-danger"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet adhérent ?')">
                                                        <i class="fas fa-trash"></i> Supprimer
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <c:if test="${empty adherants}">
                            <div class="alert alert-info text-center">
                                <h4>Aucun adhérent trouvé</h4>
                                <p>Commencez par ajouter un nouvel adhérent.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <div class="mt-3">
                    <a href="/" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à l'accueil
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</body>
</html>
