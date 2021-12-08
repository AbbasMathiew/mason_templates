import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/data/interceptor/auth_interceptor.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/data/preferences/auth_preferences.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/data/preferences/user_shared_preferences.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/data/services/http_client/dio_http_client.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/data/services/http_client/http_client.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/data/services/http_profile_service.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/domain/api/api_config.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/domain/preferences/user_preferences.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/domain/services/profile_service.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/injection/injector.dart';

class DataModule {
  static Future<void> inject() async {
    // Prefs
    injector.registerLazySingleton<AuthPreferences>(
      () => AuthPreferences(injector()),
    );
    injector.registerLazySingleton<UserPreferences>(
      () => UserSharedPreferences(injector()),
    );

    // Http
    injector.registerFactory<DioHttpClient>(() {
      return DioHttpClient(Dio());
    });

    injector.registerFactory<HttpClient>(() {
      return DioHttpClient(Dio());
    });

    injector.registerLazySingleton<Dio>(() {
      final Dio dio = Dio();
      dio.httpClientAdapter = DefaultHttpClientAdapter();
      dio.options.baseUrl = injector.get<ApiConfig>().apiUrl;
      dio.interceptors.add(
        AuthInterceptor(
          httpClient: injector(),
          authPreferences: injector(),
          userPreferences: injector(),
          refreshTokenHttpClient: injector(),
          onTokenExpired: () {
            // Handle log out
          },
        ),
      );

      return dio;
    });

    // Services
    injector.registerLazySingleton<ProfileService>(
      () => HttpProfileService(),
    );
  }
}
