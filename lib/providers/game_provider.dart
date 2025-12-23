import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/board.dart';

/// Manages the game state and notifies listeners of changes
class GameProvider with ChangeNotifier {
  late Board _board;
  int _bestScore = 0;
  bool _isAnimating = false;

  GameProvider() {
    _board = Board();
    _loadBestScore();
    _board.initialize();
  }

  Board get board => _board;
  int get bestScore => _bestScore;
  bool get isAnimating => _isAnimating;

  /// Load the best score from SharedPreferences
  Future<void> _loadBestScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _bestScore = prefs.getInt('best_score') ?? 0;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading best score: $e');
    }
  }

  /// Save the best score to SharedPreferences
  Future<void> _saveBestScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('best_score', _bestScore);
    } catch (e) {
      debugPrint('Error saving best score: $e');
    }
  }

  /// Update best score if current score is higher
  void _updateBestScore() {
    if (_board.score > _bestScore) {
      _bestScore = _board.score;
      _saveBestScore();
    }
  }

  /// Move tiles in the specified direction
  Future<void> move(Direction direction) async {
    if (_isAnimating || !_board.canMove()) return;

    _isAnimating = true;
    notifyListeners();

    bool moved = _board.move(direction);

    if (moved) {
      _updateBestScore();

      // Wait for animation to complete
      await Future.delayed(const Duration(milliseconds: 150));
    }

    _isAnimating = false;
    notifyListeners();
  }

  /// Reset the game
  void resetGame() {
    _board.initialize();
    notifyListeners();
  }

  /// Continue playing after winning
  void continueGame() {
    _board.hasWon = false;
    notifyListeners();
  }
}
