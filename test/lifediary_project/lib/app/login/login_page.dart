import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIFEDIARY',
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/lookorno.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isCreatingAccount == true
                    ? 'Zarejestruj sie'
                    : 'Zaloguj sie'),
                const SizedBox(height: 20),
                TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                ),
                TextField(
                  controller: widget.passwordController,
                  decoration: const InputDecoration(hintText: 'Hasło'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Text(errorMessage),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (isCreatingAccount == true) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: widget.emailController.text,
                                password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                      }
                    } else {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: widget.emailController.text,
                            password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = error.toString();
                        });
                      }
                    }
                  },
                  child: Text(isCreatingAccount == true
                      ? 'Zarejestruj sie'
                      : 'Zaloguj sie'),
                ),
                const SizedBox(height: 20),
                if (isCreatingAccount == false) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isCreatingAccount = true;
                      });
                    },
                    child: Text('Utwórz konto',
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
                if (isCreatingAccount == true) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isCreatingAccount = false;
                      });
                    },
                    child: Text('Masz juz konto?',
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
