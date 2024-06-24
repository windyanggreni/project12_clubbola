class Event {
  final String strEvent;
  final String strFilename;
  final String strLeague;
  final String strSeason;
  final String dateEvent;
  final String strTime;
  final String strPoster;

  Event({
    required this.strEvent,
    required this.strFilename,
    required this.strLeague,
    required this.strSeason,
    required this.dateEvent,
    required this.strTime,
    required this.strPoster,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      strEvent: json['strEvent'] ?? '',
      strFilename: json['strFilename'] ?? '',
      strLeague: json['strLeague'] ?? '',
      strSeason: json['strSeason'] ?? '',
      dateEvent: json['dateEvent'] ?? '',
      strTime: json['strTime'] ?? '',
      strPoster: json['strPoster'] ?? '',
    );
  }
}
