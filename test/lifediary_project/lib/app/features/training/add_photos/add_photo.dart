import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      create: (context) => AddPhotoCubit(ItemsRepository()),
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
                centerTitle: true,
                title: const Text(
                  'DODAJ NOWE ZDJĘCIE',
                  style: TextStyle(color: Colors.amber),
                ),
                actions: [
                  IconButton(
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
                    icon: const Icon(Icons.check),
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
  @override
  void initState() {
    super.initState();
    imageURL = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                isTextHide = false;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isTextFilled ? Colors.green : Colors.red),
            ),
            icon: const Icon(Icons.book, color: Colors.black),
            label: const Text(
              'Dodaj tytuł zdjęcia',
              style: TextStyle(fontSize: 20),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Np. Dziennik Treningowy',
                label: Text(
                  'Dodaj tytuł zdjęcia',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                ),
                hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                isPhotoHide = false;
              });
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

                imageURL = await referenceImageToUpload.getDownloadURL();
                widget.onImageUrlChanged(imageURL);
                setState(() {
                  isImageAdded = imageURL.isNotEmpty;
                });
              } catch (error) {}
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isImageAdded ? Colors.green : Colors.red),
            ),
            icon: const Icon(Icons.camera_alt, color: Colors.black),
            label: Text(
              isImageAdded ? 'Zmień zdjęcie' : 'Dodaj zdjęcie',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 40),
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
                  isTimeAdded ? Colors.green : Colors.red),
            ),
            icon: Icon(Icons.timer, color: Colors.black),
            label: Text(
              widget.selectedDateFormatted ?? 'Wybierz datę utworzenia zdjęcia',
            ),
          ),
        ],
      ),
    );
  }
}
