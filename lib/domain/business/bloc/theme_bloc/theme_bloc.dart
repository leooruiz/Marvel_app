import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_events.dart';
import 'theme_states.dart';

class ThemeBloc extends Bloc<ThemeEvents, ThemeStates> {
  ThemeBloc() : super(ThemeLightState()) {
    on<ThemeChangeEvent>(
      changeTheme,
    );
    on<ThemeLoadEvent>(
      (event, emit) => verifyTheme(emit),
    );
  }

  Future<void> verifyTheme(
    Emitter<ThemeStates> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLight = prefs.getBool('isLight');
    if (isLight != null) {
      if (!isLight) {
        emit(ThemeDarkState());
      }
      if (isLight) {
        emit(ThemeLightState());
      }
    }
    await prefs.setBool('isLight', true);
  }

  Future<void> changeTheme(
    ThemeChangeEvent event,
    Emitter<ThemeStates> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLight') != null) {
      if (event.isLight) {
        await prefs.setBool('isLight', false);
        emit(ThemeDarkState());
      }
      if (!event.isLight) {
        await prefs.setBool('isLight', true);
        emit(ThemeLightState());
      }
    } else {
      await prefs.setBool('isLight', true);
    }
  }
}
