class CellEntity {
  final int x;
  final int y;
  final bool isPeace;

  const CellEntity(
    this.x,
    this.y, [
    this.isPeace = false,
  ]);

  CellEntity copyWith({
    required bool isPeace,
  }) {
    return CellEntity(
      x,
      y,
      isPeace,
    );
  }

  @override
  String toString() {
    return 'Cell[x: $x, y: $y, isPeace: $isPeace]';
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
