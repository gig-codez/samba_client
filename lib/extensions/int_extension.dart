extension IntUtil on int {
  String get zeros {
    if (this >= 0 && this<10) {
      return "0$this";
    } else {
      return "$this";
    }
  }
}