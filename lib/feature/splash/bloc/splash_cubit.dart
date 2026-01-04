
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../constants/common_variables.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState()) {
    checkUserLogin();
  }

  checkUserLogin() {
    HydratedBloc.storage.write(CommonVariables.skipClaimOffer, false);

    Future.delayed(
      const Duration(seconds: 3),
      () async {
        emit(state.copyWith(isIntroDone: HydratedBloc.storage.read(CommonVariables.isIntroDone) == true));
        emit(state.copyWith(navigateToLogin: HydratedBloc.storage.read(CommonVariables.isLogin) == true));
      },
    );
  }

}
