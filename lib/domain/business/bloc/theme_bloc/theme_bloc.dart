import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_events.dart';
import 'theme_states.dart';

class ThemeBloc extends Bloc<ThemeEvents, ThemeStates> {
  ThemeBloc() : super(ThemeLightState(isLight: true)) {
    on<ThemeChangeEvent>(
      (event, emit) => changeTheme(emit, event),
    );
  }

  void changeTheme(Emitter<ThemeStates> emit, ThemeChangeEvent event) {
    if (event.isLight) {
      emit(ThemeDarkState(isLight: false));
    } else {
      emit(ThemeLightState(isLight: true));
    }
  }
}
