import 'package:url_launcher/url_launcher.dart' as ul;
import 'package:url_launcher/url_launcher.dart';

class GlobalUtils {
  Future<void> sendEmail({required String email}) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {'subject': '', 'body': ''});

    await ul.launchUrl(params, mode: ul.LaunchMode.externalApplication);
  }

  Future<void> launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      extLaunchInBrowser(url);
      throw 'Could not launch $url';
    }
  }

  Future<void> extLaunchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
    )) {
      throw 'Could not launch $url';
    }
  }
}
