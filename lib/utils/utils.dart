class Utils {
  static String wordEnding(int number) {
    if (number >= 5 && number <= 20) {
      return 'ходов';
    } else if (number < 5) {
      switch (number) {
        case 1:
          return 'ход';
        case 2:
          return 'хода';
        case 3:
          return 'хода';
        case 4:
          return 'хода';
      }
    }
    String str = number.toString();
    int lastDigits = int.parse(str.substring(str.length - 1));
    if (lastDigits >= 5 && lastDigits <= 20) {
      return 'ходов';
    }
    switch (lastDigits) {
      case 1:
        return 'ход';
      case 2:
        return 'хода';
      case 3:
        return 'хода';
      case 4:
        return 'хода';
      default:
        return 'ходов';
    }
  }
}
