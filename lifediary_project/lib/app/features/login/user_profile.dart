// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable, duplicate_ignore

import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/features/login/cubit/user_cubit.dart';
import 'package:lifediary_project/app/features/login/cubit/user_state.dart';
import 'package:lifediary_project/app/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isCubitStarted = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>.value(
      value: getIt<UserCubit>()..start(),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state.isSaved) {
            context.read<UserCubit>().start();
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            var userModel = state.userModel;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.user_page,
                  style: GoogleFonts.buenard(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                centerTitle: true,
                backgroundColor: Colors.black87,
              ),
              body: UserView(
                userModel: userModel,
                onFullNameChanged: (newValue) {
                  setState(() {
                    final updatedUserModel =
                        userModel?.copyWith(fullName: newValue);
                    userModel = updatedUserModel;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserView extends StatefulWidget {
  UserModel? userModel;
  Function(String) onFullNameChanged;

  UserView({
    Key? key,
    required this.userModel,
    required this.onFullNameChanged,
  });

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late TextEditingController controller;
  late TextEditingController storyController;
  late IconData icon;
  late Color iconColor;

  @override
  void initState() {
    controller = TextEditingController();
    storyController = TextEditingController();
    icon = Icons.edit;
    iconColor = Colors.yellow[400]!;
    controller.addListener(onTextChanged);
    super.initState();
  }

  void onFullNamePressed() {
    if (controller.text.isNotEmpty) {
      context.read<UserCubit>().addFullName(controller.text);
      _showSnackbar(
        AppLocalizations.of(context)!.change_name,
      );
    } else {
      _showSnackbar(
        AppLocalizations.of(context)!.change_some,
      );
    }
  }

  void onStoryTextPressed() {
    if (controller.text.isNotEmpty) {
      context.read<UserCubit>().addStoryText(storyController.text);
      _showSnackbar(
        AppLocalizations.of(context)!.change_name,
      );
    } else {
      _showSnackbar(
        AppLocalizations.of(context)!.change_some,
      );
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
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
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTextChanged() {
    setState(() {
      if (controller.text.isEmpty) {
        icon = Icons.edit;
        iconColor;
      } else {
        icon = Icons.check;
        iconColor;
      }
    });
  }

  @override
  void didUpdateWidget(UserView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.userModel != oldWidget.userModel) {
      controller.text = widget.userModel?.fullName ?? '';
      storyController.text = widget.userModel?.storyText ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.intro,
              style: GoogleFonts.buenard(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (widget.userModel != null) ...[
              UserPhoto(
                userModel: widget.userModel!,
                onImageUrlChanged: (newValue) {
                  setState(() {
                    final updatedUserModel =
                        widget.userModel!.copyWith(imageURL: newValue);
                    widget.userModel = updatedUserModel;
                  });
                },
              ),
            ],
            const SizedBox(height: 20),
            TextField(
              style: GoogleFonts.buenard(
                fontSize: 20,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold,
              ),
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(255, 238, 88, 1),
                    width: 2.0,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 67, 64, 64),
                    width: 2.0,
                  ),
                ),
                hintText: AppLocalizations.of(context)!.intro_name,
                hintStyle: GoogleFonts.buenard(
                  fontSize: 20,
                  color: Colors.yellow[400],
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    icon,
                    color: iconColor,
                  ),
                  onPressed: icon == Icons.check ? onFullNamePressed : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              style: GoogleFonts.buenard(
                fontSize: 20,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold,
              ),
              maxLines: null, // Pozwala na dowolną liczbę linii
              keyboardType: TextInputType
                  .multiline, // Pozwala na wpisywanie w wielu liniach
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction
                  .newline, // Włącza przycisk nowej linii na klawiaturze
              controller: storyController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(255, 238, 88, 1),
                    width: 2.0,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 67, 64, 64),
                    width: 2.0,
                  ),
                ),
                hintText: AppLocalizations.of(context)!.intro_self,
                hintStyle: GoogleFonts.buenard(
                  fontSize: 20,
                  color: Colors.yellow[400],
                  fontWeight: FontWeight.bold,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    icon,
                    color: iconColor,
                  ),
                  onPressed: icon == Icons.check ? onStoryTextPressed : null,
                ),
              ),
            ),
          ],
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

  UserModel userModel;
  Function(String) onImageUrlChanged;

  @override
  State<UserPhoto> createState() => _UserPhotoState();
}

class _UserPhotoState extends State<UserPhoto> {
  bool isLoading = false;
  static const String defaultImageUrl =
      'https://example.com/default_profile_image.jpg';

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

        final Reference referenceRoot =
            await context.read<UserCubit>().pathRef();
        final Reference referenceDirImages =
            referenceRoot.child(uniqueFileName);

        final Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);

        try {
          setState(() {
            isLoading = true;
          });

          await referenceImageToUpload.putFile(File(file.path));
          final imageUrl = await referenceImageToUpload.getDownloadURL();
          setState(() {
            final updatedUserModel =
                widget.userModel.copyWith(imageURL: imageUrl);
            widget.userModel = updatedUserModel;
            isLoading = false; //
          });
          widget.onImageUrlChanged(imageUrl);
          context.read<UserCubit>().add(imageUrl);
        } catch (error) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.black,
            backgroundImage: widget.userModel.imageURL != null
                ? NetworkImage(widget.userModel.imageURL)
                : NetworkImage(defaultImageUrl),
          ),
          if (isLoading)
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.black,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
