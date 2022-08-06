import 'package:appwrite_template_clean_mvvm/app/dependency_injection.dart';
import 'package:appwrite_template_clean_mvvm/intl/generated/l10n.dart';
import 'package:appwrite_template_clean_mvvm/presentation/common/state_render/state_render_impl.dart';
import 'package:appwrite_template_clean_mvvm/presentation/main/main_viewmodel.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _viewModel = instance<MainViewModel>();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.primary.withOpacity(0.6),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data
                  ?.getScreenWidget(context, _getContentWidget(s, size), () {
                //back
                _viewModel.inputState.add(ContentState());
              }, () {
                //retry
              }) ??
              _getContentWidget(s, size)),
    );
  }

  Widget _getContentWidget(S s, Size size) {
    return const Center(child: Text('MainView'));
  }

  _goSplash() => GoRouter.of(context).go(Routes.splashRoute);
}
