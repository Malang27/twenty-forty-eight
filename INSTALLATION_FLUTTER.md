# Guide d'Installation de Flutter sur Windows

## Étape 1: Télécharger Flutter SDK

1. Visitez le site officiel: https://docs.flutter.dev/get-started/install/windows
2. Cliquez sur le bouton de téléchargement du Flutter SDK (environ 1-2 GB)
3. Sauvegardez le fichier ZIP sur votre ordinateur

## Étape 2: Extraire Flutter

1. Créez un dossier permanent pour Flutter (par exemple: `C:\src`)
2. Extrayez le contenu du ZIP dans ce dossier
3. Vous devriez avoir un chemin comme: `C:\src\flutter`

**IMPORTANT**: N'installez PAS Flutter dans:
- `C:\Program Files` (nécessite des privilèges administrateur)
- Un dossier temporaire
- Un dossier avec des espaces dans le nom

## Étape 3: Ajouter Flutter au PATH

### Méthode Graphique:

1. Clic droit sur "Ce PC" ou "Ordinateur" → "Propriétés"
2. Cliquez sur "Paramètres système avancés"
3. Cliquez sur "Variables d'environnement"
4. Dans "Variables utilisateur", trouvez la variable "Path" et cliquez sur "Modifier"
5. Cliquez sur "Nouveau"
6. Ajoutez: `C:\src\flutter\bin` (adaptez selon votre chemin)
7. Cliquez sur "OK" pour tout fermer

### Méthode PowerShell (Alternative):

Ouvrez PowerShell en tant qu'administrateur et exécutez:
```powershell
$env:Path += ";C:\src\flutter\bin"
[Environment]::SetEnvironmentVariable("Path", $env:Path, "User")
```

## Étape 4: Vérifier l'Installation

1. **Fermez tous les terminaux ouverts** (important!)
2. Ouvrez un nouveau terminal ou PowerShell
3. Exécutez:
```bash
flutter doctor
```

Vous devriez voir une sortie similaire à:
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x, on Microsoft Windows...)
[!] Android toolchain - develop for Android devices
[!] Chrome - develop for the web
[!] Visual Studio - develop for Windows
[!] Android Studio (not installed)
[!] VS Code (version x.x.x)
[✓] Connected device (1 available)
```

## Étape 5: Installer Android Studio (pour développer sur Android)

1. Téléchargez Android Studio: https://developer.android.com/studio
2. Installez Android Studio avec les paramètres par défaut
3. Lors du premier lancement, suivez l'assistant pour installer:
   - Android SDK
   - Android SDK Platform
   - Android Virtual Device (AVD)

4. Acceptez les licences Android:
```bash
flutter doctor --android-licenses
```
Tapez `y` pour accepter toutes les licences

## Étape 6: Configurer un Émulateur

### Dans Android Studio:

1. Ouvrez Android Studio
2. Cliquez sur "More Actions" → "Virtual Device Manager"
3. Cliquez sur "Create Device"
4. Sélectionnez un appareil (ex: Pixel 5)
5. Sélectionnez une image système (ex: Android 13)
6. Cliquez sur "Finish"

## Étape 7: Installer les Dépendances du Projet

1. Ouvrez un terminal dans le dossier du projet:
```bash
cd c:\Users\lomao\Desktop\twenty-forty-eight
```

2. Installez les dépendances:
```bash
flutter pub get
```

## Étape 8: Exécuter le Projet

### Option A: Sur un Émulateur

1. Démarrez l'émulateur depuis Android Studio
2. Dans le terminal du projet, exécutez:
```bash
flutter run
```

### Option B: Sur votre Téléphone Android

1. Sur votre téléphone:
   - Allez dans Paramètres → À propos du téléphone
   - Tapez 7 fois sur "Numéro de build" pour activer le mode développeur
   - Retournez aux Paramètres → Options pour développeurs
   - Activez "Débogage USB"

2. Connectez votre téléphone à l'ordinateur via USB

3. Vérifiez que l'appareil est détecté:
```bash
flutter devices
```

4. Lancez l'application:
```bash
flutter run
```

## Commandes Utiles

```bash
# Vérifier l'état de Flutter
flutter doctor

# Vérifier les appareils connectés
flutter devices

# Installer les dépendances
flutter pub get

# Nettoyer le projet
flutter clean

# Compiler en mode release (APK)
flutter build apk --release

# Mettre à jour Flutter
flutter upgrade

# Voir les logs en temps réel
flutter logs
```

## Dépannage

### "flutter: command not found" ou "flutter n'est pas reconnu"
- Vérifiez que Flutter est bien dans le PATH
- Fermez et rouvrez votre terminal
- Redémarrez votre ordinateur si nécessaire

### Erreur de licences Android
```bash
flutter doctor --android-licenses
```

### Problèmes de connexion réseau
Si le téléchargement de Flutter échoue, utilisez un VPN ou téléchargez depuis un miroir.

### L'émulateur ne démarre pas
- Vérifiez que la virtualisation est activée dans le BIOS
- Installez Intel HAXM (pour processeurs Intel)
- Ou AMD Hypervisor (pour processeurs AMD)

### Version de Flutter
Ce projet nécessite Flutter SDK 3.0.0 ou supérieur.

## Support

Pour plus d'aide:
- Documentation officielle: https://docs.flutter.dev
- Flutter sur GitHub: https://github.com/flutter/flutter
- Stack Overflow: https://stackoverflow.com/questions/tagged/flutter

## Prochaines Étapes

Une fois Flutter installé et le projet en cours d'exécution:
1. Explorez le code dans `lib/`
2. Modifiez les couleurs, animations, ou fonctionnalités
3. Testez sur différents appareils
4. Compilez une version release pour la distribution

Bon développement! 🚀
