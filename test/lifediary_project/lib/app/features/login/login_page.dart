import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lifediary_project/app/cubit/root_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(),
      child: BlocListener<RootCubit, RootState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: BlocBuilder<RootCubit, RootState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'LIFEDIARY',
                  style: GoogleFonts.buenard(
                      fontSize: 24,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.black87,
              ),
              body: Container(
                color: Colors.black87,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('images/black_diary.png'),
                          width: 100,
                        ),
                        SizedBox(height: 20),
                        Text(
                          isCreatingAccount == true
                              ? 'Stwórz konto'
                              : 'Zaloguj się',
                          style: GoogleFonts.buenard(
                              fontSize: 24,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: widget.emailController,
                          style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 22,
                            fontFamily: GoogleFonts.buenard().fontFamily,
                          ),
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                            hintStyle: TextStyle(
                              color: Colors.yellow[400],
                              fontSize: 22,
                              fontFamily: GoogleFonts.buenard().fontFamily,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromRGBO(255, 238, 88, 1),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.yellow,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: widget.passwordController,
                          style: TextStyle(
                            color: Colors.yellow[400],
                            fontSize: 22,
                            fontFamily: GoogleFonts.buenard().fontFamily,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Hasło',
                            hintStyle: TextStyle(
                              color: Colors.yellow[400],
                              fontSize: 22,
                              fontFamily: GoogleFonts.buenard().fontFamily,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromRGBO(255, 238, 88, 1),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.yellow,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (isCreatingAccount == true) {
                              context.read<RootCubit>().createAccount(
                                    widget.emailController,
                                    widget.passwordController,
                                  );
                            } else {
                              context.read<RootCubit>().signIn(
                                    widget.emailController,
                                    widget.passwordController,
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            isCreatingAccount == true
                                ? 'Zarejestruj się'
                                : 'Zaloguj się',
                            style: GoogleFonts.buenard(
                                fontSize: 20,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (isCreatingAccount == false) ...[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isCreatingAccount = true;
                              });
                            },
                            child: Text(
                              'Utwórz konto',
                              style: GoogleFonts.buenard(
                                  fontSize: 24,
                                  color: Colors.yellow[400],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        if (isCreatingAccount == true) ...[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isCreatingAccount = false;
                              });
                            },
                            child: Text(
                              'Masz juz konto?',
                              style: GoogleFonts.buenard(
                                  fontSize: 24,
                                  color: Colors.yellow[400],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
