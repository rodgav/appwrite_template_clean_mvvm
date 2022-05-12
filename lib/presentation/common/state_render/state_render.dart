import 'package:appwrite_template_clean_mvvm/intl/generated/l10n.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/assets_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/font_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/styles_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

enum StateRendererType {
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState,
  emptyScreenState
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message, title;
  final Function? backActionFunction;
  final Function? retryActionFunction;

  const StateRenderer(
      {Key? key,
      required this.stateRendererType, required this. message,
      String? title,
      required this.backActionFunction,
      required this.retryActionFunction})
      :
        title = title ?? AppStrings.empty,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    final s = S.of(context);
    switch (stateRendererType) {
      case StateRendererType.fullScreenLoadingState:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getBackButton(s.close, context),
              _getRetryButton(s.retryAgain, context),
            ],
          )
        ]);
      case StateRendererType.contentScreenState:
        return const SizedBox();
      case StateRendererType.emptyScreenState:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      default:
        return const SizedBox();
    }
  }

  Widget _getAnimatedImage(String animationName) {
    return const SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child:
            //LottieBuilder.asset(animationName)
        Placeholder());
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style:
              getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getBackButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: ElevatedButton(
          onPressed: () {
            backActionFunction?.call();
          },
          child: Text(buttonTitle),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: ElevatedButton(
          onPressed: () {
            retryActionFunction?.call();
          },
          child: Text(buttonTitle),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }
}
