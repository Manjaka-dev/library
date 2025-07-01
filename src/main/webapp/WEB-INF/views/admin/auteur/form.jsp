<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${auteur.idAuteur != null ? 'Modifier' : 'Ajouter'} un Auteur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            ${auteur.idAuteur != null ? 'Modifier' : 'Ajouter'} un Auteur
                        </h3>
                    </div>
                    <div class="card-body">
                        <form action="/admin/auteurs/save" method="post">
                            <input type="hidden" name="idAuteur" value="${auteur.idAuteur}">
                            
                            <div class="mb-3">
                                <label for="nomAuteur" class="form-label">Nom *</label>
                                <input type="text" class="form-control" id="nomAuteur" name="nomAuteur" 
                                       value="${auteur.nomAuteur}" required maxlength="50">
                            </div>
                            
                            <div class="mb-3">
                                <label for="prenomAuteur" class="form-label">Prénom</label>
                                <input type="text" class="form-control" id="prenomAuteur" name="prenomAuteur" 
                                       value="${auteur.prenomAuteur}" maxlength="50">
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="/admin/auteurs" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Annuler
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Enregistrer
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</body>
</html>
