import 'dart:math';
import 'package:flutter/material.dart';

class WaterTankPainter extends CustomPainter {
  final double waterLevel; // 0.0 to 1.0
  final Animation<double> waveAnimation;

  WaterTankPainter({required this.waterLevel, required this.waveAnimation}) : super(repaint: waveAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // ট্যাংকের আউটলাইন (Rectangular with rounded top)
    final tankRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = Radius.circular(20);
    final path = Path()
      ..moveTo(tankRect.left + radius.x, tankRect.top)
      ..lineTo(tankRect.right - radius.x, tankRect.top)
      ..quadraticBezierTo(tankRect.right, tankRect.top, tankRect.right, tankRect.top + radius.y)
      ..lineTo(tankRect.right, tankRect.bottom)
      ..lineTo(tankRect.left, tankRect.bottom)
      ..lineTo(tankRect.left, tankRect.top + radius.y)
      ..quadraticBezierTo(tankRect.left, tankRect.top, tankRect.left + radius.x, tankRect.top);
    canvas.drawPath(path, paint);

    // পানি উচ্চতা হিসাব
    final waterHeight = size.height * (1 - waterLevel);

    // পানি আঁকা (wave shape সহ)
    final waterPaint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final wavePath = Path();
    final waveHeight = 10.0;
    final waveLength = size.width;

    wavePath.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      double y = waterHeight + sin((x / waveLength * 2 * pi) + (waveAnimation.value * 2 * pi)) * waveHeight;
      wavePath.lineTo(x, y);
    }

    wavePath.lineTo(size.width, size.height);
    wavePath.close();

    // পানি ট্যাংকের ভিতরে ক্লিপ করা
    canvas.clipPath(path);
    canvas.drawPath(wavePath, waterPaint);

    // পানি সurface লাইন
    final linePaint = Paint()
      ..color = Colors.blueAccent.shade700
      ..strokeWidth = 2;
    canvas.drawLine(Offset(0, waterHeight), Offset(size.width, waterHeight), linePaint);
  }

  @override
  bool shouldRepaint(covariant WaterTankPainter oldDelegate) {
    return oldDelegate.waterLevel != waterLevel || oldDelegate.waveAnimation != waveAnimation;
  }
}
