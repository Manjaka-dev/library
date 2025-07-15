<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Pénalités</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-warning">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-exclamation-triangle"></i> Gestion des Pénalités
                        </h3>
                    </div>
                    <div class="card-body">
                        <!-- Messages -->
                        <c:if test="${param.success == 'penalite-calculee-ouvrables'}">
                            <div class="alert alert-success" role="alert">
                                Pénalité calculée avec succès (en jours ouvrables) !
                            </div>
                        </c:if>
                        <c:if test="${param.success == 'penalite-calculee-calendaires'}">
                            <div class="alert alert-success" role="alert">
                                Pénalité calculée avec succès (en jours calendaires) !
                            </div>
                        </c:if>
                        <c:if test="${param.success == 'penalite-calculee'}">
                            <div class="alert alert-success" role="alert">
                                Pénalité calculée avec succès !
                            </div>
                        </c:if>
                        <c:if test="${param.error != null}">
                            <div class="alert alert-danger" role="alert">
                                Erreur : ${param.error}
                            </div>
                        </c:if>

                        <!-- Actions -->
                        <div class="mb-3">
                            <a href="/jours-ferier" class="btn btn-info">
                                <i class="fas fa-calendar-alt"></i> Jours Fériés
                            </a>
                            <a href="/retours" class="btn btn-secondary">
                                <i class="fas fa-undo"></i> Retours
                            </a>
                        </div>

                        <!-- Statistiques -->
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">Total Pénalités</h5>
                                        <h3 class="text-warning">${penalites.size()}</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">Pénalités Actives</h5>
                                        <h3 class="text-danger">
                                            <c:set var="activeCount" value="0" />
                                            <c:forEach var="penalite" items="${penalites}">
                                                <c:if test="${penalite.datePenalite.plusDays(penalite.duree).isAfter(now)}">
                                                    <c:set var="activeCount" value="${activeCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${activeCount}
                                        </h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">Pénalités Expirées</h5>
                                        <h3 class="text-success">${penalites.size() - activeCount}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tableau des pénalités -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Adhérent</th>
                                        <th>Durée (jours)</th>
                                        <th>Date Début</th>
                                        <th>Date Fin</th>
                                        <th>Statut</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="penalite" items="${penalites}">
                                        <tr>
                                            <td>${penalite.idPenalite}</td>
                                            <td>
                                                <strong>${penalite.adherant.nomAdherant} ${penalite.adherant.prenomAdherant}</strong><br>
                                                <small class="text-muted">#${penalite.adherant.numeroAdherant}</small>
                                            </td>
                                            <td>
                                                <span class="badge bg-warning fs-6">${penalite.duree}</span>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${penalite.datePenalite}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${penalite.datePenalite.plusDays(penalite.duree)}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${penalite.datePenalite.plusDays(penalite.duree).isAfter(now)}">
                                                        <span class="badge bg-danger">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">Expirée</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="/penalites/view/${penalite.idPenalite}" class="btn btn-sm btn-info">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="/penalites/delete/${penalite.idPenalite}" 
                                                       class="btn btn-sm btn-danger"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette pénalité ?')">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Message si aucune pénalité -->
                        <c:if test="${empty penalites}">
                            <div class="alert alert-info text-center" role="alert">
                                <i class="fas fa-info-circle"></i> Aucune pénalité trouvée.
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
