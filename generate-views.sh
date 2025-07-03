#!/bin/bash

# Script pour générer automatiquement les vues CRUD pour toutes les entités

# Création des répertoires
mkdir -p src/main/webapp/WEB-INF/views/admin/{admin,editeur,categorie,profil,type-pret,type-retour,statut-reservation}
mkdir -p src/main/webapp/WEB-INF/views/{livre,pret,retour,exemplaire,inscription,penalite,reservation}

echo "Structure des répertoires créée avec succès!"
echo "Vous pouvez maintenant copier/adapter les templates JSP pour chaque entité."
echo ""
echo "Entités à traiter:"
echo "- Admin"
echo "- Editeur" 
echo "- Categorie"
echo "- Profil"
echo "- TypePret"
echo "- TypeRetour"
echo "- StatutReservation"
echo "- Livre"
echo "- Pret"
echo "- Retour"
echo "- Exemplaire"
echo "- Inscription"
echo "- Penalite"
echo "- Reservation"
echo ""
echo "Pour chaque entité, créez:"
echo "1. list.jsp (liste des éléments)"
echo "2. form.jsp (formulaire ajout/modification)"
echo "3. view.jsp (détails d'un élément)"
