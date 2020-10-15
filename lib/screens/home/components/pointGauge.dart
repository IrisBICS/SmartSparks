import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:smartsparks/shared/constants.dart';

class PointGauge extends StatelessWidget {

  final String label;
  final int val;
  final int min;
  final int max;

  PointGauge({this.min, this.max, this.val, this.label});

  @override
  Widget build(BuildContext context) {
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
                  minimum: min.toDouble(),
                  maximum: max.toDouble(),
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
                      color: yellow,
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