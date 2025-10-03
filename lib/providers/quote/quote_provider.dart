import 'dart:convert';

import 'package:fitness_tracker/core/extensions/http_client_extensions.dart';
import 'package:fitness_tracker/models/quote/quote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quote_provider.g.dart';

@riverpod
Future<Quote> getQuote(Ref ref) async {
  final url = Uri.parse('https://quotes-api-self.vercel.app/quote');
  final client = await ref.getDebonceAndCancelHttpClient();
  final response = await client.get(url);
  if (response.statusCode == 200) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return Quote.fromJson(body);
  } else {
    throw Exception('Failed to load quote');
  }
}
