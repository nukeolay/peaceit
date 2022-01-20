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
}
