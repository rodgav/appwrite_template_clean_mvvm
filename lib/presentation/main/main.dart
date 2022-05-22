import 'package:appwrite_template_clean_mvvm/app/dependency_injection.dart';
import 'package:appwrite_template_clean_mvvm/presentation/main/main_viewmodel.dart';
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
    return const Scaffold(
      body: Center(
        child: Text('MainView'),
      ),
    );
  }

  _goSplash()=>
    GoRouter.of(context).go(Routes.splashRoute);
}
