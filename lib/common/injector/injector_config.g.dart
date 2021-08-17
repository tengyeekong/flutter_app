// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  @override
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory(
          (c) => ListingBloc(listingUseCase: c<ListingUseCase>()));
  }

  @override
  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory(
          (c) => ListingUseCase(listingRepository: c<ListingRepository>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory<ListingRepository>(
          (c) => ListingRepositoryImpl(c<ListingRemoteDataSource>()));
  }

  @override
  void _configureDataSources() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory(
          (c) => ListingRemoteDataSource(apiClient: c<ApiClient>()));
  }

  @override
  void _configureExternal() {
    final KiwiContainer container = KiwiContainer();
    container..registerSingleton((c) => ApiClient());
  }
}
