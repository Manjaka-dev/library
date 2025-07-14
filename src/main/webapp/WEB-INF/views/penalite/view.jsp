<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails de la Pénalité</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-warning">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-exclamation-triangle"></i> Détails de la Pénalité #${penalite.idPenalite}
                        </h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Informations Générales</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>ID Pénalité:</strong></td>
                                        <td>${penalite.idPenalite}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Durée:</strong></td>
                                        <td>
                                            <span class="badge bg-warning fs-6">${penalite.duree} jours</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Date Début:</strong></td>
                                        <td>
                                            <fmt:formatDate value="${penalite.datePenalite}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Date Fin:</strong></td>
                                        <td>
                                            <fmt:formatDate value="${penalite.datePenalite.plusDays(penalite.duree)}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Statut:</strong></td>
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
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <h5>Adhérent Concerné</h5>
                                <div class="card bg-light">
                                    <div class="card-body">
                                        <h6 class="card-title">${penalite.adherant.nomAdherant} ${penalite.adherant.prenomAdherant}</h6>
                                        <p class="card-text">
                                            <small class="text-muted">
                                                Numéro: #${penalite.adherant.numeroAdherant}<br>
                                                Profil: ${penalite.adherant.profil.nomProfil}<br>
                                                Date de naissance: 
                                                <fmt:formatDate value="${penalite.adherant.dateNaissance}" pattern="dd/MM/yyyy" />
                                            </small>
                                        </p>
                                        <a href="/adherants/view/${penalite.adherant.idAdherant}" class="btn btn-sm btn-primary">
                                            Voir l'adhérent
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col-md-12">
                                <h5>Progression de la Pénalité</h5>
                                <c:set var="now" value="<%= new java.util.Date() %>" />
                                <c:set var="startDate" value="${penalite.datePenalite}" />
                                <c:set var="endDate" value="${penalite.datePenalite.plusDays(penalite.duree)}" />
                                
                                <div class="progress mb-3">
                                    <c:choose>
                                        <c:when test="${now.before(startDate)}">
                                            <div class="progress-bar bg-secondary" role="progressbar" style="width: 0%">
                                                Pas encore commencée
                                            </div>
                                        </c:when>
                                        <c:when test="${now.after(endDate)}">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 100%">
                                                Terminée
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="totalDuration" value="${endDate.time - startDate.time}" />
                                            <c:set var="elapsed" value="${now.time - startDate.time}" />
                                            <c:set var="percentage" value="${(elapsed / totalDuration) * 100}" />
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: ${percentage}%">
                                                En cours (${String.format('%.1f', percentage)}%)
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-md-12">
                                <div class="btn-group" role="group">
                                    <a href="/penalites" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Retour à la liste
                                    </a>
                                    <a href="/penalites/adherant/${penalite.adherant.idAdherant}" class="btn btn-info">
                                        <i class="fas fa-user"></i> Toutes les pénalités de cet adhérent
                                    </a>
                                    <a href="/penalites/delete/${penalite.idPenalite}" 
                                       class="btn btn-danger"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette pénalité ?')">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
