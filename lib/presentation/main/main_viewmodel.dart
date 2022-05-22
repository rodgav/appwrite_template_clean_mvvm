import 'package:appwrite_template_clean_mvvm/app/app_preferences.dart';
import 'package:appwrite_template_clean_mvvm/data/data_source/local_data_source.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/main_usecase.dart';
import 'package:appwrite_template_clean_mvvm/presentation/base/base_viewmodel.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter/cupertino.dart';

class MainViewModel extends BaseViewModel
    with MainViewModelInputs, MainViewModelOutputs {
  final MainUseCase _mainUseCase;
  final AppPreferences _appPreferences;
  final LocalDataSource _localDataSource;

  MainViewModel(this._mainUseCase, this._appPreferences, this._localDataSource);

  @override
  void start() {
    super.start();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  deleteSession(BuildContext context,VoidCallback goSplash) async {
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
      goSplash.call();
    });
  }
}

abstract class MainViewModelInputs {
  deleteSession(BuildContext context,VoidCallback goSplash);
}

abstract class MainViewModelOutputs {}
