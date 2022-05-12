import 'package:appwrite_template_clean_mvvm/app/dependency_injection.dart';
import 'package:appwrite_template_clean_mvvm/intl/generated/l10n.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_template_clean_mvvm/presentation/global_widgets/responsive.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/routes_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'forgot_password_viewmodel.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _viewModel = instance<ForgotPasswordViewModel>();
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() {
      _viewModel.setUsername(_usernameController.text.trim());
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final s = S.of(context);
    return Scaffold(
      backgroundColor: ColorManager.primary.withOpacity(0.7),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data
                  ?.getScreenWidget(context, _getContentWidget(size, s), () {
                Navigator.of(context).pop();
              }, () {
                _viewModel.forgotPassword(context);
              }) ??
              _getContentWidget(size, s)),
    );
  }

  Widget _getContentWidget(Size size, S s) {
    return ResponsiveWid(
        smallScreen: _form(size.width * 0.8, s),
        largeScreen: _form(size.width * 0.5, s));
  }

  Widget _form(double width, S s) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s10)),
            width: width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: AppSize.s100),
                       const SizedBox(
                            width: AppSize.s250,
                            height: AppSize.s140,
                            child: Placeholder()),
                        const SizedBox(height: AppSize.s28),
                        StreamBuilder<bool>(
                            stream: _viewModel.outputUsernameValidate,
                            builder: (_, snapshot) {
                              return TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    labelText: s.inputEmail,
                                    hintText: s.inputEmail,
                                    errorText: (snapshot.data ?? true)
                                        ? null
                                        : s.inputEmailError),
                              );
                            }),
                        const SizedBox(height: AppSize.s28),
                        StreamBuilder<bool>(
                            stream: _viewModel.outputInputValidate,
                            builder: (_, snapshot) {
                              return SizedBox(
                                width: double.infinity,
                                height: AppSize.s40,
                                child: ElevatedButton(
                                    onPressed: (snapshot.data ?? false)
                                        ? () =>
                                            _viewModel.forgotPassword(context)
                                        : null,
                                    child: Text(s.recover)),
                              );
                            }),
                        const SizedBox(height: AppSize.s10),
                        TextButton(
                            onPressed: () =>
                                GoRouter.of(context).go(Routes.loginRoute),
                            child: Text(s.haveAccount)),
                        const SizedBox(height: AppSize.s28),
                      ],
                    )),
              ),
            )));
  }
}
