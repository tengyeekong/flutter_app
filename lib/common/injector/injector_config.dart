import 'package:flutter_app/data/datasources/remote/Api.dart';
import 'package:flutter_app/data/datasources/remote/listing_remote_datasource.dart';
import 'package:flutter_app/data/repositories/movie_repository_impl.dart';
import 'package:flutter_app/domain/usecases/listing_usecase.dart';
import 'package:flutter_app/presentation/bloc/listing_bloc/listing_bloc.dart';
import 'package:kiwi/kiwi.dart';

part 'injector_config.g.dart';

abstract class InjectorConfig {
  static late KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
    final injector = _$InjectorConfig();
    // ignore: cascade_invocations
    injector._configure();
  }

  // ignore: type_annotate_public_apis
  static final resolve = container.resolve;

  void _configure() {
    _configureInsuranceModule();
  }

  void _configureInsuranceModule() {
    _configureBlocs();
    _configureUseCases();
    _configureRepositories();
    _configureDataSources();
    _configureExternal();
  }

  @Register.factory(ListingBloc)
  void _configureBlocs();

  @Register.factory(ListingUseCase)
  void _configureUseCases();

  @Register.factory(ListingRepositoryImpl)
  void _configureRepositories();

  @Register.factory(ListingRemoteDataSource)
  void _configureDataSources();

  @Register.singleton(ApiClient)
  void _configureExternal();
}
