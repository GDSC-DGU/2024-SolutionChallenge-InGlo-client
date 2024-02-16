/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Renders the gauge range pointer sample
class RangePointerExample extends StatefulWidget {
  /// Creates the gauge range pointer sample
  const RangePointerExample({Key? key}) : super(key: key);

  @override
  _RangePointerExampleState createState() => _RangePointerExampleState();
}

class _RangePointerExampleState extends State {
  _RangePointerExampleState();

  @override
  Widget build(BuildContext context) {
    return _buildRangePointerExampleGauge();
  }

  /// Returns the range pointer gauge
  SfRadialGauge _buildRangePointerExampleGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 1.45,
            axisLineStyle: const AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor, thickness: 0.25),
            pointers: const <GaugePointer>[
              RangePointer(
                  value: 50,
                  cornerStyle: CornerStyle.bothCurve,
                  enableAnimation: true,
                  animationDuration: 1200,
                  sizeUnit: GaugeSizeUnit.factor,
                  gradient: SweepGradient(
                      colors: <Color>[Color(0xFF6A6EF6), Color(0xFFDB82F5)],
                      stops: <double>[0.25, 0.75]),
                  color: Color(0xFF00A8B5),
                  width: 0.25),
            ]),
      ],
    );
  }
}