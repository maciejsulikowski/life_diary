import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/data/remote_data_sources/root_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/user_remote_data_source.dart';
import 'package:lifediary_project/app/domain/repositories/root_repository.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/features/home/home_page.dart';
import 'package:lifediary_project/app/features/welcome/first_welcome_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(
        UserRepository(UserRemoteDataSource()),
        RootRepository(RootRemoteDataSource()),
      )..start(),
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
    final errorMessage = state.errorMessage ?? 'Unknown error';
    if (state.errorMessage == Status.error) {
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
