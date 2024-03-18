import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_events.dart';
import 'theme_states.dart';

class ThemeBloc extends Bloc<ThemeEvents, ThemeStates> {
  ThemeBloc() : super(ThemeLightState()) {
    on<ThemeChangeEvent>(
      changeTheme,
    );
  }

  void changeTheme(
    ThemeChangeEvent event,
    Emitter<ThemeStates> emit,
  ) {
    if (event.isLight) {
      emit(ThemeDarkState());
      //TODO: Shared prefs aqui.
    }
    if (!event.isLight) {
      emit(ThemeLightState());
      //TODO: Shared prefs aqui.
    }
  }
}
