

import 'package:app/page/view_model/custom_ticket_view_models.dart';
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
  serviceLocator.registerFactory<CustomTicketViewModel>(() => CustomTicketViewModel());
}
