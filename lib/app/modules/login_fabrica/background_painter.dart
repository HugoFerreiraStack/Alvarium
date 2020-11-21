import 'dart:math';
import 'dart:ui';

import 'package:alvarium/app/shared/palett.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({Animation<double> animation})
      : goldPaint = Paint()
          ..color = Palette.gold
          ..style = PaintingStyle.fill,
        blackPaint = Paint()
          ..color = Palette.black
          ..style = PaintingStyle.fill,
        brownPaint = Paint()
          ..color = Palette.gold
          ..style = PaintingStyle.fill,
        goldPaint2 = Paint()
          ..color = Palette.gold
          ..style = PaintingStyle.fill,
        liquidAnim = CurvedAnimation(
            curve: Curves.elasticInOut,
            reverseCurve: Curves.easeInBack,
            parent: animation),
        goldAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        blackAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.09, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        brownAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> goldAnim;
  final Animation<double> blackAnim;
  final Animation<double> brownAnim;

  final Paint goldPaint;
  final Paint blackPaint;
  final Paint brownPaint;
  final Paint goldPaint2;

  @override
  void paint(Canvas canvas, Size size) {
    paintGold(canvas, size);
    paintBlack(canvas, size);
    paintBrown(size, canvas);
  }

  void paintGold(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, lerpDouble(0, size.height, goldAnim.value));
    _addPointsToPath(path, [
      Point(lerpDouble(0, size.width / 3, goldAnim.value),
          lerpDouble(0, size.height, goldAnim.value)),
      Point(lerpDouble(size.width / 2, size.height / 4 * 3, liquidAnim.value),
          lerpDouble(size.height / 2, size.width / 4 * 3, liquidAnim.value)),
      Point(size.width,
          lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value)),
    ]);

    canvas.drawPath(path, goldPaint);
  }

  void paintBlack(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(
        size.height / 4,
        size.height / 2,
        blackAnim.value,
      ),
    );
    _addPointsToPath(
      path,
      [
        Point(
          size.width / 4,
          lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
        ),
        Point(
          size.width * 3 / 5,
          lerpDouble(size.height / 4, size.height / 2, liquidAnim.value),
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, blackAnim.value),
        ),
        Point(
          size.width,
          lerpDouble(size.height / 5, size.height / 4, blackAnim.value),
        ),
      ],
    );

    canvas.drawPath(path, blackPaint);
  }

  void paintBrown(Size size, Canvas canvas) {
    if (brownAnim.value > 0) {
      final path = Path();

      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      path.lineTo(
        0,
        lerpDouble(0, size.height / 12, brownAnim.value),
      );

      _addPointsToPath(path, [
        Point(
          size.width / 7,
          lerpDouble(0, size.height / 6, liquidAnim.value),
        ),
        Point(
          size.width / 3,
          lerpDouble(0, size.height / 10, liquidAnim.value),
        ),
        Point(
          size.width / 3 * 2,
          lerpDouble(0, size.height / 8, liquidAnim.value),
        ),
        Point(
          size.width * 3 / 4,
          0,
        ),
      ]);

      canvas.drawPath(path, brownPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError("Precisa de mais pontos para criar um path");
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
