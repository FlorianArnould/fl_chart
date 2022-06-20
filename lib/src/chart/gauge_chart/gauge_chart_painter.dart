import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/src/chart/base/base_chart/base_chart_painter.dart';
import 'package:fl_chart/src/chart/gauge_chart/gauge_chart_data.dart';
import 'package:fl_chart/src/utils/canvas_wrapper.dart';
import 'package:fl_chart/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GaugeChartPainter extends BaseChartPainter<GaugeChartData> {
  late Paint _backgroundPaint, _valuePaint;

  GaugeChartPainter() : super() {
    _backgroundPaint = Paint()
      ..isAntiAlias = true;
    _valuePaint = Paint()
      ..isAntiAlias = true;
  }

  @override
  void paint(BuildContext context, CanvasWrapper canvasWrapper,
      PaintHolder<GaugeChartData> holder) {
    super.paint(context, canvasWrapper, holder);
    final data = holder.data;

    drawValue(canvasWrapper, holder);
  }

  @visibleForTesting
  void drawValue(CanvasWrapper canvasWrapper,
      PaintHolder<GaugeChartData> holder) {
    final data = holder.data;
    var size = Size.square(
      canvasWrapper.size.shortestSide - data.strokeWidth,
    );
    final demiStroke = data.strokeWidth / 2;
    var offset = Offset(
      max(canvasWrapper.size.width - canvasWrapper.size.height, 0) / 2 + demiStroke,
      max(canvasWrapper.size.height - canvasWrapper.size.width, 0) / 2 + demiStroke,
    );
    final backgroundColor = data.backgroundColor;

    final angleRange = data.endAngle - data.startAngle;

    for(var i = 0; i < 3; i++) {
      /// Draw background if needed
      if(backgroundColor != null) {
        _backgroundPaint
          ..color = backgroundColor
          ..strokeWidth = data.strokeWidth
          ..strokeCap = data.strokeCap
          ..style = PaintingStyle.stroke;
        canvasWrapper.drawArc(
          offset & size,
          Utils().radians(data.startAngle),
          Utils().radians(angleRange),
          false,
          _backgroundPaint,
        );
      }

      /// Draw value
      _valuePaint
        ..color = data.valueColor
        ..strokeWidth = data.strokeWidth
        ..strokeCap = data.strokeCap
        ..style = PaintingStyle.stroke;
      canvasWrapper.drawArc(
        offset & size,
        Utils().radians(data.startAngle),
        Utils().radians(angleRange * data.value.clamp(0, 1)),
        false,
        _valuePaint,
      );

      offset = offset + Offset(data.strokeWidth + 1, data.strokeWidth + 1);
      size = Size.square(size.width - 2 * (data.strokeWidth + 1));
    }
  }

  GaugeTouchedSpot? handleTouch(
      Offset touchedPoint, Size viewSize, PaintHolder<GaugeChartData> holder) {
    return null;
  }
}