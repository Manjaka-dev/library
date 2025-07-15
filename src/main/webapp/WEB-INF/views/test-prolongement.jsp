<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test - Prolongement avec Vérification des Pénalités</title>
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
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #34495e;
        }
        
        input[type="number"], select {
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
        
        .btn-warning {
            background-color: #f39c12;
        }
        
        .btn-warning:hover {
            background-color: #e67e22;
        }
        
        .btn-danger {
            background-color: #e74c3c;
        }
        
        .btn-danger:hover {
            background-color: #c0392b;
        }
        
        .result {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 15px;
            border-radius: 4px;
            margin-top: 15px;
            min-height: 20px;
        }
        
        .result.error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
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
        
        .alert-warning {
            color: #8a6d3b;
            background-color: #fcf8e3;
            border-color: #faebcc;
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
        <h1>🔒 Test - Prolongement avec Vérification des Pénalités</h1>
        
        <div class="alert alert-info">
            <strong>✅ Nouvelle fonctionnalité :</strong> Le système vérifie maintenant si un adhérant est pénalisé avant de permettre le prolongement d'un prêt.
            <br><br>
            <strong>Règle :</strong> Un adhérant qui a des pénalités en cours ne peut pas prolonger ses prêts jusqu'à ce que ses pénalités soient terminées.
        </div>

        <div class="feature-highlight">
            <h3>🎯 Fonctionnement</h3>
            <ul>
                <li>Avant chaque tentative de prolongement, le système vérifie si l'adhérant est pénalisé</li>
                <li>Si l'adhérant a des pénalités en cours, le prolongement est refusé</li>
                <li>Le message d'erreur indique clairement la raison du refus</li>
                <li>Cette vérification utilise le système de pénalités avec gestion des jours ouvrables</li>
            </ul>
        </div>

        <div class="test-section">
            <h2>🔍 Test 1 : Vérifier le Statut de Pénalité d'un Adhérant</h2>
            <p>Entrez l'ID d'un adhérant pour vérifier s'il est actuellement pénalisé :</p>
            
            <form id="formVerifierPenalite" onsubmit="return false;">
                <div class="form-group">
                    <label for="idAdherant">ID Adhérant :</label>
                    <input type="number" id="idAdherant" name="idAdherant" required min="1">
                </div>
                <button type="button" class="btn btn-warning" onclick="verifierPenalite()">
                    Vérifier le statut de pénalité
                </button>
            </form>
            
            <div id="resultVerification" class="result" style="display: none;"></div>
        </div>

        <div class="test-section">
            <h2>🔄 Test 2 : Tenter un Prolongement</h2>
            <p>Testez le prolongement d'un prêt (avec vérification automatique des pénalités) :</p>
            
            <form id="formTesterProlongement" onsubmit="return false;">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="idPret">ID Prêt :</label>
                        <input type="number" id="idPret" name="idPret" required min="1">
                    </div>
                    <div class="form-group">
                        <label for="joursAjoutes">Jours à ajouter :</label>
                        <input type="number" id="joursAjoutes" name="joursAjoutes" value="7" required min="1" max="30">
                    </div>
                </div>
                <button type="button" class="btn btn-danger" onclick="testerProlongement()">
                    Tenter le prolongement
                </button>
            </form>
            
            <div id="resultProlongement" class="result" style="display: none;"></div>
        </div>

        <div class="test-section">
            <h2>📋 Scénarios de Test Suggérés</h2>
            <div class="alert alert-warning">
                <strong>Pour tester efficacement :</strong>
                <ol>
                    <li><strong>Adhérant sans pénalité :</strong> Trouvez un adhérant qui n'est pas pénalisé et testez le prolongement → Devrait réussir</li>
                    <li><strong>Adhérant avec pénalité :</strong> Trouvez un adhérant pénalisé et testez le prolongement → Devrait échouer avec message explicite</li>
                    <li><strong>Créer une pénalité :</strong> Rendez un livre en retard pour créer une pénalité, puis testez le prolongement</li>
                </ol>
            </div>
        </div>

        <div class="test-section">
            <h2>🔗 Liens Utiles</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                <a href="/prets" class="btn" style="text-decoration: none; display: block; text-align: center;">
                    📚 Voir les prêts
                </a>
                <a href="/penalites" class="btn" style="text-decoration: none; display: block; text-align: center;">
                    ⚖️ Voir les pénalités
                </a>
                <a href="/prolongements" class="btn" style="text-decoration: none; display: block; text-align: center;">
                    🔄 Gérer les prolongements
                </a>
                <a href="/test-penalites" class="btn" style="text-decoration: none; display: block; text-align: center;">
                    🧪 Test pénalités
                </a>
            </div>
        </div>
    </div>

    <script>
        function verifierPenalite() {
            const idAdherant = document.getElementById('idAdherant').value;
            const resultDiv = document.getElementById('resultVerification');
            
            if (!idAdherant) {
                alert('Veuillez entrer un ID d\'adhérant');
                return;
            }
            
            fetch('/test-prolongement/verifier-penalite', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'idAdherant=' + encodeURIComponent(idAdherant)
            })
            .then(response => response.text())
            .then(data => {
                resultDiv.style.display = 'block';
                resultDiv.textContent = data;
                
                if (data.includes('pénalisé et ne peut pas')) {
                    resultDiv.className = 'result error';
                } else {
                    resultDiv.className = 'result';
                }
            })
            .catch(error => {
                resultDiv.style.display = 'block';
                resultDiv.className = 'result error';
                resultDiv.textContent = 'Erreur lors de la vérification : ' + error.message;
            });
        }
        
        function testerProlongement() {
            const idPret = document.getElementById('idPret').value;
            const joursAjoutes = document.getElementById('joursAjoutes').value;
            const resultDiv = document.getElementById('resultProlongement');
            
            if (!idPret || !joursAjoutes) {
                alert('Veuillez remplir tous les champs');
                return;
            }
            
            fetch('/test-prolongement/tester-prolongement', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'idPret=' + encodeURIComponent(idPret) + '&joursAjoutes=' + encodeURIComponent(joursAjoutes)
            })
            .then(response => response.text())
            .then(data => {
                resultDiv.style.display = 'block';
                resultDiv.textContent = data;
                
                if (data.includes('Erreur') || data.includes('pénalisé')) {
                    resultDiv.className = 'result error';
                } else {
                    resultDiv.className = 'result';
                }
            })
            .catch(error => {
                resultDiv.style.display = 'block';
                resultDiv.className = 'result error';
                resultDiv.textContent = 'Erreur lors du prolongement : ' + error.message;
            });
        }
    </script>
</body>
</html>
