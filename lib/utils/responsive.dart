import 'dart:math';
import 'package:flutter/material.dart';

/// The `Responsive` class provides a utility for responsive sizing in Flutter applications.
/// It calculates width, height, and diagonal sizes relative to the screen size, allowing
/// for responsive design adjustments based on the device's screen dimensions.
class Responsive {
  /// Private fields to store the width, height, and diagonal measurements of the screen.
  double? _width, _height, _diagonal;

  /// Getter for the screen width.
  double? get width => _width;

  /// Getter for the screen height.
  double? get height => _height;

  /// Getter for the screen diagonal length.
  double? get diagonal => _diagonal;

  /// Factory constructor that creates an instance of `Responsive` using the provided `BuildContext`.
  /// This is typically used to access the `Responsive` instance in the widget tree.
  static Responsive of(BuildContext context) => Responsive(context);

  /// Constructor that initializes the `Responsive` instance with the screen dimensions
  /// from the given `BuildContext`. It uses `MediaQuery` to obtain the screen size and
  /// calculates the diagonal length using the Pythagorean theorem.
  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = sqrt(pow(_width!, 2) + pow(_height!, 2));
  }

  /// Calculates a responsive width based on a percentage of the total screen width.
  /// [percent] is the desired percentage of the total width.
  double widthResponsive(num percent) => width! * percent / 100;

  /// Calculates a responsive height based on a percentage of the total screen height.
  /// [percent] is the desired percentage of the total height.
  double heightResponsive(num percent) => height! * percent / 100;

  /// Calculates a responsive diagonal length based on a percentage of the total screen diagonal.
  /// [percent] is the desired percentage of the total diagonal length.
  double diagonalResponsive(num percent) => diagonal! * percent / 100;
}
