import 'package:federacja_app/entity/AgendaItem.dart';

class EventInstance {
  final int id;
  final String infoTitle;
  final String infoSubtitle;
  final String infoText;
  final String contactEmail;
  final String facebookPage;
  final String instaPage;
  final String linkedInPage;
  final List<AgendaItem> agenda;

  EventInstance(
      this.id,
      this.infoTitle,
      this.infoSubtitle,
      this.infoText,
      this.contactEmail,
      this.facebookPage,
      this.instaPage,
      this.linkedInPage,
      this.agenda);
}
