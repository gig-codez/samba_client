extension IntUtil on int {
  String get zeros {
    if (this < 10) {
      return "0$this";
    } else {
      return "$this";
    }
  }
}