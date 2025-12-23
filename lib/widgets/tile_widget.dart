import 'package:flutter/material.dart';
import '../models/tile.dart';

/// Widget to display a single tile with animation
class TileWidget extends StatefulWidget {
  final Tile tile;
  final double size;

  const TileWidget({
    super.key,
    required this.tile,
    required this.size,
  });

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.tile.isNew ? 0.0 : 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    if (widget.tile.isNew) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(TileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.tile.isMerged && !oldWidget.tile.isMerged) {
      _controller.reset();
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 1.1,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward().then((_) {
        _controller.reverse();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      left: widget.tile.col * (widget.size + 12) + 12,
      top: widget.tile.row * (widget.size + 12) + 12,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.tile.getBackgroundColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${widget.tile.value}',
              style: TextStyle(
                fontSize: widget.tile.getFontSize(),
                fontWeight: FontWeight.bold,
                color: widget.tile.getTextColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
