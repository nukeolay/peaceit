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
}
