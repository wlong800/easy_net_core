

import 'package:app/page/home/view_model/community_view_model.dart';
import 'package:app/page/view_model/custom_contacts_view_models.dart';
import 'package:app/page/view_model/user_ttal_view_models.dart';
import 'package:get_it/get_it.dart';

import 'api/api.dart';
import 'api/impl/api_impl.dart';
import 'app/app_service.dart';
import 'app/impl/app_service_impl.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // services
  serviceLocator.registerLazySingleton<Api>(() => ApiImpl());
//  serviceLocator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
//  serviceLocator.registerLazySingleton<CurrencyService>(() => CurrencyServiceImpl());
  serviceLocator.registerLazySingleton<AppService>(() => AppServiceImpl());

  // You can replace the actual services above with fake implementations during development.
  //
  // serviceLocator.registerLazySingleton<WebApi>(() => FakeWebApi());
  // serviceLocator.registerLazySingleton<StorageService>(() => FakeStorageService());
  // serviceLocator.registerLazySingleton<CurrencyService>(() => CurrencyServiceFake());

  // view models
  serviceLocator.registerFactory<CustomContactsViewModel>(() => CustomContactsViewModel());
  serviceLocator.registerFactory<UserInfoViewModel>(() => UserInfoViewModel());
  serviceLocator.registerFactory<CommunityViewModel>(() => CommunityViewModel());
}
