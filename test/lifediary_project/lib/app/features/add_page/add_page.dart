import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';

import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? imageURL;
  String? _title;
  DateTime? _releaseDate;
  String text = '';
  int fontWeight = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ItemsRepository()),
      child: BlocListener<AddCubit, AddState>(
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
        child: BlocBuilder<AddCubit, AddState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                actions: [
                  Container(
                    color: imageURL == null ||
                            _title == null ||
                            _releaseDate == null
                        ? Colors.red
                        : Colors.green,
                    child: IconButton(
                      onPressed: imageURL == null ||
                              _title == null ||
                              _releaseDate == null
                          ? null
                          : () {
                              context.read<AddCubit>().add(
                                    _title!,
                                    imageURL!,
                                    _releaseDate!,
                                    text,
                                    fontWeight,
                                  );
                            },
                      icon: Icon(Icons.check,
                          color: imageURL == null ||
                                  _title == null ||
                                  _releaseDate == null
                              ? Color.fromARGB(255, 148, 14, 5)
                              : Color.fromARGB(255, 0, 76, 3)),
                    ),
                  ),
                ],
              ),
              body: _AddPageBody(
                onTitleChanged: (newValue) {
                  setState(() {
                    _title = newValue;
                  });
                },
                onImageUrlChanged: (newValue) {
                  setState(() {
                    imageURL = newValue;
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

class _AddPageBody extends StatefulWidget {
  _AddPageBody({
    Key? key,
    required this.onTitleChanged,
    required this.onImageUrlChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onTitleChanged;
  Function(String) onImageUrlChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  State<_AddPageBody> createState() => _AddPageBodyState();
}

class _AddPageBodyState extends State<_AddPageBody> {
  late String imageURL;
  bool isTextHide = true;
  bool isPhotoHide = true;
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
                isTextHide = false;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isTextFilled ? Colors.green : Colors.red),
            ),
            icon: const Icon(Icons.book, color: Colors.black),
            label: const Text(
              'Dodaj tytuł dziennika',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
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
                  'Dodaj tytuł dziennika',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                ),
                hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
          SizedBox(
            height: 20,
          ),
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
          const SizedBox(height: 20),
          if (isPhotoHide == false) ...[
            Container(
              height: 200,
              width: 100,
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
          const SizedBox(height: 20),
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
              widget.selectedDateFormatted ??
                  'Wybierz datę utworzenia dziennika',
            ),
          ),
        ],
      ),
    );
  }
}
