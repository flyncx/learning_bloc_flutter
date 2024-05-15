class Ticker {
  Stream<int> tick({required int seconds}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => seconds - x - 1)
        .take(seconds);
  }
}
