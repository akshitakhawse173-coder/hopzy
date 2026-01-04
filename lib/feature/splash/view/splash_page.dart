import 'package:flutter/material.dart';
import 'package:hopzy/feature/splash/view/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) async {
        },
        child: const Scaffold(
            body: SplashView()),
      ),
    );
  }
}
