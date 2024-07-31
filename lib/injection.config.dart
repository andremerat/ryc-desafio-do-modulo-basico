// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/task/data/datasources/task_local_data_source.dart' as _i3;
import 'features/task/data/repository/task_repository_impl.dart' as _i5;
import 'features/task/domain/repositories/task_repository.dart' as _i4;
import 'features/task/presentation/cubit/task_cubit.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.TaskLocalDataSource>(() => _i3.TaskLocalDataSource());
  gh.factory<_i4.TaskRepository>(() =>
      _i5.TaskRepositoryImpl(localDataSource: get<_i3.TaskLocalDataSource>()));
  gh.factory<_i6.TaskCubit>(() => _i6.TaskCubit(get<_i4.TaskRepository>()));
  return get;
}
