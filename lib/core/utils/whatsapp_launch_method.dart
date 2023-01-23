import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

launchWhatsApp(String whatsapp,{String? message}) async {
  var link =  WhatsAppUnilink(
    phoneNumber: whatsapp,
    text: message,
  );
  await launch('$link');
}