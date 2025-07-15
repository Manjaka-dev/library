<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test - Système de Pénalités avec Jours Fériés</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2c3e50;
            text-align: center;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
            margin-bottom: 30px;
        }
        
        h2 {
            color: #34495e;
            margin-top: 30px;
            margin-bottom: 15px;
        }
        
        .test-section {
            background-color: #ecf0f1;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #3498db;
        }
        
        .holiday-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }
        
        .holiday-item {
            background-color: #fff;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .holiday-date {
            font-weight: bold;
            color: #e74c3c;
            font-size: 14px;
        }
        
        .holiday-name {
            color: #2c3e50;
            font-size: 16px;
            margin-top: 5px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #34495e;
        }
        
        input[type="date"], input[type="text"], select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
        }
        
        .btn:hover {
            background-color: #2980b9;
        }
        
        .btn-success {
            background-color: #27ae60;
        }
        
        .btn-success:hover {
            background-color: #229954;
        }
        
        .result {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 15px;
            border-radius: 4px;
            margin-top: 15px;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        
        .alert-info {
            color: #31708f;
            background-color: #d9edf7;
            border-color: #bce8f1;
        }
        
        .alert-success {
            color: #3c763d;
            background-color: #dff0d8;
            border-color: #d6e9c6;
        }
        
        .feature-highlight {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .feature-highlight h3 {
            color: #856404;
            margin-top: 0;
        }
        
        .feature-highlight ul {
            margin: 10px 0;
            padding-left: 20px;
        }
        
        .feature-highlight li {
            margin-bottom: 5px;
        }
        
        code {
            background-color: #f8f9fa;
            padding: 2px 4px;
            border-radius: 3px;
            font-family: "Courier New", monospace;
            color: #e83e8c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎉 Système de Pénalités avec Gestion des Jours Fériés</h1>
        
        <div class="alert alert-success">
            <strong>✅ Félicitations !</strong> Votre système de bibliothèque prend maintenant en compte :
            <ul>
                <li><strong>Les weekends</strong> (samedi et dimanche) - automatiquement exclus</li>
                <li><strong>Les jours fériés</strong> - configurables et récurrents</li>
                <li><strong>Le calcul intelligent des pénalités</strong> - uniquement en jours ouvrables</li>
            </ul>
        </div>

        <div class="feature-highlight">
            <h3>🔧 Fonctionnalités Implémentées</h3>
            <ul>
                <li><strong>Table <code>jour_ferier</code></strong> : Stockage des jours fériés avec support de récurrence</li>
                <li><strong>Service <code>JourFerierService</code></strong> : Calcul intelligent des jours ouvrables</li>
                <li><strong>Pénalités intelligentes</strong> : Calcul automatique excluant weekends et jours fériés</li>
                <li><strong>Interface d'administration</strong> : Gestion des jours fériés via <code>/jours-ferier</code></li>
                <li><strong>API de vérification</strong> : Endpoints pour tester les fonctionnalités</li>
            </ul>
        </div>

        <div class="test-section">
            <h2>📅 Jours Fériés Configurés</h2>
            <p>Voici les jours fériés actuellement configurés dans votre système :</p>
            
            <div class="holiday-list">
                <div class="holiday-item">
                    <div class="holiday-date">📅 01/01/2025</div>
                    <div class="holiday-name">Jour de l'An</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 21/04/2025</div>
                    <div class="holiday-name">Lundi de Pâques</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 01/05/2025</div>
                    <div class="holiday-name">Fête du Travail</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 08/05/2025</div>
                    <div class="holiday-name">Fête de la Victoire</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 29/05/2025</div>
                    <div class="holiday-name">Ascension</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 09/06/2025</div>
                    <div class="holiday-name">Lundi de Pentecôte</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 14/07/2025</div>
                    <div class="holiday-name">Fête Nationale</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 15/08/2025</div>
                    <div class="holiday-name">Assomption</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 01/11/2025</div>
                    <div class="holiday-name">Toussaint</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 11/11/2025</div>
                    <div class="holiday-name">Armistice</div>
                </div>
                <div class="holiday-item">
                    <div class="holiday-date">📅 25/12/2025</div>
                    <div class="holiday-name">Noël</div>
                </div>
            </div>
        </div>

        <div class="test-section">
            <h2>🧪 Test du Calculateur de Jours Ouvrables</h2>
            <p>Testez le calcul des jours ouvrables entre deux dates :</p>
            
            <form method="post" action="/test-jours-ouvrables">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="dateDebut">Date de début :</label>
                        <input type="date" id="dateDebut" name="dateDebut" required>
                    </div>
                    <div class="form-group">
                        <label for="dateFin">Date de fin :</label>
                        <input type="date" id="dateFin" name="dateFin" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-success">Calculer les jours ouvrables</button>
            </form>
            
            <c:if test="${calculEffectue}">
                <div class="result">
                    <h3>📊 Résultat du Calcul</h3>
                    <p><strong>Période :</strong> Du ${dateDebut} au ${dateFin}</p>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 15px;">
                        <div style="background-color: #fff; padding: 15px; border-radius: 5px; text-align: center;">
                            <div style="font-size: 24px; font-weight: bold; color: #27ae60;">${joursOuvrables}</div>
                            <div>Jours ouvrables</div>
                        </div>
                        <div style="background-color: #fff; padding: 15px; border-radius: 5px; text-align: center;">
                            <div style="font-size: 24px; font-weight: bold; color: #e74c3c;">${joursCalendaires}</div>
                            <div>Jours calendaires</div>
                        </div>
                        <div style="background-color: #fff; padding: 15px; border-radius: 5px; text-align: center;">
                            <div style="font-size: 24px; font-weight: bold; color: #f39c12;">${difference}</div>
                            <div>Jours exclus</div>
                        </div>
                    </div>
                    <p style="margin-top: 15px;"><strong>💡 Explication :</strong> Le système a automatiquement exclu ${difference} jour(s) (weekends et jours fériés) du calcul de pénalité.</p>
                </div>
            </c:if>
            
            <c:if test="${not empty erreur}">
                <div style="background-color: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; padding: 15px; border-radius: 4px; margin-top: 15px;">
                    <strong>❌ Erreur :</strong> ${erreur}
                </div>
            </c:if>
        </div>

        <div class="test-section">
            <h2>⚖️ Fonctionnement des Pénalités</h2>
            <div class="alert alert-info">
                <strong>Comment ça marche :</strong>
                <ol>
                    <li>Quand un livre est rendu en retard, le système calcule automatiquement la pénalité</li>
                    <li>Le calcul exclut automatiquement les weekends et jours fériés</li>
                    <li>Seuls les jours ouvrables sont comptabilisés pour la pénalité</li>
                    <li>Les pénalités sont cumulatives et ne se chevauchent pas</li>
                </ol>
            </div>
            
            <p><strong>Exemple :</strong></p>
            <p>Si un livre devait être rendu un <strong>jeudi</strong> et est rendu le <strong>mardi suivant</strong> :</p>
            <ul>
                <li>Vendredi : 1 jour de retard</li>
                <li>Samedi : <em>weekend - ignoré</em></li>
                <li>Dimanche : <em>weekend - ignoré</em></li>
                <li>Lundi : 2 jours de retard</li>
                <li>Mardi : livre rendu</li>
            </ul>
            <p><strong>Résultat :</strong> Pénalité de <strong>2 jours</strong> (au lieu de 5 jours calendaires)</p>
        </div>

        <div class="test-section">
            <h2>🔗 Liens Utiles</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px;">
                <a href="/jours-ferier" class="btn" style="text-decoration: none; display: block; text-align: center;">
                    📅 Gérer les jours fériés
                </a>
                <a href="/penalites" class="btn" style="text-decoration: none; display: block; text-align: center;">
                    ⚖️ Voir les pénalités
                </a>
                <a href="/prets" class="btn" style="text-decoration: none; display: block; text-align: center;">
                    📚 Gérer les prêts
                </a>
                <a href="/retours" class="btn" style="text-decoration: none; display: block; text-align: center;">
                    🔄 Gérer les retours
                </a>
            </div>
        </div>

        <div class="test-section">
            <h2>💡 Prochaines Améliorations Possibles</h2>
            <ul>
                <li><strong>Configuration flexible</strong> : Paramétrer le taux de pénalité par jour</li>
                <li><strong>Notifications automatiques</strong> : Alerter les adhérents avant expiration</li>
                <li><strong>Gestion des exceptions</strong> : Jours fériés locaux ou régionaux</li>
                <li><strong>Rapports statistiques</strong> : Analyse des retards et pénalités</li>
                <li><strong>Interface mobile</strong> : Application responsive pour smartphones</li>
            </ul>
        </div>
    </div>
</body>
</html>
