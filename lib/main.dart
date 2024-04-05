import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/data/repositories/dio_settings.dart';
import 'package:rick_and_morty/data/repositories/get_chars_repo.dart';
import 'package:rick_and_morty/data/repositories/get_episode_repo.dart';
import 'package:rick_and_morty/presentation/bloc/chars_bloc/chars_bloc_bloc.dart';
import 'package:rick_and_morty/presentation/bloc/episode_bloc/episode_bloc.dart';
import 'package:rick_and_morty/presentation/theme/theme_provider.dart';
import 'package:rick_and_morty/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Builder(builder: (context) {
        return Builder(builder: (context) {
          return TextFieldUnFocus(
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => DioSettings(),
                ),
                RepositoryProvider(
                  create: (context) => GetCharsRepo(
                      dio: RepositoryProvider.of<DioSettings>(context).dio),
                ),
                RepositoryProvider(
                  create: (context) => GetEpisodeDataRepo(
                      dio: RepositoryProvider.of<DioSettings>(context).dio),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => CharsBlocBloc(
                        repo: RepositoryProvider.of<GetCharsRepo>(context)),
                  ),
                  BlocProvider(
                    create: (context) => EpisodeBloc(
                        repo:
                            RepositoryProvider.of<GetEpisodeDataRepo>(context)),
                  ),
                ],
                child: MaterialApp(
                  theme: context.watch<ThemeProvider>().theme,
                  home: const SplashScreen(),
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}

class TextFieldUnFocus extends StatelessWidget {
  const TextFieldUnFocus({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: child,
      );
}
