import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class BaseNetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo extends BaseNetworkInfo {
  final InternetConnection _internetConnection;

  NetworkInfo(this._internetConnection);

  @override
  Future<bool> get isConnected async => await _internetConnection.hasInternetAccess;
}