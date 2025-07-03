<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails de l'Adhérent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Détails de l'Adhérent</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Informations personnelles</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>ID:</strong></td>
                                        <td>${adherant.idAdherant}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Nom:</strong></td>
                                        <td>${adherant.nomAdherant}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Prénom:</strong></td>
                                        <td>${adherant.prenomAdherant}</td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <h5>Profil</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>ID Profil:</strong></td>
                                        <td>${adherant.profil.idProfil}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Nom Profil:</strong></td>
                                        <td>${adherant.profil.nomProfil}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Quota Prêt:</strong></td>
                                        <td>${adherant.profil.quotaPret}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Quota Réservation:</strong></td>
                                        <td>${adherant.profil.quotaReservation}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <a href="/adherants" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Retour à la liste
                            </a>
                            <div>
                                <a href="/adherants/edit/${adherant.idAdherant}" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="/adherants/delete/${adherant.idAdherant}" 
                                   class="btn btn-danger ms-2"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet adhérent ?')">
                                    <i class="fas fa-trash"></i> Supprimer
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</body>
</html>
