// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/remote/listing_remote_datasource.dart' as _i3;
import '../../data/repositories/listing_repository_impl.dart' as _i6;
import '../../domain/repositories/listing_repository.dart' as _i5;
import '../../domain/usecases/listing_usecase.dart' as _i7;
import '../../presentation/bloc/listing_bloc/listing_bloc.dart' as _i8;
import '../network/api_client.dart' as _i4;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ListingRemoteDataSource>(
      () => _i3.ListingRemoteDataSource(apiClient: get<_i4.ApiClient>()));
  gh.factory<_i5.ListingRepository>(
      () => _i6.ListingRepositoryImpl(get<_i3.ListingRemoteDataSource>()),
      registerFor: {_dev, _prod});
  gh.factory<_i7.ListingUseCase>(() =>
      _i7.ListingUseCase(listingRepository: get<_i5.ListingRepository>()));
  gh.factory<_i8.ListingBloc>(
      () => _i8.ListingBloc(listingUseCase: get<_i7.ListingUseCase>()));
  gh.singleton<_i4.ApiClient>(_i4.ApiClient());
  return get;
}
