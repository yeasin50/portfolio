import 'package:freezed_annotation/freezed_annotation.dart';
import 'connect_option.dart';

part 'i_connect_repo.freezed.dart';
part 'i_connect_repo.g.dart';

///handle reason , way  of connecting
///* rules, preference, do's don't etc
///
abstract class IConnectRepo {
  const IConnectRepo(this._items);

  final List<ConnectOption> _items;

  // Returns an unmodifiable list of connect options to ensure immutability
  List<ConnectOption> get items => List.unmodifiable(_items);

  /// fill form  to be connected with
  Future<ContactResponse> contact(ContactRequest req);
}

/// an user group can have for the app
@freezed
abstract class ContactRequest with _$ContactRequest {
  const ContactRequest._();

  const factory ContactRequest({
    @JsonKey(name: "access_key") required String apiKey,
    required String name,
    required String email,
    required String subject,
    required String message,
  }) = _ContactRequest;

  factory ContactRequest.fromJson(Map<String, dynamic> json) =>
      _$ContactRequestFromJson(json);

  static ContactRequest empty = ContactRequest(
    message: "",
    apiKey: "",
    name: "",
    email: "",
    subject: "",
  );
}

@freezed
abstract class ContactResponse with _$ContactResponse {
  const factory ContactResponse({required bool success, String? message}) =
      _ContactResponse;

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);
}
