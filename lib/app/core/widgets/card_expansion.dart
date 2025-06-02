import 'package:flutter/material.dart';

class CardExpansion extends StatefulWidget {
  final Widget title;
  final Widget child;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Duration animationDuration;

  const CardExpansion({
    super.key,
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
    this.margin,
    this.padding,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<CardExpansion> createState() => _CardExpansionState();
}

class _CardExpansionState extends State<CardExpansion>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
      value: _expanded ? 1.0 : 0.0,
    );
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: widget.margin ??
          const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Column(
        children: [
          ListTile(
            contentPadding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: widget.title,
            trailing: RotationTransition(
              turns: _iconTurns,
              child: const Icon(Icons.expand_more),
            ),
            onTap: _handleTap,
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: widget.child,
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: widget.animationDuration,
            firstCurve: Curves.easeIn,
            secondCurve: Curves.easeOut,
          ),
        ],
      ),
    );
  }
}
