import 'dart:async';

import 'package:appwrite_template_clean_mvvm/app/app_preferences.dart';
import 'package:appwrite_template_clean_mvvm/app/dependency_injection.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/routes_manager.dart';
import 'package:appwrite_template_clean_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _appPreferences = instance<AppPreferences>();
  Timer? _timer;

  void _startDelay() {
    _timer =
        Timer(const Duration(milliseconds: DurationConstants.d800), _goNext);
  }

  void _goNext() async {
    if (_appPreferences.getUserId() != '') {
      //GoRouter.of(context).go(Routes.mainRoute);
      context.go(Routes.mainRoute);
    } else {
      context.go(Routes.loginRoute);
    }
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child: SizedBox(
              width: AppSize.s200, height: AppSize.s200, child: Placeholder())),
    );
  }
}
