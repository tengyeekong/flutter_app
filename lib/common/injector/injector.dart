import 'package:flutter_app/common/network/api_client.dart';
import 'package:flutter_app/data/datasources/remote/listing_remote_datasource.dart';
import 'package:flutter_app/data/repositories/listing_repository_impl.dart';
import 'package:flutter_app/domain/repositories/listing_repository.dart';
import 'package:flutter_app/domain/usecases/listing_usecase.dart';
import 'package:flutter_app/presentation/bloc/listing_bloc/listing_bloc.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

/// Run "flutter packages pub run build_runner build --delete-conflicting-outputs" to generate codes
abstract class Injector {
  static late KiwiContainer container;

  static void init() {
    container = KiwiContainer();
    final injector = _$Injector();
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

  @Register.factory(ListingRepository, from: ListingRepositoryImpl)
  void _configureRepositories();

  @Register.factory(ListingRemoteDataSource)
  void _configureDataSources();

  @Register.singleton(ApiClient)
  void _configureExternal();
}
