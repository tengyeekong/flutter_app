import 'package:flutter_app/bloc/listing_bloc/listing_bloc.dart';
import 'package:flutter_app/usecases/listing_usecase.dart';
import 'package:kiwi/kiwi.dart';

import '../movie_repository_impl.dart';

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
  }

  @Register.factory(ListingBloc)
  void _configureBlocs();

  @Register.factory(ListingUseCase)
  void _configureUseCases();

  @Register.factory(ListingRepositoryImpl)
  void _configureRepositories();
}
