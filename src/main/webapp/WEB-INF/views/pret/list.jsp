<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Prêts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Liste des Prêts</h2>
                    <a href="/prets/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouveau Prêt
                    </a>
                </div>
                
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Adhérent</th>
                                        <th>Livre</th>
                                        <th>Exemplaire</th>
                                        <th>Type de Prêt</th>
                                        <th>Date de Prêt</th>
                                        <th>Admin</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="pret" items="${prets}">
                                        <tr>
                                            <td>${pret.idPret}</td>
                                            <td>
                                                <strong>${pret.adherant.nomAdherant} ${pret.adherant.prenomAdherant}</strong>
                                                <br>
                                                <small class="text-muted">ID: ${pret.adherant.idAdherant}</small>
                                            </td>
                                            <td>
                                                <strong>${pret.exemplaire.livre.titre}</strong>
                                                <br>
                                                <small class="text-muted">
                                                    ${pret.exemplaire.livre.auteur.nomAuteur} ${pret.exemplaire.livre.auteur.prenomAuteur}
                                                </small>
                                            </td>
                                            <td>
                                                <span class="badge bg-secondary">Ex. #${pret.exemplaire.idExemplaire}</span>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${pret.typePret.type}</span>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${pret.datePret}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <small>${pret.admin.nomAdmin} ${pret.admin.prenomAdmin}</small>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="/prets/view/${pret.idPret}" class="btn btn-info btn-sm">
                                                        <i class="fas fa-eye"></i> Voir
                                                    </a>
                                                    <a href="/prets/edit/${pret.idPret}" class="btn btn-warning btn-sm">
                                                        <i class="fas fa-edit"></i> Modifier
                                                    </a>
                                                    <a href="/prets/delete/${pret.idPret}" 
                                                       class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce prêt ?')">
                                                        <i class="fas fa-trash"></i> Supprimer
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <c:if test="${empty prets}">
                            <div class="text-center py-4">
                                <i class="fas fa-handshake fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">Aucun prêt trouvé</h4>
                                <p class="text-muted">Commencez par créer un nouveau prêt.</p>
                                <a href="/prets/new" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Créer le premier prêt
                                </a>
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
