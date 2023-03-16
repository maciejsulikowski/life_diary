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

class _AddPhotoBody extends StatelessWidget {
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
  final TextEditingController controller = TextEditingController(
      text:
          'Np: https://cdn.pixabay.com/photo/2012/04/13/14/16/address-32567_960_720.png');

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
          TextField(
            onChanged: onTitleChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Np. Zdjęcie nr. 1 ',
              label: Text(
                'Tytuł',
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ),
              hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: onImageUrlChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'https://cdn.pixabay.com/photo/2012/04/13/14/16/address-32567_960_720.png',
              label: Text(
                'Link URL obrazu',
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ),
              hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  const Duration(days: 365 * 10),
                ),
              );
              onDateChanged(selectedDate);
            },
            child: Text(selectedDateFormatted ?? 'Wybierz datę zdjęcia'),
          ),
        ],
      ),
    );
  }
}
