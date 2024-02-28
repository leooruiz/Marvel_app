abstract class ThemeStates {}

class ThemeDarkState extends ThemeStates {
  ThemeDarkState({required this.isLight});
  bool isLight;
}

class ThemeLightState extends ThemeStates {
  ThemeLightState({required this.isLight});
  bool isLight;
}
