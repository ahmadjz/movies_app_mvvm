bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isPasswordValid(String password) {
  return password.length >= 8 &&
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
}

String youtubeUrl(String videoId) {
  return "https://www.youtube.com/watch?v=$videoId";
}

String youtubeThumbnailUrl(String videoId) {
  return "https://img.youtube.com/vi/$videoId/0.jpg";
}

String getMovieImageUrl(int movieId) =>
    'https://darsoft.b-cdn.net/assets/movies/$movieId.jpg';
String getActorImageUrl(int actorId) =>
    'https://darsoft.b-cdn.net/assets/artists/$actorId.jpg';
String displayMovieRating(double rating) => "$rating/10";
