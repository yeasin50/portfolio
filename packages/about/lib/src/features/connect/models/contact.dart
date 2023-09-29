import 'package:url_launcher/url_launcher.dart';

part 'basic_contact_medium.dart';
part 'developer_medium.dart';
part 'others_media.dart';

abstract class Contact {
  const Contact();

  /// open contact app/call/email
  Future<void> onTap();
}