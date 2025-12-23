# 2048 - Flutter Mobile Game

Une implémentation mobile du célèbre jeu 2048 développée avec Flutter.

## Description

Ce jeu est une version mobile native du populaire jeu de puzzle 2048. L'objectif est de combiner des tuiles numérotées pour créer une tuile avec le nombre 2048.

## Fonctionnalités

- **Grille 4x4** avec tuiles numérotées
- **Démarrage automatique** avec 3-4 tuiles aléatoires (valeur 2 ou 4)
- **Contrôles tactiles** : glissez dans n'importe quelle direction (haut, bas, gauche, droite)
- **Animations fluides** pour les mouvements et fusions de tuiles
- **Fusion de tuiles** : deux tuiles identiques fusionnent pour doubler leur valeur
- **Système de score** en temps réel
- **Meilleur score** sauvegardé localement avec SharedPreferences
- **Détection de fin de partie** automatique
- **Bouton "Nouvelle partie"** pour recommencer à tout moment
- **Message de victoire** quand vous atteignez 2048 (avec option de continuer)
- **Design responsive** adapté aux différentes tailles d'écran mobile

## Architecture du Projet

```
lib/
├── models/
│   ├── tile.dart          # Modèle pour une tuile individuelle
│   └── board.dart         # Logique de jeu et gestion du plateau
├── providers/
│   └── game_provider.dart # Gestion d'état avec Provider
├── screens/
│   └── game_screen.dart   # Écran principal du jeu
├── widgets/
│   ├── grid_widget.dart   # Widget de la grille de fond
│   └── tile_widget.dart   # Widget pour afficher une tuile
└── main.dart              # Point d'entrée de l'application
```

## Prérequis

Avant de pouvoir exécuter ce projet, vous devez installer Flutter sur votre machine.

### Installation de Flutter sur Windows

1. **Télécharger Flutter SDK**
   - Visitez: https://docs.flutter.dev/get-started/install/windows
   - Téléchargez le fichier ZIP du Flutter SDK

2. **Extraire Flutter**
   - Extrayez le fichier ZIP dans un emplacement permanent (ex: `C:\src\flutter`)
   - NE PAS installer dans un répertoire nécessitant des privilèges élevés

3. **Ajouter Flutter au PATH**
   - Ouvrez les "Variables d'environnement"
   - Ajoutez le chemin `C:\src\flutter\bin` à la variable PATH
   - Redémarrez votre terminal

4. **Vérifier l'installation**
   ```bash
   flutter doctor
   ```

5. **Installer les dépendances Android (pour tester sur Android)**
   - Téléchargez Android Studio: https://developer.android.com/studio
   - Installez les Android SDK via Android Studio
   - Configurez un émulateur Android ou connectez un appareil physique

## Installation du Projet

1. **Cloner ou naviguer vers le projet**
   ```bash
   cd c:\Users\lomao\Desktop\twenty-forty-eight
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Vérifier que tout est configuré**
   ```bash
   flutter doctor
   ```

## Exécution de l'Application

### Sur un émulateur Android
```bash
flutter run
```

### Sur un appareil physique
1. Activez le mode développeur sur votre téléphone
2. Activez le débogage USB
3. Connectez votre téléphone via USB
4. Exécutez:
   ```bash
   flutter devices          # Vérifier que l'appareil est détecté
   flutter run             # Lancer l'application
   ```

### Compilation pour la production

**Android (APK)**
```bash
flutter build apk --release
```
Le fichier APK sera dans: `build/app/outputs/flutter-apk/app-release.apk`

**Android (App Bundle pour Google Play)**
```bash
flutter build appbundle --release
```

**iOS (nécessite un Mac)**
```bash
flutter build ios --release
```

## Comment Jouer

1. **Démarrer**: L'application démarre automatiquement avec 3-4 tuiles sur le plateau
2. **Déplacer**: Glissez votre doigt dans n'importe quelle direction pour déplacer toutes les tuiles
3. **Fusionner**: Quand deux tuiles avec le même nombre se touchent, elles fusionnent en une seule
4. **Score**: Chaque fusion ajoute la valeur de la nouvelle tuile à votre score
5. **Objectif**: Créer une tuile avec le nombre 2048
6. **Fin de partie**: Le jeu se termine quand aucun mouvement n'est possible

## Technologies Utilisées

- **Flutter**: Framework de développement mobile
- **Provider**: Gestion d'état
- **SharedPreferences**: Sauvegarde locale du meilleur score
- **Dart**: Langage de programmation

## Choix de Conception

### Gestion d'État
Utilisation du pattern Provider pour une gestion d'état réactive et efficace.

### Animations
- Animations de déplacement fluides (150ms)
- Animation de pop pour les nouvelles tuiles
- Animation de pulse pour les fusions

### Couleurs des Tuiles
Palette de couleurs inspirée du jeu original 2048, avec des couleurs progressives selon la valeur.

### Performance
- Optimisation des rebuilds avec Consumer
- Animations GPU-accelerated
- Gestion efficace de la mémoire

## Améliorations Possibles (Bonus)

- [ ] Support du mode paysage
- [ ] Niveaux de difficulté (grille 5x5, 6x6)
- [ ] Effets sonores
- [ ] Musique de fond
- [ ] Thèmes de couleurs personnalisables
- [ ] Historique des parties
- [ ] Classements en ligne
- [ ] Support multi-langue
- [ ] Mode sombre

## Dépannage

### "flutter: command not found"
- Vérifiez que Flutter est bien ajouté au PATH
- Redémarrez votre terminal

### Erreurs de dépendances
```bash
flutter clean
flutter pub get
```

### Problèmes d'émulateur
```bash
flutter doctor --android-licenses
```

## Auteur

Développé en avril 2014 (thème du projet) avec les technologies modernes de 2025.

## Licence

Ce projet est développé à des fins éducatives.
