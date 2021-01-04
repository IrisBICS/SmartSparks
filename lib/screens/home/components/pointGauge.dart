import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:smartsparks/shared/constants.dart';

class PointGauge extends StatelessWidget {

  final String label;
  final int val;

  PointGauge({this.val, this.label});

  final List<int> ranges = [0, 10, 200, 500, 1000];
  final List<Color> colors = [blue, green, yellow, orange, red];

  Map<String, dynamic> _getRangeAndColor(points) {
    for (var i = 0; i < ranges.length - 1; i++) {
      if (points < ranges[i + 1]) {
        return {
          "min": ranges[i], 
          "max": ranges[i + 1],
          "color": colors[i]
        };
      }
    }
    return {
      "min": 999,
      "max": points,
      "color": colors.last,
    };
  }

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> rangeAndColor = _getRangeAndColor(val);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              label,
              style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 150,
            width: 150,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: rangeAndColor["min"].toDouble(),
                  maximum: rangeAndColor["max"].toDouble(),
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.2,
                    cornerStyle: CornerStyle.bothCurve,
                    color: yellow.withAlpha(80),
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: val.toDouble(),
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: rangeAndColor["color"],
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      positionFactor: 0.1,
                      angle: 90,
                      widget: Text(
                        val.toString(),
                        style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
                      )
                    ) 
                  ]
                )
              ]
            ),
          ),
        ]
      ),
    );
  }
}