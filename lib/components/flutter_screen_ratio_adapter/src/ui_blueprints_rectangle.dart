class BlueprintsRectangle {
  final double width;
  final double length;

  const BlueprintsRectangle(this.width, this.length);

  double get aspectRatio {
    if (length != 0.0) return width / length;
    if (width > 0.0) return double.infinity;
    if (width < 0.0) return double.negativeInfinity;
    return 0.0;
  }

  @override
  String toString() {
    return 'BlueprintsRectangle{width: $width, length: $length}';
  }
}
