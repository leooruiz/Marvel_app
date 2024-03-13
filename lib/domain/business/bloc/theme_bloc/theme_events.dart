abstract class ThemeEvents {}

class ThemeChangeEvent extends ThemeEvents {
  ThemeChangeEvent({required this.isLight});
  bool isLight;
}

class ThemeLoadEvent extends ThemeEvents {}
