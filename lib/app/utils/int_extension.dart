extension VratiBodove on int {
  String returnPoints() {
    if (this >= 0 && this < 10) {
      switch (this) {
        case 1:
          return 'bod';
        case 2:
        case 3:
        case 4:
          return 'boda';
        default:
          return 'bodova';
      }
    } else if (this > 10 && this < 20) {
      return 'bodova';
    } else {
      final String num = this.toString();
      final List<String> digits = num.split('');
      final int lastDigit = int.parse(digits.last);
      switch (lastDigit) {
        case 1:
          return 'bod';
        case 2:
        case 3:
        case 4:
          return 'boda';
        default:
          return 'bodova';
      }
    }
  }
}
