extension DoubleX on double {
  String get addPadLeftZero {
    if (this < 10) {
      return '0${toInt()}';
    } else {
      return '${toInt()}';
    }
  }
}
