import 'package:flutter_app/presentation/routes.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

/// Run "flutter packages pub run build_runner watch --delete-conflicting-outputs" to generate codes
final getIt = GetIt.instance;

@injectableInit
void configureInjection(String environment) =>
    $initGetIt(getIt, environment: environment);

@module
abstract class RegisterModule {
  @singleton
  AppRouter get appRouter => AppRouter();
}
