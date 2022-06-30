import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_switch_bloc/app_themes.dart';
import 'package:theme_switch_bloc/bloc/theme_bloc.dart';
import 'package:theme_switch_bloc/services/theme_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        late AppTheme currentTheme;

        return MaterialApp(
          theme: state.themeData,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    if (state.themeData == appThemeData[AppTheme.LightTheme]) {
                      currentTheme = AppTheme.values[1];
                      ThemeDatabaseService.putThemeSettings(1);
                    } else {
                      currentTheme = AppTheme.values[0];
                      ThemeDatabaseService.putThemeSettings(0);
                    }

                    context
                        .read<ThemeBloc>()
                        .add(ThemeChanged(theme: currentTheme));
                  },
                  icon: state.themeData == appThemeData[AppTheme.LightTheme]
                      ? const Icon(Icons.sunny)
                      : const Icon(Icons.mode_night),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
