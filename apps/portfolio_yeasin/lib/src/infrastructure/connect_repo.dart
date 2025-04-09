import 'package:contact/contact.dart';

import 'api_service.dart';

class UserConnectRepo implements IConnectRepo {
  const UserConnectRepo._(this._options);
  final List<ConnectOption> _options;

  static Future<UserConnectRepo> create(ApiService service) async {
    try {
      final List<ConnectOption> items = await service.getConnectOptions();
      return UserConnectRepo._(items);
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<ConnectOption> get items => List.unmodifiable(_options);
}
