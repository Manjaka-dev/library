<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Retours</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/">Accueil</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-undo text-danger"></i> Gestion des Retours</h2>
                    <a href="/retours/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouveau Retour
                    </a>
                </div>

                <div class="card shadow-sm">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty retours}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Livre</th>
                                                <th>Adhérent</th>
                                                <th>Date de Prêt</th>
                                                <th>Date de Retour</th>
                                                <th>Type de Retour</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="retour" items="${retours}">
                                                <tr>
                                                    <td>${retour.idRetour}</td>
                                                    <td>
                                                        <strong>${retour.pret.exemplaire.livre.titre}</strong><br>
                                                        <small class="text-muted">Prêt #${retour.pret.idPret}</small>
                                                    </td>
                                                    <td>
                                                        ${retour.pret.adherant.nomAdherant} ${retour.pret.adherant.prenomAdherant}
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">
                                                            ${retour.pret.dateDebut}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-success">
                                                            ${retour.dateRetour}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-secondary">${retour.typeRetour.nom}</span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group btn-group-sm" role="group">
                                                            <a href="/retours/view/${retour.idRetour}" 
                                                               class="btn btn-outline-info" title="Voir">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="/retours/edit/${retour.idRetour}" 
                                                               class="btn btn-outline-warning" title="Modifier">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="/retours/delete/${retour.idRetour}" 
                                                               class="btn btn-outline-danger" title="Supprimer"
                                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce retour ?')">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-undo fa-3x text-muted mb-3"></i>
                                    <h4 class="text-muted">Aucun retour trouvé</h4>
                                    <p class="text-muted">Commencez par enregistrer un nouveau retour.</p>
                                    <a href="/retours/new" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Enregistrer un Retour
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
