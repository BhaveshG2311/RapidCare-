import 'package:flutter/material.dart';

class PulseBackground extends StatefulWidget {
  final Widget? child;
  final Color pulseColor;
  final bool animate;

  const PulseBackground({
    super.key,
    this.child,
    this.pulseColor = const Color(0xFFBA1A1A),
    this.animate = true,
  });

  @override
  State<PulseBackground> createState() => _PulseBackgroundState();
}

class _PulseBackgroundState extends State<PulseBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant PulseBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _PulsePainter(
            animationValue: _controller.value,
            pulseColor: widget.pulseColor,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class _PulsePainter extends CustomPainter {
  final double animationValue;
  final Color pulseColor;

  _PulsePainter({
    required this.animationValue,
    required this.pulseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Background radial glow
    final radialPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          pulseColor.withOpacity(0.06),
          pulseColor.withOpacity(0.01),
          Colors.transparent,
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));
    canvas.drawCircle(center, maxRadius, radialPaint);

    // Dynamic concentric pulsing rings
    final ringPaint = Paint()
      ..color = pulseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 0; i < 3; i++) {
      // Offset each ring's start phase
      double progress = (animationValue + i / 3.0) % 1.0;
      double radius = maxRadius * 0.3 + (maxRadius * 0.7 * progress);
      double opacity = (1.0 - progress) * 0.35;

      ringPaint.color = pulseColor.withOpacity(opacity);
      canvas.drawCircle(center, radius, ringPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.pulseColor != pulseColor;
  }
}
