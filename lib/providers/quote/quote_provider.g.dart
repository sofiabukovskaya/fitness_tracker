// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getQuote)
const getQuoteProvider = GetQuoteProvider._();

final class GetQuoteProvider
    extends $FunctionalProvider<AsyncValue<Quote>, Quote, FutureOr<Quote>>
    with $FutureModifier<Quote>, $FutureProvider<Quote> {
  const GetQuoteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getQuoteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getQuoteHash();

  @$internal
  @override
  $FutureProviderElement<Quote> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Quote> create(Ref ref) {
    return getQuote(ref);
  }
}

String _$getQuoteHash() => r'e9eb097d9d62c5d80eae0fad2df7bce8e7cbd9b8';
