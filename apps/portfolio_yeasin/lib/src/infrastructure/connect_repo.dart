import 'package:contact/contact.dart';
import 'package:core/src/api_service.dart';

import 'api_service.dart' as old_api;

///  The reason/cause/benefits will have have by reaching one-another
///* - with limitation/terms/guidance to reduce time of meta-questions
///
class UserConnectRepo implements IConnectRepo {
  const UserConnectRepo._(this._options, {required this.api});

  final ApiService api;

  final List<ConnectOption> _options;

  static Future<UserConnectRepo> create(
    old_api.ApiService service,
    ApiService api,
  ) async {
    try {
      final List<ConnectOption> items = await service.getConnectOptions();
      return UserConnectRepo._(items.where((e) => e.show).toList(), api: api);
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<ConnectOption> get items => List.unmodifiable(_options);

  @override
  Future<ContactResponse> contact(ContactRequest req) async {
    // it does not matter, u can't really hide it in web & this is public key
    req = req.copyWith(apiKey: "ef21ca63-281b-469c-a808-9dfad65ec980");
    try {
      final response = await api.post(
        "https://api.web3forms.com/submit",
        isCompletePath: true,
        fromJson: ContactResponse.fromJson,
      );
      return response;
    } catch (e, st) {
      api.logger.e("failed to submit form $e : $st");
      return ContactResponse(success: false);
    }
  }
}
