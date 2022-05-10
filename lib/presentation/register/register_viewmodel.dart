import 'package:appwrite_template_clean_mvvm/app/app_preferences.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:appwrite_template_clean_mvvm/app/functions.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/register_usecase.dart';
import 'package:appwrite_template_clean_mvvm/presentation/base/base_viewmodel.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final RegisterUseCase _registerUsecase;
  final AppPreferences _appPreferences;

  RegisterViewModel(this._registerUsecase, this._appPreferences);

  final _emailStreCtrl = BehaviorSubject<String>();
  final _passwordStreCtrl = BehaviorSubject<String>();
  final _nameStreCtrl = BehaviorSubject<String>();
  final _inputsStreCtrl = BehaviorSubject<void>();

  LoginObject _loginObject = LoginObject('', '', '');

  @override
  Sink get inputInputsValid => _inputsStreCtrl.sink;

  @override
  Sink get inputEmail => _emailStreCtrl.sink;

  @override
  Sink get inputPassword => _passwordStreCtrl.sink;

  @override
  Sink get inputName => _nameStreCtrl.sink;

  @override
  register(BuildContext context) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: AppStrings.empty));
    (await _registerUsecase.execute(RegisterUseCaseInput(
            _loginObject.username, _loginObject.password, _loginObject.name)))
        .fold((f) {
      inputState
          .add(ErrorState(StateRendererType.fullScreenErrorState, f.message));
    }, (r) async {
      (await _registerUsecase.login(
          RegisterUseCaseInput(_loginObject.username, _loginObject.password, _loginObject.name)))
          .fold((f) {
        inputState
            .add(ErrorState(StateRendererType.fullScreenErrorState, f.message));
      }, (r) async {
        await _appPreferences.setSessionIds(r.$id, r.userId);
        GoRouter.of(context).go(Routes.mainRoute);
      });
    });
  }

  @override
  Stream<bool> get outputEmailValid => _emailStreCtrl.stream.map(isEmailValid);

  @override
  Stream<bool> get outputPasswordValid =>
      _passwordStreCtrl.stream.map((password) => _passwordValid(password));

  @override
  Stream<bool> get outputNameValid =>
      _nameStreCtrl.stream.map((name) => _nameValid(name));

  @override
  Stream<bool> get outputInputValid =>
      _inputsStreCtrl.stream.map((_) => _inputsValid());

  @override
  setEmail(String email) {
    inputEmail.add(email);
    _loginObject = _loginObject.copyWith(username: email);
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    _loginObject = _loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setName(String name) {
    inputName.add(name);
    _loginObject = _loginObject.copyWith(name: name);
    _validate();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _nameStreCtrl.close();
    _emailStreCtrl.close();
    _passwordStreCtrl.close();
    _inputsStreCtrl.close();
    super.dispose();
  }

  _validate() {
    inputInputsValid.add(null);
  }

  bool _passwordValid(String password) {
    return password.length >= 8;
  }

  bool _nameValid(String name) {
    return name.length >= 3;
  }

  bool _inputsValid() {
    return _loginObject.username.isNotEmpty &&
        _loginObject.password.isNotEmpty &&
        _loginObject.name.isNotEmpty;
  }
}

abstract class RegisterViewModelInput {
  setEmail(String email);

  setPassword(String password);

  setName(String name);

  register(BuildContext context);

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputName;

  Sink get inputInputsValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputEmailValid;

  Stream<bool> get outputPasswordValid;

  Stream<bool> get outputNameValid;

  Stream<bool> get outputInputValid;
}
