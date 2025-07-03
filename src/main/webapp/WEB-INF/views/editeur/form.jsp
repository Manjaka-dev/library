<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${editeur.idEditeur != null ? 'Modifier' : 'Nouvel'} Éditeur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h3>${editeur.idEditeur != null ? 'Modifier' : 'Nouvel'} Éditeur</h3>
                    </div>
                    <div class="card-body">
                        <form action="/editeurs/save" method="post">
                            <!-- ID caché pour la modification -->
                            <c:if test="${editeur.idEditeur != null}">
                                <input type="hidden" name="idEditeur" value="${editeur.idEditeur}">
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="nomEditeur" class="form-label">Nom de l'Éditeur *</label>
                                <input type="text" class="form-control" id="nomEditeur" name="nomEditeur" 
                                       value="${editeur.nomEditeur}" required maxlength="50"
                                       placeholder="Entrez le nom de l'éditeur">
                            </div>
                            
                            <div class="mb-3">
                                <label for="localisation" class="form-label">Localisation</label>
                                <input type="text" class="form-control" id="localisation" name="localisation" 
                                       value="${editeur.localisation}" maxlength="50"
                                       placeholder="Entrez la localisation (ville, pays...)">
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="/editeurs" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Retour
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${editeur.idEditeur != null ? 'Modifier' : 'Ajouter'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
