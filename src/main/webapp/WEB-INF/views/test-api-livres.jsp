<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test API Livres</title>
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
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        h2 {
            color: #444;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .endpoint {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            border-left: 4px solid #007bff;
        }
        .method {
            font-weight: bold;
            color: #007bff;
        }
        .url {
            font-family: monospace;
            background-color: #e9ecef;
            padding: 5px;
            border-radius: 3px;
        }
        .description {
            color: #666;
            margin-top: 5px;
        }
        .test-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            margin: 5px;
        }
        .test-button:hover {
            background-color: #0056b3;
        }
        .response {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            padding: 15px;
            border-radius: 5px;
            margin-top: 10px;
            max-height: 400px;
            overflow-y: auto;
        }
        .response pre {
            margin: 0;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        .error {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
        .success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        .input-group {
            margin: 10px 0;
        }
        .input-group label {
            display: inline-block;
            width: 80px;
            font-weight: bold;
        }
        .input-group input {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔌 Test API Web - Livres avec Exemplaires</h1>
        
        <h2>Endpoints disponibles</h2>
        
        <div class="endpoint">
            <div class="method">GET</div>
            <div class="url">/api/livres</div>
            <div class="description">Obtenir tous les livres avec leurs exemplaires</div>
            <button class="test-button" onclick="testAllLivres()">Tester</button>
            <div id="response-all" class="response" style="display: none;"></div>
        </div>
        
        <div class="endpoint">
            <div class="method">GET</div>
            <div class="url">/api/livres/{id}</div>
            <div class="description">Obtenir un livre spécifique avec ses exemplaires</div>
            <div class="input-group">
                <label>ID Livre:</label>
                <input type="number" id="livre-id" value="1" min="1">
                <button class="test-button" onclick="testLivreById()">Tester</button>
            </div>
            <div id="response-by-id" class="response" style="display: none;"></div>
        </div>
        
        <div class="endpoint">
            <div class="method">GET</div>
            <div class="url">/api/livres/{id}/exemplaires</div>
            <div class="description">Obtenir seulement les exemplaires d'un livre</div>
            <div class="input-group">
                <label>ID Livre:</label>
                <input type="number" id="exemplaires-id" value="1" min="1">
                <button class="test-button" onclick="testExemplaires()">Tester</button>
            </div>
            <div id="response-exemplaires" class="response" style="display: none;"></div>
        </div>
    </div>

    <script>
        function showResponse(elementId, data, isError = false) {
            const element = document.getElementById(elementId);
            element.style.display = 'block';
            element.className = 'response ' + (isError ? 'error' : 'success');
            element.innerHTML = '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        }

        function testAllLivres() {
            fetch('/api/livres')
                .then(response => response.json())
                .then(data => {
                    showResponse('response-all', data);
                })
                .catch(error => {
                    showResponse('response-all', { error: error.message }, true);
                });
        }

        function testLivreById() {
            const id = document.getElementById('livre-id').value;
            fetch(`/api/livres/${id}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    showResponse('response-by-id', data);
                })
                .catch(error => {
                    showResponse('response-by-id', { error: error.message }, true);
                });
        }

        function testExemplaires() {
            const id = document.getElementById('exemplaires-id').value;
            fetch(`/api/livres/${id}/exemplaires`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    showResponse('response-exemplaires', data);
                })
                .catch(error => {
                    showResponse('response-exemplaires', { error: error.message }, true);
                });
        }
    </script>
</body>
</html>
