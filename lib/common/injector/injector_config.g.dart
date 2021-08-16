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
    container.registerFactory((c) => ListingRepositoryImpl(c<ListingRemoteDataSource>()));
  }

  void _configureDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
            (c) => ListingRemoteDataSource(apiClient: c<ApiClient>()));
  }

  void _configureExternal() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => ApiClient());
  }
}
