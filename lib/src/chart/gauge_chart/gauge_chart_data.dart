import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/animation.dart';

class GaugeChartData extends BaseChartData with EquatableMixin {
  final StrokeCap strokeCap;
  final double value;
  final double strokeWidth;
  final Color valueColor;
  final Color? backgroundColor;
  final double startAngle;
  final double endAngle;
  final GaugeTouchData gaugeTouchData;

  GaugeChartData({
    this.strokeCap = StrokeCap.butt,
    this.backgroundColor,
    required this.valueColor,
    required this.value,
    required this.strokeWidth,
    required this.startAngle,
    required this.endAngle,
    FlBorderData? borderData,
    GaugeTouchData? touchData,
  }) : gaugeTouchData = touchData ?? GaugeTouchData(),
        super(
          borderData: borderData,
          touchData: touchData ?? GaugeTouchData());

  GaugeChartData copyWith({
    StrokeCap? strokeCap,
    Color? backgroundColor,
    Color? valueColor,
    double? value,
    double? strokeWidth,
    double? startAngle,
    double? endAngle,
    FlBorderData? borderData,
    GaugeTouchData? gaugeTouchData,
  }) =>
      GaugeChartData(
        strokeCap: strokeCap ?? this.strokeCap,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        valueColor: valueColor ?? this.valueColor,
        value: value ?? this.value,
        strokeWidth: strokeWidth ?? this.strokeWidth,
        startAngle: startAngle ?? this.startAngle,
        endAngle: endAngle ?? this.endAngle,
        borderData: borderData ?? this.borderData,
        touchData: gaugeTouchData ?? this.gaugeTouchData,
      );


  @override
  GaugeChartData lerp(BaseChartData a, BaseChartData b, double t) {
    if (a is GaugeChartData && b is GaugeChartData) {
      return GaugeChartData(
        strokeCap: b.strokeCap,
        backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t),
        valueColor: Color.lerp(a.valueColor, b.valueColor, t)!,
        value: lerpDouble(a.value, b.value, t)!,
        strokeWidth: lerpDouble(a.strokeWidth, b.strokeWidth, t)!,
        startAngle: lerpDouble(a.startAngle, b.startAngle, t)!,
        endAngle: lerpDouble(a.endAngle, b.endAngle, t)!,
      );
    } else {
      throw Exception('Illegal State');
    }
  }

  @override
  List<Object?> get props => [
    strokeCap,
    backgroundColor,
    valueColor,
    value,
    strokeWidth,
    startAngle,
    endAngle,
  ];
}

class GaugeTouchData extends FlTouchData<GaugeTouchResponse> {
  GaugeTouchData({
    bool? enabled,
    BaseTouchCallback<GaugeTouchResponse>? touchCallback,
    MouseCursorResolver<GaugeTouchResponse>? mouseCursorResolver
  }) : super(enabled ?? true, touchCallback, mouseCursorResolver);

}

class GaugeTouchResponse extends BaseTouchResponse {
  GaugeTouchResponse(GaugeTouchedSpot? touchedSpot);
}

class GaugeTouchedSpot extends TouchedSpot with EquatableMixin {
  GaugeTouchedSpot(FlSpot spot, Offset offset) : super(spot, offset);
}

/// It lerps a [GaugeChartData] to another [GaugeChartData] (handles animation for updating values)
class GaugeChartDataTween extends Tween<GaugeChartData> {
  GaugeChartDataTween({
    required GaugeChartData begin,
    required GaugeChartData end,
  }) : super(begin: begin, end: end);

  /// Lerps a [GaugeChartData] based on [t] value, check [Tween.lerp].
  @override
  GaugeChartData lerp(double t) => begin!.lerp(begin!, end!, t);
}