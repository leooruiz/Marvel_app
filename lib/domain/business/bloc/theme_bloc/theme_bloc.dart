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
      verifyTheme,
    );
  }

  Future<void> verifyTheme(ThemeEvents event, Emitter emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLight = prefs.getBool('isLight');
    print(isLight);
    if (isLight != null) {
      if (!isLight) {
        print('Tema salvo é dark');
        emit(ThemeDarkState());
      }
      if (isLight) {
        print('Tema salvo é light');
        emit(ThemeLightState());
      }
    }
    await prefs.setBool('isLight', true);
  }

  Future<void> changeTheme(
    ThemeChangeEvent event,
    Emitter<ThemeStates> emit,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLight') != null) {
      if (event.isLight) {
        print('Mudando para tema escuro');
        await prefs.setBool('isLight', false);
        emit(ThemeDarkState());
      }
      if (!event.isLight) {
        print('Mudando para tema claro');
        await prefs.setBool('isLight', true);
        emit(ThemeLightState());
      }
    }
    if (prefs.getBool('isLight') == null) {
      print('tema nulo, criando no tema claro');
      await prefs.setBool('isLight', true);
    }
  }
}
