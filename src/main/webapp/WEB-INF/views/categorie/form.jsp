<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${categorie.idCategorie != null ? 'Modifier' : 'Nouvelle'} Catégorie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h3>${categorie.idCategorie != null ? 'Modifier' : 'Nouvelle'} Catégorie</h3>
                    </div>
                    <div class="card-body">
                        <form action="/categories/save" method="post">
                            <!-- ID caché pour la modification -->
                            <c:if test="${categorie.idCategorie != null}">
                                <input type="hidden" name="idCategorie" value="${categorie.idCategorie}">
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="nomCategorie" class="form-label">Nom de la Catégorie *</label>
                                <input type="text" class="form-control" id="nomCategorie" name="nomCategorie" 
                                       value="${categorie.nomCategorie}" required
                                       placeholder="Ex: Science">
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="/categories" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Retour
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> ${categorie.idCategorie != null ? 'Modifier' : 'Ajouter'}
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
