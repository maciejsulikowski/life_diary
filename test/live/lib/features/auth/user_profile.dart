import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'USER PAGE',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ProfileScreen(
        providerConfigs: const [
          EmailProviderConfiguration(),
        ],
        actions: [
          SignedOutAction(
            (context) {
              Navigator.of(context).pop();
            },
          ),
        ],
        avatarSize: 24,
      ),
    );
  }
}