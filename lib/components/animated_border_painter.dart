import 'package:flutter/material.dart';
import 'package:ui_test/util/constants.dart';

class AnimatedBorderPainter extends CustomPainter {
  final Animation<double> animation;

  AnimatedBorderPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect =
        RRect.fromRectAndRadius(rect, const Radius.circular(kBorderRadius));

    final path = Path()..addRRect(rRect);

    final pathMetrics = path.computeMetrics();
    final totalLength =
        pathMetrics.fold(0.0, (sum, metric) => sum + metric.length);

    final halfLength = totalLength / 2;

    final currentLength = totalLength * animation.value;
    final firstHalfLength =
        (currentLength > halfLength) ? halfLength : currentLength;
    final secondHalfLength = (currentLength < halfLength)
        ? currentLength - halfLength
        : currentLength;

    final firstPath = extractPath(path, firstHalfLength);
    final secondPath = extractPath(path, secondHalfLength, offset: halfLength);

    canvas.drawPath(firstPath, paint);
    canvas.drawPath(secondPath, paint);
  }

  Path extractPath(Path originalPath, double length, {double offset = 0}) {
    final path = Path();
    double currentLength = 0.0;

    for (final metric in originalPath.computeMetrics()) {
      if (currentLength + metric.length > offset) {
        final start = offset > currentLength ? offset - currentLength : 0.0;
        final remainingLength = length - (currentLength - offset);
        final extractLength = remainingLength.clamp(0, metric.length - start);
        path.addPath(
            metric.extractPath(start, start + extractLength), Offset.zero);
        break;
      }
      currentLength += metric.length;
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
