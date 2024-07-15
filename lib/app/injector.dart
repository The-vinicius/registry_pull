import 'package:auto_injector/auto_injector.dart';
import 'package:registry_pull/app/data/repositories/sqlite_repository_impl.dart';
import 'package:registry_pull/app/interactor/repositories/pull_repository.dart';

final injector = AutoInjector();

void registerInstances() {
  injector.add<PullRepository>(SqliteRepositoryImpl.new);
  injector.commit();
}
