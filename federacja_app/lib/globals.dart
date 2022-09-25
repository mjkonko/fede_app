class Globals {
  static const String _API_URL_DEV = "https://fede-app-dev.herokuapp.com/";
  static const String _API_URL_PROD = "https://fede-app-prod.herokuapp.com/";

  static const String _API_URL_AGENDA = "agenda/";
  static const String _API_URL_EVENTS = "events/";
  static const String _API_URL_USER = "user/";
  static const String _API_URL_NEWS = "news/";
  static const String _API_URL_SPEAKER = "speaker/";
  static const String _API_URL_VENUE = "venue/";

  bool isProd = false;

  String getApiUrl() {
    if (isProd) {
      return _API_URL_PROD;
    } else {
      return _API_URL_DEV;
    }
  }

  String getAgendaUrl() {
    return getApiUrl() + _API_URL_AGENDA;
  }

  String getEventsUrl() {
    return getApiUrl() + _API_URL_EVENTS;
  }

  String getNewsUrl() {
    return getApiUrl() + _API_URL_NEWS;
  }

  String getUser(String id) {
    return "${getApiUrl()}$_API_URL_USER$id/";
  }

  String getSpeaker(String id) {
    return getApiUrl() + _API_URL_SPEAKER + id;
  }

  String getVenue(String id) {
    return getApiUrl() + _API_URL_VENUE + id;
  }
}
