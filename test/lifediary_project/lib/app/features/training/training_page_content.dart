import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';
import 'package:lifediary_project/app/features/training/add_photos/add_photo.dart';
import 'package:lifediary_project/app/features/training/cubit/training_cubit.dart';
import 'package:lifediary_project/app/features/training/cubit/training_state.dart';
import 'package:lifediary_project/app/injection_container.dart';

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
            style: GoogleFonts.buenard(
                fontSize: 22,
                color: Colors.yellow[400],
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black87,
          centerTitle: true,
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo[700]),
              ),
              icon: Icon(Icons.add, color: Colors.yellow[400]),
              label: Text(
                'Dodaj zdjęcie',
                style: GoogleFonts.buenard(
                    fontSize: 20,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold),
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
      create: (context) => getIt<TrainingCubit>()..start(),
      child: BlocBuilder<TrainingCubit, TrainingState>(
        builder: (context, state) {
          final photosModels = state.photos;
          if (photosModels.isEmpty) {
            return Scaffold(
                body: Container(
              color: Colors.black87,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Dodaj zdjęcie',
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 22,
                          fontFamily: GoogleFonts.buenard().fontFamily,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'klikając przycisk powyżej 👆',
                        style: TextStyle(
                          color: Colors.yellow[400],
                          fontSize: 22,
                          fontFamily: GoogleFonts.buenard().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }
          return Container(
            color: Colors.black87,
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
                  height: 300,
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
                        color: Colors.indigo[700],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              photoModel.title,
                              style: GoogleFonts.buenard(
                                  fontSize: 22,
                                  color: Colors.yellow[400],
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              photoModel.releaseDateFormatted(),
                              style: GoogleFonts.buenard(
                                  fontSize: 18,
                                  color: Colors.yellow[400],
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
