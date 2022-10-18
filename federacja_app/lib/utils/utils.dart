import 'package:url_launcher/url_launcher.dart' as UL;
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Future<void> sendEmail({required String email}) async {
    final Uri params = Uri(scheme: 'mailto', path: email);

    if (await UL.canLaunchUrl(params)) {
      await UL.launchUrl(params, mode: UL.LaunchMode.externalApplication);
    } else {
      throw Exception("Unable to open the email");
    }
  }

  Future<void> openUrl({required String url}) async {
    Uri uri = Uri.parse(url);
    if (await UL.canLaunchUrl(uri)) {
      await UL.launchUrl(uri);
    } else {
      throw Exception("Unable to open the browser");
    }
  }

  Future<void> launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchUniversalLinkIos(String url) async {
    Uri uri = Uri.parse(url);

    final bool nativeAppLaunchSucceeded = await launchUrl(
      uri,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
      );
    }
  }
}
