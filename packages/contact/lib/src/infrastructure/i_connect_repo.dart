import 'connect_option.dart';

///handle reason , way  of connecting
///* rules, preference, do's don't etc
///
abstract class IConnectRepo {
  const IConnectRepo(this._items);

  final List<ConnectOption> _items;

  // Returns an unmodifiable list of connect options to ensure immutability
  List<ConnectOption> get items => List.unmodifiable(_items);
}
