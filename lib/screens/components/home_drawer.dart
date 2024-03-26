import 'package:flutter/material.dart';

import '../../domain/business/bloc/theme_bloc/theme_bloc.dart';
import '../../domain/business/bloc/theme_bloc/theme_events.dart';
import '../../domain/business/bloc/theme_bloc/theme_states.dart';
import '../../themes/app_colors.dart';
import '../../utils/constants/wordings.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({required this.state, required this.themeBloc, super.key});
  final ThemeState state;
  final ThemeBloc themeBloc;
  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon>((states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(
        Icons.light_mode_sharp,
        color: AppColors.dark,
      );
    } else {
      return const Icon(
        Icons.dark_mode,
        color: AppColors.white,
      );
    }
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          widget.state is ThemeLightState ? AppColors.white : AppColors.dark,
      width: MediaQuery.of(context).size.width / 2.2,
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              Wordings.settings,
              style: TextStyle(
                color: AppColors.red,
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight,
              ),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Wordings.theme,
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.titleLarge!.fontWeight,
                  ),
                ),
                Switch(
                  inactiveThumbColor: AppColors.darkRed,
                  inactiveTrackColor: AppColors.dark,
                  activeTrackColor: AppColors.darkRed,
                  thumbIcon: thumbIcon,
                  value: widget.state is ThemeLightState,
                  onChanged: (bool value) {
                    widget.themeBloc.add(
                      ThemeChangeEvent(
                        isLight: !value,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
