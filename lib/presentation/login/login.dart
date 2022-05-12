import 'package:appwrite_template_clean_mvvm/app/dependency_injection.dart';
import 'package:appwrite_template_clean_mvvm/intl/generated/l10n.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_template_clean_mvvm/presentation/global_widgets/responsive.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/routes_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _viewModel = instance<LoginViewModel>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text.trim()));
    _passwordController.addListener(
        () => _viewModel.setPassword(_passwordController.text.trim()));
    _emailController.text = '';
    _passwordController.text = '';
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final s = S.of(context);
    return Scaffold(
        backgroundColor: ColorManager.primary.withOpacity(0.7),
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (_, snapshot) =>
                snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(size, s), () {
                  _viewModel.inputState.add(ContentState());
                }, () {
                  _viewModel.login(context);
                }) ??
                _getContentWidget(size, s)));
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
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p20, vertical: AppPadding.p10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                      width: AppSize.s250,
                      height: AppSize.s140,
                      child: Placeholder()),
                  const SizedBox(height: AppSize.s40),
                  StreamBuilder<bool>(
                    stream: _viewModel.outputEmailValid,
                    builder: (context, snapshot) => TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: s.inputEmail,
                          hintText: s.inputEmail,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : s.inputEmailError),
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  StreamBuilder<bool>(
                    stream: _viewModel.outputPasswordValid,
                    builder: (context, snapshot) => TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: s.inputPassword,
                          hintText: s.inputPassword,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : s.inputPasswordError),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: AppSize.s40),
                  StreamBuilder<bool>(
                      stream: _viewModel.outputInputValid,
                      builder: (_, snapshot) => SizedBox(
                            width: double.infinity,
                            height: AppSize.s40,
                            child: ElevatedButton(
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                (snapshot.data ?? false)
                                                    ? ColorManager.primary
                                                    : ColorManager.white),
                                        side: MaterialStateProperty.all(
                                            BorderSide(
                                                color: ColorManager.primary))),
                                onPressed: (snapshot.data ?? false)
                                    ? () => _viewModel.login(context)
                                    : null,
                                child: Text(s.login)),
                          )),
                  const SizedBox(height: AppSize.s10),
                  SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: () => _viewModel.anonymous(context),
                          child: Text(s.anonymous))),
                  const SizedBox(height: AppSize.s10),
                  SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: () =>
                              GoRouter.of(context).push(Routes.registerRoute),
                          child: Text(s.register))),
                  const SizedBox(height: AppSize.s10),
                  TextButton(
                      onPressed: () =>
                          GoRouter.of(context).push(Routes.forgotPasswordRoute),
                      child: Text(s.forgotPassword)),
                  const SizedBox(height: AppSize.s10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
