# Guide de Démarrage Rapide - 2048 Flutter

## Vous avez déjà Flutter installé?

Si Flutter est déjà installé sur votre machine, suivez ces étapes simples:

### 1. Vérifier Flutter
```bash
flutter --version
```

Si cette commande fonctionne, passez à l'étape 2. Sinon, consultez [INSTALLATION_FLUTTER.md](INSTALLATION_FLUTTER.md).

### 2. Installer les Dépendances
```bash
cd c:\Users\lomao\Desktop\twenty-forty-eight
flutter pub get
```

### 3. Vérifier la Configuration
```bash
flutter doctor
```

### 4. Lancer l'Application

**Sur émulateur:**
```bash
flutter run
```

**Sur téléphone physique:**
1. Activez le mode développeur et le débogage USB
2. Connectez le téléphone
3. Exécutez: `flutter run`

---

## Vous n'avez PAS Flutter?

### Option 1: Installation Complète (Recommandée)

Suivez le guide complet: [INSTALLATION_FLUTTER.md](INSTALLATION_FLUTTER.md)

Temps estimé: 30-60 minutes (selon votre connexion Internet)

### Option 2: Tester en Ligne (Temporaire)

Vous pouvez tester le code Flutter en ligne sur:
- **DartPad**: https://dartpad.dev
- **FlutLab**: https://flutlab.io
- **Zapp**: https://zapp.run

**Limitation**: Ces plateformes en ligne ont des limitations et ne supportent pas toutes les fonctionnalités (comme SharedPreferences).

---

## Structure du Projet

```
twenty-forty-eight/
├── lib/
│   ├── main.dart                    # Point d'entrée
│   ├── models/
│   │   ├── tile.dart               # Modèle de tuile
│   │   └── board.dart              # Logique du jeu
│   ├── providers/
│   │   └── game_provider.dart      # Gestion d'état
│   ├── screens/
│   │   └── game_screen.dart        # Écran principal
│   └── widgets/
│       ├── grid_widget.dart        # Grille de fond
│       └── tile_widget.dart        # Widget tuile
├── pubspec.yaml                     # Dépendances
├── README.md                        # Documentation complète
├── INSTALLATION_FLUTTER.md          # Guide d'installation
└── QUICK_START.md                  # Ce fichier
```

---

## Fonctionnalités Implémentées

✅ Grille 4x4
✅ 3-4 tuiles initiales aléatoires
✅ Contrôles tactiles (swipe)
✅ Animations fluides
✅ Fusion de tuiles
✅ Système de score
✅ Meilleur score (sauvegarde locale)
✅ Détection de fin de partie
✅ Bouton "Nouvelle partie"
✅ Message de victoire (2048)
✅ Design responsive

---

## Commandes Essentielles

```bash
# Vérifier Flutter
flutter doctor

# Voir les appareils disponibles
flutter devices

# Installer les dépendances
flutter pub get

# Lancer en mode debug
flutter run

# Lancer en mode release
flutter run --release

# Compiler un APK
flutter build apk --release

# Nettoyer le projet
flutter clean

# Analyser le code
flutter analyze

# Voir les logs
flutter logs
```

---

## Modification du Code

### Changer les Couleurs des Tuiles

Modifiez [lib/models/tile.dart](lib/models/tile.dart:19) dans la méthode `getBackgroundColor()`.

### Ajuster les Animations

Modifiez les durées dans:
- [lib/widgets/tile_widget.dart](lib/widgets/tile_widget.dart:25) (animation de tuile)
- [lib/screens/game_screen.dart](lib/screens/game_screen.dart) (swipe detection)
- [lib/providers/game_provider.dart](lib/providers/game_provider.dart:51) (délai d'animation)

### Modifier la Taille de la Grille

Pour une grille 5x5 ou 6x6, modifiez la constante `size` dans [lib/models/board.dart](lib/models/board.dart:8).

---

## Déploiement

### Android (APK)
```bash
flutter build apk --release
```
Fichier généré: `build/app/outputs/flutter-apk/app-release.apk`

### Android (App Bundle - Google Play)
```bash
flutter build appbundle --release
```

### iOS (nécessite un Mac)
```bash
flutter build ios --release
```

---

## Problèmes Courants

### "flutter: command not found"
Flutter n'est pas installé ou pas dans le PATH. Voir [INSTALLATION_FLUTTER.md](INSTALLATION_FLUTTER.md).

### "No devices found"
- Démarrez un émulateur Android
- Ou connectez un téléphone physique avec le débogage USB activé

### "Waiting for another flutter command to release the startup lock"
```bash
flutter clean
```

### Erreur de build
```bash
flutter clean
flutter pub get
flutter run
```

---

## Améliorations Possibles

Vous pouvez améliorer le jeu en ajoutant:

- 🔊 Effets sonores (utilisez `audioplayers` package)
- 🎵 Musique de fond
- 🌙 Mode sombre
- 🌍 Multi-langue (i18n)
- 📊 Historique des parties
- 🏆 Achievements
- 📱 Support mode paysage
- ⚙️ Paramètres (son, difficulté, thème)
- 🔄 Bouton "Annuler" (undo)

---

## Ressources

- **Documentation Flutter**: https://docs.flutter.dev
- **Packages Dart**: https://pub.dev
- **Flutter Cookbook**: https://docs.flutter.dev/cookbook
- **Awesome Flutter**: https://github.com/Solido/awesome-flutter

---

## Support

En cas de problème:
1. Consultez [README.md](README.md) pour plus de détails
2. Consultez [INSTALLATION_FLUTTER.md](INSTALLATION_FLUTTER.md) pour l'installation
3. Vérifiez les logs: `flutter logs`
4. Nettoyez le projet: `flutter clean && flutter pub get`

---

**Bon développement! 🎮🚀**
