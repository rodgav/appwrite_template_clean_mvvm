import 'dart:async';

import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final _inputStrCtrl = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStrCtrl.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStrCtrl.stream.map((flowState) => flowState);

  @override
  void start() {}

  @override
  void dispose() async{
    await _inputStrCtrl.drain();
    _inputStrCtrl.close();
  }
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
