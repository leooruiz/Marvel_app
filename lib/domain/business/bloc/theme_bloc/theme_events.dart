abstract class ThemeEvent {}

class ThemeChangeEvent extends ThemeEvent {
  ThemeChangeEvent({required this.isLight});
  bool isLight;
}

class ThemeLoadEvent extends ThemeEvent {}
