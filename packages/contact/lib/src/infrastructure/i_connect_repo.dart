import 'connect_option.dart';

///handle reason , way  of connecting
///* rules, preference, do's don't etc
///
abstract class IConnectRepo {
  const IConnectRepo(this.items);

  final List<ConnectOption> items;
}
