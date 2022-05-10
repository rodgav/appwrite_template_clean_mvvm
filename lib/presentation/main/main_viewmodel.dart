import 'package:appwrite_template_clean_mvvm/app/app_preferences.dart';
import 'package:appwrite_template_clean_mvvm/data/data_source/local_data_source.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/main_usecase.dart';
import 'package:appwrite_template_clean_mvvm/presentation/base/base_viewmodel.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/routes_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class MainViewModel extends BaseViewModel
    with MainViewModelInputs, MainViewModelOutputs {
  final MainUseCase _mainUseCase;
  final AppPreferences _appPreferences;
  final LocalDataSource _localDataSource;

  MainViewModel(this._mainUseCase, this._appPreferences, this._localDataSource);

  //start and dispose override

  @override
  deleteSession(BuildContext context) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: AppStrings.empty));
    final sessionId = _appPreferences.getSessionId();
    (await _mainUseCase.execute(MainDeleteSessionUseCaseInput(sessionId))).fold(
        (f) {
      inputState
          .add(ErrorState(StateRendererType.fullScreenErrorState, f.message));
    }, (r) async {
      inputState.add(ContentState());
      await _appPreferences.logout();
      _localDataSource.clearCache();
      GoRouter.of(context).go(Routes.splashRoute);
    });
  }
}

abstract class MainViewModelInputs {
  deleteSession(BuildContext context);
}

abstract class MainViewModelOutputs {}
