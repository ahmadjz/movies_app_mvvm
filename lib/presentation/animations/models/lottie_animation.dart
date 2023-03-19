enum LottieAnimation {
  loading(name: "loading"),
  error(name: "error"),
  noData(name: "no-data"),
  ;

  final String name;
  const LottieAnimation({
    required this.name,
  });
}
