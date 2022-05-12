import 'package:appwrite_template_clean_mvvm/intl/generated/l10n.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/assets_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/font_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/styles_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

enum DialogRendererType { successDialog, errorDialog, confirmationDialog }

abstract class DialogRender {
  void showPopUp(
      BuildContext context,
      DialogRendererType dialogRendererType,
      String title,
      String message,
      String? button1,
      String? button2,
      Function? confirmFunction);

  void closePopUp(BuildContext context);
}

class DialogRenderImpl implements DialogRender {
  @override
  void showPopUp(
      BuildContext context,
      DialogRendererType dialogRendererType,
      String title,
      String message,
      String? button1,
      String? button2,
      Function? confirmFunction) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s14)),
              elevation: AppSize.s1_5,
              backgroundColor: Colors.transparent,
              child: SizedBox(
                width: AppSize.s250,
                child: Container(
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: AppSize.s12,
                          offset: Offset(AppSize.s0, AppSize.s12))
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _getAnimatedImage(
                        dialogRendererType == DialogRendererType.successDialog
                            ? JsonAssets.empty
                            : JsonAssets.empty),
                    _getMessage(title),
                    _getMessage(message),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getButton(button1 ?? S.of(context).close, () {
                          Navigator.of(context).pop();
                        }),
                        dialogRendererType ==
                                DialogRendererType.confirmationDialog
                            ? _getButton(button2??S.of(context).confirm, confirmFunction)
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ))
            ));
  }

  @override
  void closePopUp(BuildContext context) {
    Navigator.of(context).pop();
  }

  Widget _getAnimatedImage(String animationName) {
    return const  SizedBox(
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
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getButton(String buttonTitle, Function? function) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: ElevatedButton(
          onPressed: () {
            function?.call();
          },
          child: Text(buttonTitle),
        ),
      ),
    );
  }
}
