<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion - Bibliothèque</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .login-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px 15px 0 0;
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .user-type-selector {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 10px;
            margin-bottom: 20px;
        }
        .user-type-option {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .user-type-option:hover {
            border-color: #667eea;
            background: #f8f9ff;
        }
        .user-type-option.active {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }
        .user-type-option input[type="radio"] {
            display: none;
        }
    </style>
</head>
<body>
    <div class="login-container d-flex align-items-center justify-content-center">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="login-card">
                        <div class="login-header text-center py-4">
                            <h2 class="mb-0">
                                <i class="fas fa-book fa-2x mb-3"></i><br>
                                Bibliothèque
                            </h2>
                            <p class="mb-0">Système de Gestion</p>
                        </div>
                        
                        <div class="card-body p-4">
                            <!-- Messages d'erreur et de succès -->
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty logoutMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle"></i> ${logoutMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="/login" method="post" class="needs-validation" novalidate>
                                <!-- Sélection du type d'utilisateur -->
                                <div class="user-type-selector">
                                    <div class="row">
                                        <div class="col-6">
                                            <label class="user-type-option" for="userTypeAdmin">
                                                <input type="radio" id="userTypeAdmin" name="userType" value="admin" required>
                                                <i class="fas fa-user-shield fa-2x d-block mb-2"></i>
                                                <strong>Bibliothécaire</strong>
                                            </label>
                                        </div>
                                        <div class="col-6">
                                            <label class="user-type-option" for="userTypeAdherant">
                                                <input type="radio" id="userTypeAdherant" name="userType" value="adherant" required>
                                                <i class="fas fa-user fa-2x d-block mb-2"></i>
                                                <strong>Adhérent</strong>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Nom d'utilisateur -->
                                <div class="mb-3">
                                    <label for="username" class="form-label">
                                        <i class="fas fa-user text-primary"></i> Nom d'utilisateur *
                                    </label>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           placeholder="Entrez votre nom" required>
                                    <div class="invalid-feedback">Veuillez entrer votre nom d'utilisateur.</div>
                                </div>

                                <!-- Mot de passe -->
                                <div class="mb-4">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock text-primary"></i> Mot de passe *
                                    </label>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="Entrez votre mot de passe" required>
                                    <div class="invalid-feedback">Veuillez entrer votre mot de passe.</div>
                                </div>

                                <!-- Bouton de connexion -->
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary btn-login">
                                        <i class="fas fa-sign-in-alt"></i> Se connecter
                                    </button>
                                </div>
                            </form>

                            <!-- Aide -->
                            <div class="text-center mt-4">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle"></i> 
                                    Utilisez vos identifiants pour accéder au système
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Gestion de la sélection du type d'utilisateur
        document.querySelectorAll('input[name="userType"]').forEach(function(radio) {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.user-type-option').forEach(function(option) {
                    option.classList.remove('active');
                });
                if (this.checked) {
                    this.closest('.user-type-option').classList.add('active');
                }
            });
        });

        // Validation Bootstrap
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
</body>
</html>
