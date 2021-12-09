import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/injection/injector.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/presentation/feature/profile/profile_presenter.dart';

class ProfileModule {
  static Future<void> inject() async {
    injector.registerFactory<ProfilePresenter>(
      () => ProfilePresenter(profileService: injector()),
    );
  }
}
