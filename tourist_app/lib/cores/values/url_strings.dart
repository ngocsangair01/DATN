class ApiUrl {
  static String urlBase = 'https://54b2-14-0-17-212.ngrok-free.app/api/v1';
  // static String urlBase = 'http://192.168.16.101:8080/api/v1';
  static String urlLogin = "/login";
  static String urlSignUp = "/signup";
  static String urlUser = "/users";
  static String urlFavoriteDes = "/favorite-destination";
  static String urlWeather = "/weathers";
  static String urlWeatherLatLng = "/weathers/latlng";
  static String urlProvince = "/provinces";
  static String urlDestination = "/destinations";
  static String urlGetDestinationByProvince = '$urlDestination/filter';
  static String urlGetDestinationByCreateAt = '$urlDestination/top';
  static String urlCommentDestination = '$urlDestination/comments';
  static String urlGetDestinationByIdUser = '$urlDestination/user';
  static String urlAddress = "/addresses";
  static String urlRecommendItinerary = "/recommend-itinerary";
}
