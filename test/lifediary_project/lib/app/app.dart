import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/features/home/home_page.dart';
import 'package:lifediary_project/app/features/welcome/first_welcome_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(UserRepository())..start(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RootPage(),
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
    if (state.errorMessage.isNotEmpty) {
      return Text('Wystapil blad: ${state.errorMessage}');
    }
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return HomePage(user: state.user!);
  }
}
