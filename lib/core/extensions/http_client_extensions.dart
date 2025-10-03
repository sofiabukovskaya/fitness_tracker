import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
extension DebonceAndCancelExtesnsion on Ref {
  Future<http.Client> getDebonceAndCancelHttpClient() async {
    final client = http.Client();
    bool isDisposed = false;
    onDispose(() {
      isDisposed = true;
      client.close();
    });
    if (isDisposed) {
      throw Exception('Ref was disposed');
    }
    await Future.delayed(const Duration(seconds: 1));
    return http.Client();
  }
}