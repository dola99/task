import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartConfig {
  static const chartMargin = EdgeInsets.fromLTRB(12, 12, 16, 12);
  static const double plotOffset = 12.0;
  static const double legendPadding = 16.0;
  static const double legendItemPadding = 8.0;
  static const double markerSize = 8.0;
  static const double borderWidth = 2.0;
  static const double splineWidth = 3.0;
  static const int animationDuration = 1500;

  static TextStyle axisTextStyle([Color? color]) => GoogleFonts.workSans(
        color: color ?? Colors.grey[600],
        fontSize: 12,
      );

  static TextStyle titleStyle() => GoogleFonts.workSans(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  static LinearGradient areaGradient() => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue.withOpacity(0.3),
          Colors.blue.withOpacity(0.1),
        ],
      );

  static MarkerSettings markerSettings() => const MarkerSettings(
        isVisible: true,
        height: markerSize,
        width: markerSize,
        borderWidth: borderWidth,
        borderColor: Colors.blue,
        shape: DataMarkerType.circle,
      );

  static BoxDecoration containerDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static ZoomPanBehavior zoomPanBehavior() => ZoomPanBehavior(
        enablePinching: true,
        enableDoubleTapZooming: true,
        enablePanning: true,
        zoomMode: ZoomMode.x,
      );

  static Legend legend() => Legend(
        isVisible: true,
        position: LegendPosition.top,
        textStyle: axisTextStyle(),
        padding: legendPadding,
        itemPadding: legendItemPadding,
        overflowMode: LegendItemOverflowMode.wrap,
      );
}
