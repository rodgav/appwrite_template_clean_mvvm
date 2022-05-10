import 'dart:async';

import 'package:appwrite_template_clean_mvvm/intl/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:appwrite_template_clean_mvvm/app/dependency_injection.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/forgot_password_usecase.dart';
import 'package:appwrite_template_clean_mvvm/presentation/base/base_viewmodel.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/dialog_render/dialog_render.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render_impl.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final _usernameStreamcontroller = BehaviorSubject<String>();
  final _inputValidateStreamcontroller = BehaviorSubject<void>();
  final dialog = instance<DialogRender>();
  String username = '';
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  @override
  void dispose() async {
    await _usernameStreamcontroller.drain();
    _usernameStreamcontroller.close();
    await _inputValidateStreamcontroller.drain();
    _inputValidateStreamcontroller.close();
    super.dispose();
  }

  @override
  forgotPassword(BuildContext context) async {
    final s = S.of(context);
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: s.loading));
    (await _forgotPasswordUseCase.execute(username)).fold(
        (l) => inputState
            .add(ErrorState(StateRendererType.fullScreenErrorState, l.message)),
        (r) {
      inputState.add(ContentState());
      dialog.showPopUp(context, DialogRendererType.successDialog, s.success,
          s.sendEmail, s.accept, null, null);
    });
  }

  @override
  Sink get inputInputValidate => _inputValidateStreamcontroller.sink;

  @override
  Sink get inputUsername => _usernameStreamcontroller.sink;

  @override
  Stream<bool> get outputInputValidate =>
      _inputValidateStreamcontroller.stream.map((_) => _inputValidate());

  @override
  Stream<bool> get outputUsernameValidate => _usernameStreamcontroller.stream
      .map((username) => _usernameValidate(username));

  @override
  setUsername(String username) {
    this.username = username;
    _validate();
  }

  @override
  void start() {
    inputState.add(ContentState());
    super.start();
  }

  bool _usernameValidate(String username) {
    return username.isNotEmpty;
  }

  void _validate() {
    inputInputValidate.add(null);
  }

  bool _inputValidate() {
    return _usernameValidate(username);
  }
}

abstract class ForgotPasswordViewModelInput {
  setUsername(String username);

  forgotPassword(BuildContext context);

  Sink get inputUsername;

  Sink get inputInputValidate;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputUsernameValidate;

  Stream<bool> get outputInputValidate;
}
