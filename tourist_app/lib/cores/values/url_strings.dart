class ApiUrl {
  static String urlBase = 'https://d9e8-14-231-133-73.ngrok-free.app/api/v1';
  // static String urlBase = 'http://192.168.1.12:8080/api/v1';
  static String urlLogin = "/login";
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
