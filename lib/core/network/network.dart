import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo {
  static String notFound =
      'No internet connection. Please check your connection.';
  static Future<bool> isConnected = InternetConnectionChecker().hasConnection;
}
