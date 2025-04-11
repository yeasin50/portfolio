import 'package:contact/contact.dart';

import 'api_service.dart';

///  The reason/cause/benefits will have have by reaching one-another
///* - with limitation/terms/guidance to reduce time of meta-questions
///
class UserConnectRepo implements IConnectRepo {
  const UserConnectRepo._(this._options);
  final List<ConnectOption> _options;

  static Future<UserConnectRepo> create(ApiService service) async {
    try {
      final List<ConnectOption> items = await service.getConnectOptions();
      return UserConnectRepo._(
        items.where((e) => e.show).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<ConnectOption> get items => List.unmodifiable(_options);
}
