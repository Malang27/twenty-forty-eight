import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/board.dart';
import '../providers/game_provider.dart';
import '../widgets/grid_widget.dart';
import '../widgets/tile_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // For swipe detection
  Offset? _startPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<GameProvider>(
          builder: (context, gameProvider, child) {
            return Column(
              children: [
                _buildHeader(gameProvider),
                const SizedBox(height: 20),
                _buildGameBoard(gameProvider),
                const SizedBox(height: 20),
                _buildInstructions(),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(GameProvider gameProvider) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '2048',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF776E65),
                    ),
                  ),
                  const Text(
                    'Join the tiles!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF776E65),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildScoreBox(
                    'SCORE',
                    gameProvider.board.score,
                  ),
                  const SizedBox(width: 10),
                  _buildScoreBox(
                    'BEST',
                    gameProvider.bestScore,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showRestartDialog(gameProvider),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8F7A66),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'NEW GAME',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBox(String label, int score) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFBBADA0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEEE4DA),
            ),
          ),
          Text(
            '$score',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameBoard(GameProvider gameProvider) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boardSize = screenWidth - 40.0;
    final cellSize = (boardSize - 60) / Board.size;

    return Center(
      child: GestureDetector(
        onPanStart: (details) {
          _startPosition = details.localPosition;
        },
        onPanEnd: (details) {
          if (_startPosition == null) return;

          final dx = details.velocity.pixelsPerSecond.dx;
          final dy = details.velocity.pixelsPerSecond.dy;

          if (dx.abs() > dy.abs()) {
            // Horizontal swipe
            if (dx > 0) {
              gameProvider.move(Direction.right);
            } else {
              gameProvider.move(Direction.left);
            }
          } else {
            // Vertical swipe
            if (dy > 0) {
              gameProvider.move(Direction.down);
            } else {
              gameProvider.move(Direction.up);
            }
          }

          _startPosition = null;
        },
        child: Container(
          width: boardSize,
          height: boardSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              GridWidget(size: boardSize),
              ...gameProvider.board.tiles.map((tile) {
                return TileWidget(
                  key: ValueKey('${tile.row}-${tile.col}-${tile.value}'),
                  tile: tile,
                  size: cellSize,
                );
              }),
              if (gameProvider.board.hasWon)
                _buildGameOverlay(
                  'You Win!',
                  'Congratulations!',
                  gameProvider,
                  showContinue: true,
                ),
              if (gameProvider.board.hasLost)
                _buildGameOverlay(
                  'Game Over!',
                  'No more moves',
                  gameProvider,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverlay(
    String title,
    String message,
    GameProvider gameProvider, {
    bool showContinue = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFFEDC22E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              if (showContinue)
                ElevatedButton(
                  onPressed: () => gameProvider.continueGame(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8F7A66),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Keep playing',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => gameProvider.resetGame(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8F7A66),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Try again',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Color(0xFFEEE4DA),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HOW TO PLAY:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF776E65),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Swipe to move tiles. When two tiles with the same number touch, they merge into one!',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF776E65),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRestartDialog(GameProvider gameProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Game'),
        content: const Text('Are you sure you want to start a new game?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              gameProvider.resetGame();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8F7A66),
            ),
            child: const Text(
              'New Game',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
