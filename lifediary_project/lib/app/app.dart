import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/features/home/home_page.dart';
import 'package:lifediary_project/app/features/welcome/first_welcome_page.dart';
import 'package:lifediary_project/app/injection_container.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RootCubit>()..start(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const RootPage(),
        supportedLocales: const [
          Locale('en'), // English
          Locale('pl'), // Polish
        ],
      ),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RootCubit>().state;
    if (state.user == null) {
      return const MyStatelessWidget();
    }
    final errorMessage = state.errorMessage ?? 'Unknown error';
    if (state.status == Status.error) {
      return Text('Wystapil blad: $errorMessage');
    }
    if (state.status == Status.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return HomePage(user: state.user!);
  }
}
