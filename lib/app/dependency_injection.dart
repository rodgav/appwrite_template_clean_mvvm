import 'package:appwrite_template_clean_mvvm/data/data_source/local_data_source.dart';
import 'package:appwrite_template_clean_mvvm/data/data_source/remote_data_source.dart';
import 'package:appwrite_template_clean_mvvm/data/network/app_api.dart';
import 'package:appwrite_template_clean_mvvm/data/network/app_write_client_factory.dart';
import 'package:appwrite_template_clean_mvvm/data/network/network_info.dart';
import 'package:appwrite_template_clean_mvvm/data/repository/repository_impl.dart';
import 'package:appwrite_template_clean_mvvm/domain/repository/repository.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/forgot_password_usecase.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/login_usecase.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/main_usecase.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/register_usecase.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/dialog_render/dialog_render.dart';
import 'package:appwrite_template_clean_mvvm/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:appwrite_template_clean_mvvm/presentation/login/login_viewmodel.dart';
import 'package:appwrite_template_clean_mvvm/presentation/main/main_viewmodel.dart';
import 'package:appwrite_template_clean_mvvm/presentation/register/register_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_preferences.dart';
import 'encrypt_helper.dart';

final instance = GetIt.instance;

Future<void> initModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<EncryptHelper>(() => EncryptHelper());
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance(), instance()));
  if (!kIsWeb) {
    instance.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImple(InternetConnectionChecker()));
  }
  instance.registerLazySingleton<AppWriteClientFactory>(
      () => AppWriteClientFactory());
  final client = await instance<AppWriteClientFactory>().getClient();
  instance.registerLazySingleton<AppServiceClient>(
      () => AppServiceClient(client, instance()));
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), kIsWeb ? null : instance()));
  instance.registerLazySingleton<DialogRender>(() => DialogRenderImpl());
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance
        .registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerLazySingleton<LoginViewModel>(
        () => LoginViewModel(instance(), instance()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(instance()));
    instance.registerLazySingleton<RegisterViewModel>(
        () => RegisterViewModel(instance(), instance()));
  }
}

void initForgotModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerLazySingleton<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerLazySingleton<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

void initMainModule() {
  if (!GetIt.I.isRegistered<MainUseCase>()) {
    instance.registerLazySingleton<MainUseCase>(() => MainUseCase(instance()));
    instance.registerLazySingleton<MainViewModel>(
        () => MainViewModel(instance(), instance(), instance()));
  }
}
