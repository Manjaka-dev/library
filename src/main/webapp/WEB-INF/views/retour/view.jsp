<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails du Retour</title>
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
                <a class="nav-link" href="/retours">Retours</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-undo text-danger"></i> Détails du Retour #${retour.idRetour}</h2>
                    <div>
                        <a href="/retours/edit/${retour.idRetour}" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Modifier
                        </a>
                        <a href="/retours" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Retour
                        </a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card shadow-sm">
                            <div class="card-header bg-danger text-white">
                                <h5 class="mb-0"><i class="fas fa-info-circle"></i> Informations du Retour</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">ID Retour</h6>
                                        <p class="fw-bold">#${retour.idRetour}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Date de Retour</h6>
                                        <p class="fw-bold">
                                            <i class="fas fa-calendar"></i> ${retour.dateRetour}
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Type de Retour</h6>
                                        <p>
                                            <span class="badge bg-secondary fs-6">${retour.typeRetour.nomTypeRetour}</span>
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Prêt Associé</h6>
                                        <p class="fw-bold">
                                            <a href="/prets/view/${retour.pret.idPret}" class="text-decoration-none">
                                                Prêt #${retour.pret.idPret}
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Informations du Prêt -->
                        <div class="card shadow-sm mt-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-handshake"></i> Détails du Prêt</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Date de Début du Prêt</h6>
                                        <p class="fw-bold">
                                            <i class="fas fa-calendar-plus"></i> ${retour.pret.dateDebut}
                                        </p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Type de Prêt</h6>
                                        <p>
                                            <span class="badge bg-info">${retour.pret.typePret.type}</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Informations du Livre -->
                        <div class="card shadow-sm mt-4">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-book"></i> Livre Retourné</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Titre</h6>
                                        <p class="fw-bold">${retour.pret.exemplaire.livre.titre}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted">ISBN</h6>
                                        <p>${retour.pret.exemplaire.livre.isbn}</p>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Auteur</h6>
                                        <p>${retour.pret.exemplaire.livre.auteur.nomAuteur} ${retour.pret.exemplaire.livre.auteur.prenomAuteur}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-muted">Exemplaire</h6>
                                        <p>
                                            <span class="badge bg-warning text-dark">Exemplaire #${retour.pret.exemplaire.idExemplaire}</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <!-- Informations de l'Adhérent -->
                        <div class="card shadow-sm">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-user"></i> Adhérent</h5>
                            </div>
                            <div class="card-body">
                                <h6 class="text-muted">Nom complet</h6>
                                <p class="fw-bold">${retour.pret.adherant.nomAdherant} ${retour.pret.adherant.prenomAdherant}</p>
                                
                                <h6 class="text-muted">ID Adhérent</h6>
                                <p>#${retour.pret.adherant.idAdherant}</p>
                                
                                <c:if test="${not empty retour.pret.adherant.profil}">
                                    <h6 class="text-muted">Profil</h6>
                                    <p><span class="badge bg-info">${retour.pret.adherant.profil.nomProfil}</span></p>
                                </c:if>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="card shadow-sm mt-4">
                            <div class="card-header bg-dark text-white">
                                <h5 class="mb-0"><i class="fas fa-cogs"></i> Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="/retours/edit/${retour.idRetour}" class="btn btn-warning">
                                        <i class="fas fa-edit"></i> Modifier
                                    </a>
                                    <a href="/retours/delete/${retour.idRetour}" 
                                       class="btn btn-danger"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce retour ?')">
                                        <i class="fas fa-trash"></i> Supprimer
                                    </a>
                                    <a href="/prets/view/${retour.pret.idPret}" class="btn btn-info">
                                        <i class="fas fa-handshake"></i> Voir le Prêt
                                    </a>
                                    <a href="/livres/view/${retour.pret.exemplaire.livre.idLivre}" class="btn btn-success">
                                        <i class="fas fa-book"></i> Voir le Livre
                                    </a>
                                    <a href="/adherants/view/${retour.pret.adherant.idAdherant}" class="btn btn-primary">
                                        <i class="fas fa-user"></i> Voir l'Adhérent
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
</body>
</html>
