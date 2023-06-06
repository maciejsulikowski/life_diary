import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/features/login/cubit/user_cubit.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lifediary_project/app/cubit/root_cubit.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'USER PAGE',
          style: GoogleFonts.buenard(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: UserView(),
    );
  }
}

class UserView extends StatefulWidget {
  const UserView({
    Key? key,
  });

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late TextEditingController controller;
  late IconData icon;
  late Color iconColor;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    icon = Icons.edit;
    iconColor = Colors.yellow[400]!;
    controller.addListener(onTextChanged);
  }

  void onIconPressed() {
    controller.text.isNotEmpty && icon == Icons.check;
  }

  void onTextChanged() {
    setState(() {
      if (controller.text.isEmpty) {
        icon = Icons.edit;
        iconColor;
      } else {
        icon = Icons.check;
        iconColor;
        onIconPressed();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(UserRepository())..start(),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state.isSaved) {
            context.read<UserCubit>().start();
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            final userModel = state.userModel;
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Witaj w profilu użytkownika!',
                      style: GoogleFonts.buenard(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (userModel != null) ...[
                      UserPhoto(
                        userModel: userModel,
                        onImageUrlChanged: (newValue) {
                          setState(() {
                            userModel.imageURL = newValue;
                          });
                        },
                      ),
                    ],
                    SizedBox(height: 20),
                    TextField(
                      style: GoogleFonts.buenard(
                        fontSize: 20,
                        color: Colors.yellow[400],
                        fontWeight: FontWeight.bold,
                      ),
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(255, 238, 88, 1),
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 67, 64, 64),
                            width: 2.0,
                          ),
                        ),
                        hintText: 'Wpisz swoje imię i nazwisko',
                        hintStyle: GoogleFonts.buenard(
                          fontSize: 20,
                          color: Colors.yellow[400],
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            icon,
                            color: iconColor,
                          ),
                          onPressed: icon == Icons.check ? onIconPressed : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserPhoto extends StatefulWidget {
  UserPhoto({
    super.key,
    required this.userModel,
    required this.onImageUrlChanged,
  });

  final UserModel userModel;
  Function(String) onImageUrlChanged;

  @override
  State<UserPhoto> createState() => _UserPhotoState();
}

class _UserPhotoState extends State<UserPhoto> {
  late String imageURL;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final imagePicker = ImagePicker();
        final XFile? file =
            await imagePicker.pickImage(source: ImageSource.gallery);

        if (file == null) return;

        final String uniqueFileName =
            DateTime.now().millisecondsSinceEpoch.toString();

        final Reference referenceRoot = FirebaseStorage.instance.ref();
        final Reference referenceDirImages =
            referenceRoot.child(uniqueFileName);

        final Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);

        try {
          await referenceImageToUpload.putFile(File(file.path));

          widget.userModel.imageURL =
              await referenceImageToUpload.getDownloadURL();
          widget.onImageUrlChanged(widget.userModel.imageURL!);
          context.read<UserCubit>().add(widget.userModel.imageURL!);
        } catch (error) {}
      },
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[300],
        child: widget.userModel.imageURL != null
            ? CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.userModel.imageURL!),
              )
            : Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.grey[600],
              ),
      ),
    );
  }
}
