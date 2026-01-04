part of 'splash_cubit.dart';

class SplashState {
  final bool? navigateToLogin;
  final bool isIntroDone;

  SplashState({this.navigateToLogin, this.isIntroDone = false});

  SplashState copyWith({bool? navigateToLogin, bool? isIntroDone}) {
    return SplashState(
      navigateToLogin: navigateToLogin ?? this.navigateToLogin,
      isIntroDone: isIntroDone ?? this.isIntroDone,
    );
  }
}
