import 'package:flutter/material.dart';
import 'dart:math';

import 'LiquidWater_indicator.dart';

// (WaterTankPainter ক্লাস আগের মতো থাকবে)

class WaterTankWidget extends StatefulWidget {
  final double waterLevel; // 0.0 থেকে 1.0 এর মধ্যে

  const WaterTankWidget({Key? key, required this.waterLevel}) : super(key: key);

  @override
  State<WaterTankWidget> createState() => _WaterTankWidgetState();
}

class _WaterTankWidgetState extends State<WaterTankWidget> with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();  // বার বার চলবে ওয়েভ অ্যানিমেশন
  }


  @override
  void dispose() {
    _waveController.dispose();  // মেমরি লিক এড়াতে ডিসপোজ করো
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaterTankPainter(
        waterLevel: widget.waterLevel,
        waveAnimation: _waveController,
      ),
      child: Container(
        width: 350,
        height: 400,
      ),
    );
  }
}
