import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_cubit.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/training/add_photos/add_photo.dart';
import 'package:lifediary_project/app/features/training/cubit/training_cubit.dart';

class TrainingPageContent extends StatelessWidget {
  const TrainingPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'TRENING',
            style: GoogleFonts.lato(
                color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
              ),
              icon: const Icon(Icons.add, color: Colors.blue),
              label: Text(
                'Dodaj zdjęcie',
                style: GoogleFonts.lato(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddPhoto(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
          ]),
      body: const NewPhoto(),
    );
  }
}

class NewPhoto extends StatelessWidget {
  const NewPhoto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainingCubit(PhotosRepository())..start(),
      child: BlocBuilder<TrainingCubit, TrainingState>(
        builder: (context, state) {
          final photosModels = state.photos;
          if (photosModels.isEmpty) {
            return const SizedBox.shrink();
          }
          return Container(
            color: Colors.blueAccent[700],
            child: ListView(
              children: [
                for (final photoModel in photosModels)
                  Dismissible(
                    key: ValueKey(photoModel.id),
                    background: const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 32.0),
                          child: Icon(
                            Icons.delete,
                          ),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return direction == DismissDirection.endToStart;
                    },
                    onDismissed: (direction) {
                      context
                          .read<TrainingCubit>()
                          .remove(documentID: photoModel.id);
                    },
                    child: ListViewItem(
                      photoModel: photoModel,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    Key? key,
    required this.photoModel,
  }) : super(key: key);

  final PhotosModel photoModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsPhotoPageContent(
              id: photoModel.id,
              photoModel: photoModel,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    image: DecorationImage(
                      image: NetworkImage(
                        photoModel.imageURL,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              photoModel.title,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              photoModel.releaseDateFormatted(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
