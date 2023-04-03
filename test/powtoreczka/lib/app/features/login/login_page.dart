import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:powtoreczka/app/cubit/root_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCreatingAccount == true ? 'Zarejestruj się' : 'Zaloguj sie',
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(hintText: 'Email'),
                controller: widget.emailController,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Haslo'),
                controller: widget.passwordController,
                obscureText: true,
              ),
              SizedBox(height: 20),
              Text(errorMessage),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (isCreatingAccount == true) {
                    try {
                      context.read<RootCubit>().createAccount(
                            widget.emailController,
                            widget.passwordController,
                          );
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  } else {
                    try {
                      context.read<RootCubit>().signIn(
                            widget.emailController,
                            widget.passwordController,
                          );
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  }
                },
                child: Text(isCreatingAccount == true
                    ? 'Zarejestruj się'
                    : 'Zaloguj sie'),
              ),
              if (isCreatingAccount == true) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: Text('Masz konto? Zaloguj sie!'),
                ),
              ],
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: Text('Utwórz konto'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
