part of 'injector_config.dart';

class _$InjectorConfig extends InjectorConfig {
  void _configureBlocs() {
    KiwiContainer()
      ..registerFactory((c) => ListingBloc(listingUseCase: c<ListingUseCase>()));
  }

  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
            (c) => ListingUseCase(listingRepository: c<ListingRepositoryImpl>()));
  }

  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => ListingRepositoryImpl());
  }
}
