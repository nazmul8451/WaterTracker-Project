import 'package:digitawatertracker/feature/LiquidWater_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'feature/custom_Paint.dart';


class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _WaterPumpAdvancedPageState();
}

class _WaterPumpAdvancedPageState extends State<UserScreen> {
  double waterLevel = 0.1; // 60%
  bool motorOn = false;
  bool autoMode = true;
  int motorRunningSeconds = 0;

  void toggleMotor() {
    setState(() {
      motorOn = !motorOn;
      if (motorOn) motorRunningSeconds = 0;
    });
  }

  void toggleAutoMode(bool value) {
    setState(() {
      autoMode = value;
    });
  }




  @override
  Widget build(BuildContext context) {

    String getEstimatedTime() {
      const totalLiters = 200; // মোট ট্যাংকের ধারণক্ষমতা
      final currentLiters = (waterLevel * totalLiters);
      double litersPerMinute = 5; // ধরলাম প্রতি মিনিটে 5 লিটার flow হয়

      if (motorOn) {
        final litersToFill = totalLiters - currentLiters;
        final minutesToFill = litersToFill / litersPerMinute;
        return "Full in: ${minutesToFill.toStringAsFixed(1)} min";
      } else {
        final minutesToEmpty = currentLiters / litersPerMinute;
        return "Empty in: ${minutesToEmpty.toStringAsFixed(1)} min";
      }
    }

    final tankCapacityLiters = 200; // Example tank size
    final currentLiters = (waterLevel * tankCapacityLiters).toInt();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Water Tank Monitor',style: TextStyle(
          color: Colors.blue,
        ),),
        actions: [
          Icon(Icons.wifi, color: Colors.green),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Animated Circular Water Level Indicator
            Stack(
              alignment: Alignment.center,
              children: [
                WaterTankWidget(waterLevel: waterLevel), // <-- THIS WILL ANIMATE WATER
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${(waterLevel * 100).toInt()}%', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                    Text('$currentLiters L', style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Motor Control & Mode
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: motorOn || autoMode ? null : toggleMotor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: motorOn ? Colors.green : Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(motorOn ? 'Motor ON' : 'Motor OFF', style: TextStyle(fontSize: 18)),
                ),
                Column(
                  children: [
                    Text('Auto Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                    Switch(
                      value: autoMode,
                      onChanged: toggleAutoMode,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Motor Running Time
            Text(
              motorOn ? 'Motor Running Time: ${motorRunningSeconds}s' : 'Motor is Off',
              style: const TextStyle(fontSize: 16),
            ),

            Text(
              getEstimatedTime(),
              style: TextStyle(fontSize: 16, color: Colors.deepPurple),
            ),

            const SizedBox(height: 20),

            // Alerts Example
            if (waterLevel < 0.15)
              Container(
                width: 400,
                padding: EdgeInsets.all(12),
                color: Colors.red[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning, color: Colors.red[900]),
                    SizedBox(width: 10),
                    Text('Warning: Water Level Low!', style: TextStyle(color: Colors.red[900])),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
