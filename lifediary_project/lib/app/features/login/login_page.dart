import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/cubit/root_state.dart';
import 'package:lifediary_project/app/features/home/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RootCubit, RootState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      state.errorMessage ?? 'Unknown error',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
          return;
        } else if (state.user != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomePage(user: state.user!)));
        } else if (state.errorStatus != null) {
          switch (state.errorStatus) {
            case AuthResultStatus.invalidEmail:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Your email address appears to be malformed.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              break;
            case AuthResultStatus.wrongPassword:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Your password is wrong.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              break;
            case AuthResultStatus.userNotFound:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "User not found.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              break;
            case AuthResultStatus.emailAlreadyExists:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "The email has already been registered. Please login or reset your password.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.error, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Niezdefiniowany błąd.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              break;
          }
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
            body: Form(
              child: Container(
                color: Colors.black87,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('images/black_diary.png'),
                              width: 100,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              isCreatingAccount == true
                                  ? AppLocalizations.of(context)!.create_account
                                  : AppLocalizations.of(context)!.login,
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
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 238, 88, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelStyle: GoogleFonts.buenard(
                                  fontSize: 22,
                                  color: Colors.yellow[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 238, 88, 1),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.yellow,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: widget.passwordController,
                              style: TextStyle(
                                color: Colors.yellow[400],
                                fontSize: 22,
                                fontFamily: GoogleFonts.buenard().fontFamily,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                hintStyle: TextStyle(
                                  color: Colors.yellow[400],
                                  fontSize: 22,
                                  fontFamily: GoogleFonts.buenard().fontFamily,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 238, 88, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 238, 88, 1),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
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
                                final email = widget.emailController.text;
                                final password = widget.passwordController.text;

                                if (email.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.error,
                                                color: Colors.white),
                                            const SizedBox(width: 8),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .change_data,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                  return;
                                }
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
                                backgroundColor: Colors.indigo[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                isCreatingAccount == true
                                    ? AppLocalizations.of(context)!.registry
                                    : AppLocalizations.of(context)!.login,
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
                                  AppLocalizations.of(context)!.create_account,
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
                                  AppLocalizations.of(context)!.have_account,
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
