import 'package:fitness_tracker/providers/quote/quote_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuoteWidget extends ConsumerWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteAsyncValue = ref.watch(getQuoteProvider);

    return quoteAsyncValue.maybeWhen(
      data:
          (data) => Column(
            children: [
              Text(
                '"${data.quote}"',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(getQuoteProvider),
                child: const Text('Refresh'),
              ),
            ],
          ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
