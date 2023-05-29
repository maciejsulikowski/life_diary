import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
  });

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late String imageURL;
  late Function(String) onImageUrlChanged = setImageUrl;
  bool isPhotoAdded = false;
  @override
  void initState() {
    super.initState();
    imageURL = '';
  }

  void setImageUrl(String url) {
    setState(() {
      imageURL = url;
    });
  }

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
      body: Container(
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
              if (isPhotoAdded) ...[
                InkWell(
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    if (file == null) return;

                    final String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    final Reference referenceRoot =
                        FirebaseStorage.instance.ref();
                    final Reference referenceDirImages =
                        referenceRoot.child(uniqueFileName);

                    final Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    try {
                      await referenceImageToUpload.putFile(File(file.path));

                      imageURL = await referenceImageToUpload.getDownloadURL();
                      onImageUrlChanged(imageURL);
                    } catch (error) {}
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(imageURL),
                  ),
                ),
              ],
              if (isPhotoAdded == false) ...[
                InkWell(
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    if (file == null) return;

                    final String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    final Reference referenceRoot =
                        FirebaseStorage.instance.ref();
                    final Reference referenceDirImages =
                        referenceRoot.child(uniqueFileName);

                    final Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    try {
                      await referenceImageToUpload.putFile(File(file.path));

                      imageURL = await referenceImageToUpload.getDownloadURL();
                      onImageUrlChanged(imageURL);
                      setState(() {
                        isPhotoAdded = true;
                      });
                    } catch (error) {}
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
