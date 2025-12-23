import 'dart:math';
import 'tile.dart';

/// Represents the game board and handles all game logic
class Board {
  static const int size = 4;
  List<Tile> tiles = [];
  int score = 0;
  bool hasWon = false;
  bool hasLost = false;

  final Random _random = Random();

  /// Initialize the board with 2-4 random tiles
  void initialize() {
    tiles.clear();
    score = 0;
    hasWon = false;
    hasLost = false;

    // Add 3-4 initial tiles
    int initialTiles = 3 + _random.nextInt(2); // 3 or 4
    for (int i = 0; i < initialTiles; i++) {
      _addRandomTile();
    }
  }

  /// Add a new random tile (90% chance of 2, 10% chance of 4)
  void _addRandomTile() {
    List<Map<String, int>> emptyCells = [];

    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        if (!_isCellOccupied(row, col)) {
          emptyCells.add({'row': row, 'col': col});
        }
      }
    }

    if (emptyCells.isEmpty) return;

    var randomCell = emptyCells[_random.nextInt(emptyCells.length)];
    int value = _random.nextDouble() < 0.9 ? 2 : 4;

    tiles.add(Tile(
      value: value,
      row: randomCell['row']!,
      col: randomCell['col']!,
      isNew: true,
    ));
  }

  /// Check if a cell is occupied by a tile
  bool _isCellOccupied(int row, int col) {
    return tiles.any((tile) => tile.row == row && tile.col == col);
  }

  /// Get the tile at a specific position
  Tile? _getTileAt(int row, int col) {
    try {
      return tiles.firstWhere((tile) => tile.row == row && tile.col == col);
    } catch (e) {
      return null;
    }
  }

  /// Move tiles in the specified direction
  /// Returns true if any tile moved
  bool move(Direction direction) {
    // Store previous state for animation
    for (var tile in tiles) {
      tile.previousRow = tile.row;
      tile.previousCol = tile.col;
      tile.isMerged = false;
      tile.isNew = false;
    }

    bool moved = false;
    List<Tile> mergedTiles = [];

    switch (direction) {
      case Direction.up:
        moved = _moveUp(mergedTiles);
        break;
      case Direction.down:
        moved = _moveDown(mergedTiles);
        break;
      case Direction.left:
        moved = _moveLeft(mergedTiles);
        break;
      case Direction.right:
        moved = _moveRight(mergedTiles);
        break;
    }

    if (moved) {
      // Remove merged tiles
      tiles.removeWhere((tile) => mergedTiles.contains(tile));

      // Add new tile after move
      _addRandomTile();

      // Check win/loss conditions
      _checkWinCondition();
      _checkLossCondition();
    }

    return moved;
  }

  bool _moveUp(List<Tile> mergedTiles) {
    bool moved = false;

    for (int col = 0; col < size; col++) {
      List<Tile> column = [];

      // Collect tiles in this column from top to bottom
      for (int row = 0; row < size; row++) {
        Tile? tile = _getTileAt(row, col);
        if (tile != null) {
          column.add(tile);
        }
      }

      // Merge and move tiles
      int targetRow = 0;
      for (int i = 0; i < column.length; i++) {
        Tile tile = column[i];

        // Check if can merge with next tile
        if (i + 1 < column.length && tile.value == column[i + 1].value) {
          tile.row = targetRow;
          tile.value *= 2;
          tile.isMerged = true;
          score += tile.value;

          mergedTiles.add(column[i + 1]);
          i++; // Skip next tile as it was merged
          moved = true;

          // Check for 2048
          if (tile.value == 2048) {
            hasWon = true;
          }
        } else {
          tile.row = targetRow;
          if (tile.previousRow != targetRow) {
            moved = true;
          }
        }

        targetRow++;
      }
    }

    return moved;
  }

  bool _moveDown(List<Tile> mergedTiles) {
    bool moved = false;

    for (int col = 0; col < size; col++) {
      List<Tile> column = [];

      // Collect tiles in this column from bottom to top
      for (int row = size - 1; row >= 0; row--) {
        Tile? tile = _getTileAt(row, col);
        if (tile != null) {
          column.add(tile);
        }
      }

      // Merge and move tiles
      int targetRow = size - 1;
      for (int i = 0; i < column.length; i++) {
        Tile tile = column[i];

        // Check if can merge with next tile
        if (i + 1 < column.length && tile.value == column[i + 1].value) {
          tile.row = targetRow;
          tile.value *= 2;
          tile.isMerged = true;
          score += tile.value;

          mergedTiles.add(column[i + 1]);
          i++; // Skip next tile as it was merged
          moved = true;

          if (tile.value == 2048) {
            hasWon = true;
          }
        } else {
          tile.row = targetRow;
          if (tile.previousRow != targetRow) {
            moved = true;
          }
        }

        targetRow--;
      }
    }

    return moved;
  }

  bool _moveLeft(List<Tile> mergedTiles) {
    bool moved = false;

    for (int row = 0; row < size; row++) {
      List<Tile> rowTiles = [];

      // Collect tiles in this row from left to right
      for (int col = 0; col < size; col++) {
        Tile? tile = _getTileAt(row, col);
        if (tile != null) {
          rowTiles.add(tile);
        }
      }

      // Merge and move tiles
      int targetCol = 0;
      for (int i = 0; i < rowTiles.length; i++) {
        Tile tile = rowTiles[i];

        // Check if can merge with next tile
        if (i + 1 < rowTiles.length && tile.value == rowTiles[i + 1].value) {
          tile.col = targetCol;
          tile.value *= 2;
          tile.isMerged = true;
          score += tile.value;

          mergedTiles.add(rowTiles[i + 1]);
          i++; // Skip next tile as it was merged
          moved = true;

          if (tile.value == 2048) {
            hasWon = true;
          }
        } else {
          tile.col = targetCol;
          if (tile.previousCol != targetCol) {
            moved = true;
          }
        }

        targetCol++;
      }
    }

    return moved;
  }

  bool _moveRight(List<Tile> mergedTiles) {
    bool moved = false;

    for (int row = 0; row < size; row++) {
      List<Tile> rowTiles = [];

      // Collect tiles in this row from right to left
      for (int col = size - 1; col >= 0; col--) {
        Tile? tile = _getTileAt(row, col);
        if (tile != null) {
          rowTiles.add(tile);
        }
      }

      // Merge and move tiles
      int targetCol = size - 1;
      for (int i = 0; i < rowTiles.length; i++) {
        Tile tile = rowTiles[i];

        // Check if can merge with next tile
        if (i + 1 < rowTiles.length && tile.value == rowTiles[i + 1].value) {
          tile.col = targetCol;
          tile.value *= 2;
          tile.isMerged = true;
          score += tile.value;

          mergedTiles.add(rowTiles[i + 1]);
          i++; // Skip next tile as it was merged
          moved = true;

          if (tile.value == 2048) {
            hasWon = true;
          }
        } else {
          tile.col = targetCol;
          if (tile.previousCol != targetCol) {
            moved = true;
          }
        }

        targetCol--;
      }
    }

    return moved;
  }

  void _checkWinCondition() {
    for (var tile in tiles) {
      if (tile.value == 2048) {
        hasWon = true;
        break;
      }
    }
  }

  void _checkLossCondition() {
    // Check if board is full
    if (tiles.length < size * size) {
      hasLost = false;
      return;
    }

    // Check if any adjacent tiles can be merged
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        Tile? current = _getTileAt(row, col);
        if (current == null) continue;

        // Check right neighbor
        if (col < size - 1) {
          Tile? right = _getTileAt(row, col + 1);
          if (right != null && current.value == right.value) {
            hasLost = false;
            return;
          }
        }

        // Check bottom neighbor
        if (row < size - 1) {
          Tile? bottom = _getTileAt(row + 1, col);
          if (bottom != null && current.value == bottom.value) {
            hasLost = false;
            return;
          }
        }
      }
    }

    hasLost = true;
  }

  /// Check if any move is possible
  bool canMove() {
    return !hasLost;
  }
}

enum Direction {
  up,
  down,
  left,
  right,
}
