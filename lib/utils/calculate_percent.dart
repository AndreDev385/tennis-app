int calculatePercent(int value, int base) {
  if (base == 0) {
    return 0;
  }
  return (100 * value) ~/ base;
}
