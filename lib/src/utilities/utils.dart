import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  final _url = Uri.parse(url);
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) { // <--
    throw Exception('Could not launch $_url');
  }
}