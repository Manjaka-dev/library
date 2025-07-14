<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Debug Transformation Réservation → Prêt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h4 class="mb-0">🔍 Debug Transformation Réservation → Prêt</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <strong>❌ Erreur :</strong> ${error}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty debugInfo}">
                            <div class="alert alert-success">
                                <strong>✅ Debug :</strong> ${debugInfo}
                            </div>
                        </c:if>
                        
                        <div class="alert alert-info">
                            <h5>📝 Instructions :</h5>
                            <p>Cette page teste la transformation d'une réservation en prêt.</p>
                            <p><strong>Pour utiliser :</strong></p>
                            <ol>
                                <li><strong>Assurez-vous d'être connecté en tant qu'administrateur</strong></li>
                                <li><strong>Créez d'abord une inscription pour l'adhérant :</strong> 
                                    <br><code>/prets/create-test-inscription/{ID_ADHERANT}</code></li>
                                <li><strong>Puis testez la transformation :</strong> 
                                    <br><code>/prets/debug-transformation/{ID_RESERVATION}</code></li>
                                <li>Consultez les logs dans la console Spring Boot pour voir les détails</li>
                            </ol>
                        </div>
                        
                        <div class="alert alert-warning">
                            <h5>🔍 Points vérifiés :</h5>
                            <ul>
                                <li>Autorisation administrateur</li>
                                <li>Existence de la réservation</li>
                                <li>Statut de l'adhérant (actif/pénalisé)</li>
                                <li>Disponibilité des exemplaires</li>
                                <li>Session administrateur valide</li>
                            </ul>
                        </div>
                        
                        <div class="mt-3">
                            <a href="/reservations" class="btn btn-primary">
                                ← Retour aux réservations
                            </a>
                            <a href="/prets" class="btn btn-secondary">
                                Voir les prêts
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
