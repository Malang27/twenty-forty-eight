import 'package:flutter/material.dart';

/// Represents a single tile in the 2048 game
class Tile {
  int value;
  int row;
  int col;
  bool isNew;
  bool isMerged;

  // For animation purposes
  int? previousRow;
  int? previousCol;

  Tile({
    required this.value,
    required this.row,
    required this.col,
    this.isNew = false,
    this.isMerged = false,
    this.previousRow,
    this.previousCol,
  });

  /// Get the background color for this tile based on its value
  Color getBackgroundColor() {
    switch (value) {
      case 2:
        return const Color(0xFFEEE4DA);
      case 4:
        return const Color(0xFFEDE0C8);
      case 8:
        return const Color(0xFFF2B179);
      case 16:
        return const Color(0xFFF59563);
      case 32:
        return const Color(0xFFF67C5F);
      case 64:
        return const Color(0xFFF65E3B);
      case 128:
        return const Color(0xFFEDCF72);
      case 256:
        return const Color(0xFFEDCC61);
      case 512:
        return const Color(0xFFEDC850);
      case 1024:
        return const Color(0xFFEDC53F);
      case 2048:
        return const Color(0xFFEDC22E);
      default:
        return const Color(0xFF3C3A32);
    }
  }

  /// Get the text color for this tile based on its value
  Color getTextColor() {
    return value <= 4 ? const Color(0xFF776E65) : Colors.white;
  }

  /// Get the font size based on the value length
  double getFontSize() {
    if (value >= 1024) return 32.0;
    if (value >= 128) return 36.0;
    return 42.0;
  }

  /// Create a copy of this tile
  Tile copyWith({
    int? value,
    int? row,
    int? col,
    bool? isNew,
    bool? isMerged,
    int? previousRow,
    int? previousCol,
  }) {
    return Tile(
      value: value ?? this.value,
      row: row ?? this.row,
      col: col ?? this.col,
      isNew: isNew ?? this.isNew,
      isMerged: isMerged ?? this.isMerged,
      previousRow: previousRow ?? this.previousRow,
      previousCol: previousCol ?? this.previousCol,
    );
  }
}
