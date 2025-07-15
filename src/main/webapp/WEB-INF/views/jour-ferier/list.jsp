<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Jours Fériés - Bibliothèque</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-calendar-alt"></i> Gestion des Jours Fériés
                        </h3>
                    </div>
                    <div class="card-body">
                        <!-- Messages -->
                        <c:if test="${param.success == 'jour-ferier-cree'}">
                            <div class="alert alert-success" role="alert">
                                Jour férié créé avec succès !
                            </div>
                        </c:if>
                        <c:if test="${param.error != null}">
                            <div class="alert alert-danger" role="alert">
                                Erreur : ${param.error}
                            </div>
                        </c:if>

                        <!-- Actions -->
                        <div class="mb-3">
                            <a href="/jours-ferier/new" class="btn btn-success">
                                <i class="fas fa-plus"></i> Nouveau Jour Férié
                            </a>
                            <a href="/penalites" class="btn btn-secondary">
                                <i class="fas fa-exclamation-triangle"></i> Pénalités
                            </a>
                        </div>

                        <!-- Statistiques -->
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">Total Jours Fériés</h5>
                                        <h3 class="text-primary">${joursFerier.size()}</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">Jours Récurrents</h5>
                                        <h3 class="text-success">
                                            <c:set var="recurrentCount" value="0" />
                                            <c:forEach var="jour" items="${joursFerier}">
                                                <c:if test="${jour.recurrent}">
                                                    <c:set var="recurrentCount" value="${recurrentCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${recurrentCount}
                                        </h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">Jours Variables</h5>
                                        <h3 class="text-warning">${joursFerier.size() - recurrentCount}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tableau des jours fériés -->
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nom du Jour</th>
                                        <th>Date</th>
                                        <th>Année</th>
                                        <th>Type</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="jour" items="${joursFerier}">
                                        <tr>
                                            <td>${jour.idJourFerier}</td>
                                            <td>
                                                <strong>${jour.nomJour}</strong>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${jour.dateFerier}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td>${jour.annee}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${jour.recurrent}">
                                                        <span class="badge bg-success">Récurrent</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning">Variable</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="/jours-ferier/edit/${jour.idJourFerier}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="/jours-ferier/delete/${jour.idJourFerier}" 
                                                   class="btn btn-sm btn-danger" 
                                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce jour férié ?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Outils de vérification -->
                        <div class="mt-4">
                            <h5>Outils de Vérification</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <h6>Vérifier une date</h6>
                                            <form action="/jours-ferier/check" method="get">
                                                <div class="input-group">
                                                    <input type="date" name="date" class="form-control" required>
                                                    <button type="submit" class="btn btn-outline-primary">
                                                        <i class="fas fa-search"></i> Vérifier
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <h6>Calculer jours ouvrables</h6>
                                            <form action="/jours-ferier/calcul-jours-ouvrables" method="get">
                                                <div class="row">
                                                    <div class="col-md-5">
                                                        <input type="date" name="dateDebut" class="form-control" placeholder="Date début" required>
                                                    </div>
                                                    <div class="col-md-5">
                                                        <input type="date" name="dateFin" class="form-control" placeholder="Date fin" required>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <button type="submit" class="btn btn-outline-success">
                                                            <i class="fas fa-calculator"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
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
</body>
</html>
