import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'samples/line_chart_sample1.dart';
import 'samples/line_chart_sample2.dart';

class LineChartPage extends StatelessWidget {
  const LineChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff262545),
      child: ListView(
        children: <Widget>[
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 36.0,
                top: 24,
              ),
              child: Text(
                'Line Chart',
                style: TextStyle(
                  color: Color(
                    0xff6f6f97,
                  ),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 28,
              right: 28,
            ),
            child: LineChartSample1(),
          ),
          const SizedBox(
            height: 22,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28),
            child: LineChartSample2(),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: 250,
                  height: 250,
                  child: GaugeChart(
                    GaugeChartData(
                      value: 0.2,
                      valueColor: VariableGaugeColor(
                        colors: [Colors.yellow, Colors.blue, Colors.red],
                        limits: [0.35, 0.5],
                      ),
                      backgroundColor: Colors.orange,
                      strokeWidth: 30,
                      startAngle: 45,
                      endAngle: -225,
                      strokeCap: StrokeCap.round,
                      ticks: const GaugeTicks(
                        count: 11,
                        color: Colors.grey,
                        radius: 5,
                        position: GaugeTickPosition.inner,
                        margin: 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}