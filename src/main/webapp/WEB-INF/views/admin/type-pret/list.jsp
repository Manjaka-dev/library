<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Types de Prêt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque - Administration
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/">Accueil</a>
                <a class="nav-link" href="/admin">Admin</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">
                            <i class="fas fa-tags"></i> Gestion des Types de Prêt
                        </h4>
                        <a href="/admin/types-pret/new" class="btn btn-light btn-sm">
                            <i class="fas fa-plus"></i> Nouveau Type
                        </a>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty typesPret}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="fas fa-hashtag"></i> ID</th>
                                            <th><i class="fas fa-tag"></i> Type</th>
                                            <th><i class="fas fa-calendar-alt"></i> Durée (jours)</th>
                                            <th><i class="fas fa-cogs"></i> Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="typePret" items="${typesPret}">
                                            <tr>
                                                <td>${typePret.idTypePret}</td>
                                                <td>
                                                    <span class="badge bg-info fs-6">${typePret.type}</span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${typePret.dureeJours != null}">
                                                            <span class="badge bg-success">${typePret.dureeJours} jours</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning">Non définie</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <a href="/admin/types-pret/edit/${typePret.idTypePret}" 
                                                           class="btn btn-outline-primary btn-sm">
                                                            <i class="fas fa-edit"></i> Modifier
                                                        </a>
                                                        <a href="/admin/types-pret/delete/${typePret.idTypePret}" 
                                                           class="btn btn-outline-danger btn-sm"
                                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce type de prêt ?')">
                                                            <i class="fas fa-trash"></i> Supprimer
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                        
                        <c:if test="${empty typesPret}">
                            <div class="text-center py-5">
                                <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">Aucun type de prêt</h5>
                                <p class="text-muted">Commencez par créer un nouveau type de prêt.</p>
                                <a href="/admin/types-pret/new" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Créer le premier type
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
