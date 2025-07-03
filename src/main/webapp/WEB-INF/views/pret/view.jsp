<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails du Prêt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3>Détails du Prêt #${pret.idPret}</h3>
                        <div>
                            <a href="/prets/edit/${pret.idPret}" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Modifier
                            </a>
                            <a href="/prets" class="btn btn-secondary btn-sm">
                                <i class="fas fa-arrow-left"></i> Retour
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h5><i class="fas fa-user text-primary"></i> Informations Adhérent</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">Nom :</th>
                                        <td><strong>${pret.adherant.nomAdherant} ${pret.adherant.prenomAdherant}</strong></td>
                                    </tr>
                                    <tr>
                                        <th>ID Adhérent :</th>
                                        <td>${pret.adherant.idAdherant}</td>
                                    </tr>
                                    <tr>
                                        <th>Profil :</th>
                                        <td><span class="badge bg-info">${pret.adherant.profil.nomProfil}</span></td>
                                    </tr>
                                </table>
                            </div>
                            
                            <div class="col-md-6">
                                <h5><i class="fas fa-book text-success"></i> Informations Livre</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">Titre :</th>
                                        <td><strong>${pret.exemplaire.livre.titre}</strong></td>
                                    </tr>
                                    <tr>
                                        <th>Auteur :</th>
                                        <td>${pret.exemplaire.livre.auteur.nomAuteur} ${pret.exemplaire.livre.auteur.prenomAuteur}</td>
                                    </tr>
                                    <tr>
                                        <th>Exemplaire :</th>
                                        <td><span class="badge bg-secondary">#${pret.exemplaire.idExemplaire}</span></td>
                                    </tr>
                                    <tr>
                                        <th>ISBN :</th>
                                        <td>${pret.exemplaire.livre.isbn}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <h5><i class="fas fa-calendar text-warning"></i> Informations Prêt</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">ID Prêt :</th>
                                        <td><strong>${pret.idPret}</strong></td>
                                    </tr>
                                    <tr>
                                        <th>Date de prêt :</th>
                                        <td>
                                            <fmt:formatDate value="${pret.datePret}" pattern="dd/MM/yyyy 'à' HH:mm"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Type de prêt :</th>
                                        <td><span class="badge bg-primary">${pret.typePret.type}</span></td>
                                    </tr>
                                </table>
                            </div>
                            
                            <div class="col-md-6">
                                <h5><i class="fas fa-user-tie text-info"></i> Administration</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">Administrateur :</th>
                                        <td>${pret.admin.nomAdmin} ${pret.admin.prenomAdmin}</td>
                                    </tr>
                                    <tr>
                                        <th>ID Admin :</th>
                                        <td>${pret.admin.idAdmin}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <div class="mt-4">
                            <div class="d-flex justify-content-between">
                                <a href="/prets" class="btn btn-outline-secondary">
                                    <i class="fas fa-list"></i> Liste des prêts
                                </a>
                                <div>
                                    <a href="/prets/edit/${pret.idPret}" class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Modifier
                                    </a>
                                    <a href="/prets/delete/${pret.idPret}" 
                                       class="btn btn-danger"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce prêt ?')">
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</body>
</html>
