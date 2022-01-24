class Cell {
  bool isBlack;
  final int x;
  final int y;

  Cell(
    this.x,
    this.y, [
    this.isBlack = false,
  ]);

  void switchIt() {
    isBlack = !isBlack;
  }

  @override
  String toString() {
    return 'Cell[x: $x, y: $y, isBlack: $isBlack]';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cell &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => (x + y).hashCode;
}
