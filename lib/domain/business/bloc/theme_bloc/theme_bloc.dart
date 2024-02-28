import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/domain/business/bloc/theme_bloc/theme_events.dart';
import 'package:marvel_app/domain/business/bloc/theme_bloc/theme_states.dart';

class ThemeBloc extends Bloc<ThemeEvents, ThemeStates> {
  ThemeBloc() : super(ThemeLightState(isLight: true)) {
    on<ThemeChangeEvent>(
      (event, emit) => changeTheme(emit, event),
    );
  }

  void changeTheme(emit, event) {
    if (event.isLight) {
      emit(ThemeDarkState(isLight: false));
    } else {
      emit(ThemeLightState(isLight: true));
    }
  }
}
