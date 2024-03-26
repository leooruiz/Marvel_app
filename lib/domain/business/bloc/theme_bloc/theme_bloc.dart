import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_events.dart';
import 'theme_states.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLightState()) {
    on<ThemeChangeEvent>(
      changeTheme,
    );
    on<ThemeLoadEvent>(
      (event, emit) => verifyTheme(emit),
    );
  }

  Future<void> verifyTheme(
    Emitter<ThemeState> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLight = prefs.getBool('isLight') ?? true;
    emit(isLight ? ThemeLightState() : ThemeDarkState());
    await prefs.setBool('isLight', isLight);
  }

  Future<void> changeTheme(
    ThemeChangeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLight = prefs.getBool('isLight') ?? true;
    emit(isLight ? ThemeDarkState() : ThemeLightState());
    await prefs.setBool('isLight', !isLight);
  }
}
