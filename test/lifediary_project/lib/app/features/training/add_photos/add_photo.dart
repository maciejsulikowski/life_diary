import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/data/remote_data_sources/photos_remote_data_source.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';

import 'package:lifediary_project/app/features/training/add_photos/cubit/add_photo_cubit.dart';

import 'package:lifediary_project/app/domain/repositories/items_repository.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  String? _imageURL;
  String? _title;
  DateTime? _releaseDate;
  String weight = '';
  String height = '';
  String goals = '';
  late String imageURL;
  bool isTextHide = true;

  bool isTextFilled = false;
  bool isImageAdded = false;
  bool isTimeAdded = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPhotoCubit(PhotosRepository(PhotosRemoteDataSource())),
      child: BlocListener<AddPhotoCubit, AddPhotoState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }

          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddPhotoCubit, AddPhotoState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black87,
                centerTitle: true,
                title: Text(
                  'DODAJ NOWE ZDJĘCIE',
                  style: GoogleFonts.buenard(
                      fontSize: 22,
                      color: Colors.yellow[400],
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  Container(
                    color: _imageURL == null ||
                            _title == null ||
                            _releaseDate == null
                        ? Colors.red[700]
                        : Colors.green[700],
                    child: IconButton(
                        onPressed: _imageURL == null ||
                                _title == null ||
                                _releaseDate == null
                            ? null
                            : () {
                                context.read<AddPhotoCubit>().addphoto(
                                      _title!,
                                      _imageURL!,
                                      _releaseDate!,
                                      weight,
                                      height,
                                      goals,
                                    );
                              },
                        icon: Icon(Icons.check),
                        color: _imageURL == null ||
                                _title == null ||
                                _releaseDate == null
                            ? Colors.red[300]
                            : Colors.green[300]),
                  ),
                ],
              ),
              body: _AddPhotoBody(
                onTitleChanged: (newValue) {
                  setState(() {
                    _title = newValue;
                  });
                },
                onImageUrlChanged: (newValue) {
                  setState(() {
                    _imageURL = newValue;
                  });
                },
                onDateChanged: (newValue) {
                  setState(() {
                    _releaseDate = newValue;
                  });
                },
                selectedDateFormatted: _releaseDate == null
                    ? null
                    : DateFormat.yMMMEd().format(_releaseDate!),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddPhotoBody extends StatefulWidget {
  _AddPhotoBody({
    Key? key,
    required this.onTitleChanged,
    required this.onImageUrlChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onTitleChanged;
  final Function(String) onImageUrlChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  State<_AddPhotoBody> createState() => _AddPhotoBodyState();
}

class _AddPhotoBodyState extends State<_AddPhotoBody> {
  bool isPhotoHide = true;
  late String imageURL;
  bool isTextHide = true;

  bool isTextFilled = false;
  bool isImageAdded = false;
  bool isTimeAdded = false;
  bool fromGallery = false;
  bool fromPicker = false;
  @override
  void initState() {
    super.initState();
    imageURL = '';
  }

  void toogleButton() {
    isTextHide = !isTextHide;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                toogleButton();
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isTextFilled ? Colors.green[700] : Colors.red[700]),
            ),
            icon: const Icon(Icons.book, color: Colors.black),
            label: Text(
              'Dodaj tytuł zdjęcia',
              style: GoogleFonts.buenard(
                  fontSize: 22,
                  color: Colors.yellow[400],
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          if (isTextHide == false) ...[
            TextField(
              onChanged: (newValue) {
                widget.onTitleChanged(newValue);
                setState(() {
                  isTextFilled = newValue.isNotEmpty;
                });
              },
              style: GoogleFonts.buenard(
                fontSize: 20,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(255, 238, 88, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.yellow,
                  ),
                ),
                hintText: 'Np. Zdjęcie nr.1',
                label: Text(
                  'Dodaj tytuł zdjęcia',
                  style: GoogleFonts.buenard(
                      fontSize: 22,
                      color: Colors.yellow[400],
                      fontWeight: FontWeight.bold),
                ),
                labelStyle: GoogleFonts.buenard(
                  fontSize: 22,
                  color: Colors.yellow[400],
                  fontWeight: FontWeight.bold,
                ),
                hintStyle: GoogleFonts.buenard(
                    fontSize: 22,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(255, 238, 88, 1),
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (fromPicker == false) ...[
                Container(
                  width: 130,
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        isPhotoHide = false;
                      });
                      final imagePicker = ImagePicker();
                      final XFile? file = await imagePicker.pickImage(
                          source: ImageSource.camera);

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

                        imageURL =
                            await referenceImageToUpload.getDownloadURL();
                        widget.onImageUrlChanged(imageURL);
                        setState(() {
                          isImageAdded = imageURL.isNotEmpty;
                          if (isImageAdded) {
                            isPhotoHide = false;
                            fromGallery = true;
                          }
                        });
                      } catch (error) {}
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          isImageAdded ? Colors.green[700] : Colors.red[700]),
                    ),
                    icon: const Icon(Icons.camera_alt, color: Colors.black),
                    label: Text(
                      isImageAdded ? 'Zmień zdjęcie' : 'Zrób zdjęcie',
                      style: GoogleFonts.buenard(
                          fontSize: 22,
                          color: Colors.yellow[400],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              if (fromGallery == false) ...[
                Container(
                  height: 100,
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        isPhotoHide = false;
                      });

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

                        imageURL =
                            await referenceImageToUpload.getDownloadURL();
                        widget.onImageUrlChanged(imageURL);
                        setState(() {
                          isImageAdded = imageURL.isNotEmpty;
                          if (isImageAdded) {
                            isPhotoHide = false;
                            fromPicker = true;
                          }
                        });
                      } catch (error) {}
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          isImageAdded ? Colors.green[700] : Colors.red[700]),
                    ),
                    icon: const Icon(Icons.camera_alt, color: Colors.black),
                    label: Text(
                      isImageAdded ? 'Zmień zdjęcie' : 'Dodaj zdjęcie',
                      style: GoogleFonts.buenard(
                          fontSize: 22,
                          color: Colors.yellow[400],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]
            ],
          ),
          SizedBox(height: 20),
          if (isPhotoHide == false) ...[
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: NetworkImage(
                    imageURL,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  const Duration(days: 365 * 10),
                ),
              );
              widget.onDateChanged(selectedDate);
              setState(() {
                isTimeAdded = selectedDate.toString().isNotEmpty;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isTimeAdded ? Colors.green[700] : Colors.red[700]),
            ),
            icon: Icon(Icons.timer, color: Colors.black),
            label: Text(
              widget.selectedDateFormatted ?? 'Wybierz datę utworzenia zdjęcia',
              style: GoogleFonts.buenard(
                  fontSize: 22,
                  color: Colors.yellow[400],
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
