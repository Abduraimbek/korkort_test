extension IntX on int {
  String get addPadLeftZero {
    if (this < 10) {
      return '0$this';
    } else {
      return '$this';
    }
  }
}
