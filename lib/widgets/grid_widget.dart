import 'package:flutter/material.dart';
import '../models/board.dart';

/// Widget to display the background grid
class GridWidget extends StatelessWidget {
  final double size;

  const GridWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final cellSize = (size - 60) / Board.size;

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFBBADA0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(Board.size, (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(Board.size, (col) {
              return Container(
                width: cellSize,
                height: cellSize,
                decoration: BoxDecoration(
                  color: const Color(0xFFCDC1B4),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
