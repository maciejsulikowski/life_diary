import 'dart:io';

import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/data/remote_data_sources/items_remote_data_source.dart';
import 'dart:core';

import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_state.dart';

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
  quill.Delta text = quill.Delta()..insert('Write something...\n\n');

  int fontWeight = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ItemsRepository(ItemsRemoteDataSource())),
      child: BlocListener<AddCubit, AddState>(
        listener: (context, state) {
          if (state.isSaved) {
            Navigator.of(context).pop();
          }
          final errorMessage = state.errorMessage ?? 'Unknown error';
          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddCubit, AddState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black87,
                title: Text(
                  'DODAJ DZIENNIK',
                  style: GoogleFonts.buenard(
                      fontSize: 22,
                      color: Colors.yellow[400],
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: [
                  Container(
                    color: imageURL == null ||
                            _title == null ||
                            _releaseDate == null
                        ? Colors.red[700]
                        : Colors.green[700],
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
              'Dodaj tytuł dziennika',
              style: GoogleFonts.buenard(
                  fontSize: 22,
                  color: Colors.yellow[400],
                  fontWeight: FontWeight.bold),
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
              style: GoogleFonts.buenard(
                fontSize: 20,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(255, 238, 88, 1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.yellow,
                  ),
                ),
                hintText: 'Np. Dziennik Treningowy',
                labelText: 'Dodaj tytuł dziennika',
                labelStyle: GoogleFonts.buenard(
                  fontSize: 22,
                  color: Colors.yellow[400],
                  fontWeight: FontWeight.bold,
                ),
                hintStyle: GoogleFonts.buenard(
                  fontSize: 20,
                  color: Colors.yellow[400],
                  fontWeight: FontWeight.bold,
                ),
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
                  isTimeAdded ? Colors.green[700] : Colors.red[700]),
            ),
            icon: Icon(Icons.timer, color: Colors.black),
            label: Text(
              widget.selectedDateFormatted ??
                  'Wybierz datę utworzenia dziennika',
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
