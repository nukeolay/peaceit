class CellEntity {
  final int x;
  final int y;
  bool isBlack; // TODO потом сделать final и поменять switchIt

  CellEntity(
    this.x,
    this.y, [
    this.isBlack = false,
  ]);

  CellEntity copyWith({
    required bool isBlack,
  }) {
    return CellEntity(
      x,
      y,
      isBlack,
    );
  }

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
      other is CellEntity &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => (x + y).hashCode;
}
