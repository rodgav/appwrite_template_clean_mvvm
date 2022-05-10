import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMesssage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, required this. message});

  @override
  String getMesssage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMesssage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  @override
  String getMesssage() => AppStrings.empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMesssage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreen,
      Function backActionFunction, Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            backActionFunction: backActionFunction,
            retryActionFunction: retryActionFunction,
            message: getMesssage());
      case ErrorState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            backActionFunction: backActionFunction,
            retryActionFunction: retryActionFunction,
            message: getMesssage());
      case ContentState:
        return contentScreen;
      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            backActionFunction: backActionFunction,
            retryActionFunction: retryActionFunction,
            message: getMesssage());
      default:
        return contentScreen;
    }
  }
}
