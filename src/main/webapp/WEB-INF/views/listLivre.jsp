<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catalogue des Livres</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .book-card {
            transition: transform 0.3s ease-in-out;
            height: 100%;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .book-cover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
        }
        .filter-sidebar {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation adaptée au type d'utilisateur -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-book"></i> Bibliothèque
            </a>
            <div class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${sessionScope.userType == 'adherant'}">
                        <a class="nav-link" href="/adherant/dashboard">Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.userType == 'admin'}">
                        <a class="nav-link" href="/admin/dashboard">Dashboard Admin</a>
                    </c:when>
                    <c:otherwise>
                        <a class="nav-link" href="/">Accueil</a>
                    </c:otherwise>
                </c:choose>
                <a class="nav-link" href="/livres">Liste détaillée</a>
                <a class="nav-link" href="/logout">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Sidebar de filtres -->
            <div class="col-md-3">
                <div class="filter-sidebar sticky-top">
                    <h5><i class="fas fa-filter"></i> Filtres</h5>
                    
                    <!-- Filtre par catégorie -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">Catégories</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="all-categories" checked>
                            <label class="form-check-label" for="all-categories">
                                Toutes les catégories
                            </label>
                        </div>
                        <c:forEach var="categorie" items="${categories}">
                            <div class="form-check">
                                <input class="form-check-input category-filter" type="checkbox" 
                                       id="cat-${categorie.idCategorie}" value="${categorie.idCategorie}">
                                <label class="form-check-label" for="cat-${categorie.idCategorie}">
                                    ${categorie.nomCategorie}
                                </label>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Actions admin -->
                    <c:if test="${sessionScope.userType == 'admin'}">
                        <div class="d-grid gap-2">
                            <a href="/livres/new" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Nouveau Livre
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Contenu principal -->
            <div class="col-md-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>
                        <i class="fas fa-books text-primary"></i> Catalogue des Livres
                    </h2>
                    <div>
                        <a href="/livres" class="btn btn-outline-secondary">
                            <i class="fas fa-list"></i> Vue Liste
                        </a>
                    </div>
                </div>

                <!-- Affichage des livres en grille -->
                <div class="row" id="books-container">
                    <c:forEach var="livre" items="${livres}">
                        <div class="col-lg-4 col-md-6 mb-4 book-item" data-categories="${livre.categories}">
                            <div class="card book-card h-100">
                                <!-- Couverture du livre -->
                                <div class="book-cover">
                                    <i class="fas fa-book-open"></i>
                                </div>
                                
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${livre.titre}</h5>
                                    <p class="card-text text-muted">
                                        <small>
                                            <i class="fas fa-user"></i> ${livre.auteur.nomAuteur} ${livre.auteur.prenomAuteur}<br>
                                            <i class="fas fa-building"></i> ${livre.editeur.nomEditeur}<br>
                                            <i class="fas fa-calendar"></i> ${livre.anneePublication}<br>
                                            <i class="fas fa-language"></i> ${livre.langue}
                                        </small>
                                    </p>
                                    
                                    <!-- Catégories -->
                                    <div class="mb-2">
                                        <c:forEach var="categorie" items="${livre.categories}">
                                            <span class="badge bg-secondary me-1">${categorie.nomCategorie}</span>
                                        </c:forEach>
                                    </div>
                                    
                                    <!-- Synopsis (extrait) -->
                                    <p class="card-text flex-grow-1">
                                        <c:choose>
                                            <c:when test="${livre.synopsis.length() > 100}">
                                                ${livre.synopsis.substring(0, 100)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${livre.synopsis}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    
                                    <!-- Actions -->
                                    <div class="mt-auto">
                                        <div class="btn-group w-100" role="group">
                                            <a href="/livres/view/${livre.idLivre}" class="btn btn-info">
                                                <i class="fas fa-eye"></i> Détails
                                            </a>
                                            
                                            <c:if test="${sessionScope.userType == 'admin'}">
                                                <a href="/livres/edit/${livre.idLivre}" class="btn btn-warning">
                                                    <i class="fas fa-edit"></i> Modifier
                                                </a>
                                            </c:if>
                                            
                                            <c:if test="${sessionScope.userType == 'adherant'}">
                                                <a href="/reservations/new?livreId=${livre.idLivre}" class="btn btn-success">
                                                    <i class="fas fa-calendar-plus"></i> Réserver
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${empty livres}">
                    <div class="text-center py-5">
                        <i class="fas fa-book fa-4x text-muted mb-3"></i>
                        <h4 class="text-muted">Aucun livre trouvé</h4>
                        <p class="text-muted">Il n'y a pas encore de livres dans le catalogue.</p>
                        <c:if test="${sessionScope.userType == 'admin'}">
                            <a href="/livres/new" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Ajouter le premier livre
                            </a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filtrage par catégorie
        document.addEventListener('DOMContentLoaded', function() {
            const allCategoriesCheckbox = document.getElementById('all-categories');
            const categoryFilters = document.querySelectorAll('.category-filter');
            const bookItems = document.querySelectorAll('.book-item');

            // Gestion du filtre "Toutes les catégories"
            allCategoriesCheckbox.addEventListener('change', function() {
                if (this.checked) {
                    categoryFilters.forEach(filter => filter.checked = false);
                    showAllBooks();
                }
            });

            // Gestion des filtres individuels
            categoryFilters.forEach(filter => {
                filter.addEventListener('change', function() {
                    if (this.checked) {
                        allCategoriesCheckbox.checked = false;
                    }
                    
                    // Si aucune catégorie n'est sélectionnée, cocher "Toutes les catégories"
                    const anyChecked = Array.from(categoryFilters).some(f => f.checked);
                    if (!anyChecked) {
                        allCategoriesCheckbox.checked = true;
                        showAllBooks();
                    } else {
                        filterBooks();
                    }
                });
            });

            function showAllBooks() {
                bookItems.forEach(book => book.style.display = 'block');
            }

            function filterBooks() {
                const selectedCategories = Array.from(categoryFilters)
                    .filter(f => f.checked)
                    .map(f => f.value);

                bookItems.forEach(book => {
                    const bookCategories = book.dataset.categories || '';
                    const shouldShow = selectedCategories.some(catId => 
                        bookCategories.includes(catId)
                    );
                    book.style.display = shouldShow ? 'block' : 'none';
                });
            }
        });
    </script>
</body>
</html>
