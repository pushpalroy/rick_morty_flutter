import 'package:bloc/bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);

  void toggle() => emit(!state);
}
