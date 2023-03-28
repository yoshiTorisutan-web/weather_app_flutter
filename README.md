<!-- PROJECT LOGO -->
<h1 align="center">Weather_app</h1>
<div align="center">
  <img src="assets/logo_weather.png" alt="Logo" width="80" height="80">
</div>


<!-- Présentation du projet -->
# Présentation du projet

Application météo permettant de consulter les conditions météorologiques actuelles et futures d'une ville en utilisant une API météo. 
Elle reprend l'exemple de nombreuses applications météo présentes sur tous les téléphones actuelles.


# Présentation des fonctionnalités

Page d'accueil :
  - Page d'accueil pour accéder à l'application

Page des favoris :
  - Page permettant de consulter les villes ajoutées en favori (reste en mémoire en quittant et en revenant sur l'application)
  - Message d'accueil
  - Image qui change en fonction de l'heure de la journée (ex : 6h => Soleil / 19h => Lune)
  - Menu permettant d'accéder aux paramètres, avoir des infos complémentaires sur les lieux rajoutés en favori et savoir qui est le créateur de l'application
  - Un bouton "+" permettant d'aller sur la page d'ajout des villes
  - Pour chaque ville rajoutée, affichée en liste, un bouton ">" permet d'aller sur la page de consultations des données météos
  - Possibilité de changer en mode clair/sombre via le bouton "lune" ou "soleil" (avec Provider)
  - Toutes les villes ajoutés en favoris sont stockées dans la mémoire de l'application, afin qu'à chaque redémarrage celle-ci ne soit pas perdu. (avec SharedPreferences)

Page recherche et ajout des villes :
  - Barre de recherche qui appelle une API pour chercher les villes et affiche les suggestions dans une liste en dessous de la bar de recherche
  - Un floater bouton permettant d'avoir des informations sur comment chercher une ville
  - Un bouton microphone permettant d'utiliser la reconnaissance vocale afin d'autocompléter la barre de recherche avec sa voix

Page données météos :
  - Consultation de la météo de la ville choisie précédemment
  - Météo actuelle : température, vent, humidité, type de temps, date du jour, etc.
  - Prévisions météos de la journée heure par heure
  - Bouton permettant de situer la ville via une carte
  - Texte bouton qui permet d'aller sur les prévisions météos des jours à venir

Page Carte :
  - Situer la ville choisie sur une carte avec un pointeur

Page données prévisions météos futurs :
 - Météo détaillé de la météo du lendemain + 2 jours suivants
 - Consultation de la température maximale et minimale, humidité, vent, temps, etc.
 - Bouton d'information permettant de d'expliquer la consultation des prévisions météos futurs



<!-- Réalisé -->
# Réalisé avec ( + Version) :

* Flutter (docs, dev, widget, etc.) => 3.3.4
* Dart: 2.18.2
* DevTools: 2.15.0

# Packages (+ Version) :
* SharedPreferences: 2.0.15
* Bloc/Provider: 6.0.5
* cupertino_icons: ^1.0.2
* http: ^0.13.5
* intl: ^0.17.0
* modal_bottom_sheet: ^2.0.1
* google_fonts: ^3.0.1
* flutter_bloc: ^8.1.1
* shared_preferences: ^2.0.15
* flutter_map: any
* flutter_map_marker_cluster: any
* flutter_map_radius_cluster: any
* kdbush: ^0.0.4
* latlong2: ^0.8.1
* flutter_spinkit: ^4.1.2
* loading_animation_widget: any
* speech_to_text: ^6.1.1
* geocoding: ^2.0.1
* provider: ^6.0.5

# Polices (+ Version) :
* family : Hubballi => assets/fonts/Hubballi-Regular.ttf

<!-- API utilisées -->
# API utilisées

Pour la réalisation de l'application "Weather_App", j'ai utilisé l'API "weatherapi.com" permettant de récupérer les données JSON d'une ville et de ses conditions météorologiques actuelles et futures.

Exemple de requêtes :
- Obtenir la liste des villes : https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$query
- Obtenir la liste des conditions météorologiques : https://api.weatherapi.com/v1/forecast.json?key=$apikey&days=7&q=

Lien : 
  [Weatherapi](https://www.weatherapi.com/)
  
# Astuce :
* Pour une meilleure expérience utilisateur, afficher l'application directement sur votre mobile pour avoir un premier aperçu :)

# Présentation visuelle :
<div>
  <img src="Capture écran - weather_app/Add_city.jpg" width="500" height="500">
  <img src="assets/logo_weather.png">
  <img src="assets/logo_weather.png">
  <img src="assets/logo_weather.png">
  <img src="assets/logo_weather.png">
  <img src="assets/logo_weather.png">
</div>
