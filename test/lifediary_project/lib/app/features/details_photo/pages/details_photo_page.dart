import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_cubit.dart';

class DetailsPhotoPageContent extends StatefulWidget {
  const DetailsPhotoPageContent({
    required this.photoModel,
    required this.id,
    Key? key,
  }) : super(key: key);

  final PhotosModel photoModel;
  final String id;

  @override
  State<DetailsPhotoPageContent> createState() =>
      _DetailsPhotoPageContentState();
}

class _DetailsPhotoPageContentState extends State<DetailsPhotoPageContent> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final newController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsPhotoCubit(ItemsRepository())..getPhotosID(widget.id),
      child: BlocBuilder<DetailsPhotoCubit, DetailsPhotoState>(
        builder: (context, state) {
          final photoModel = state.photoModel;
          if (state.isLoading == true) {
            return CircularProgressIndicator();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('lysy'),
              actions: [
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {});
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  icon: const Icon(Icons.check, color: Colors.black),
                  label: Text(
                    'Zapisz zmiany',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            body: _ListViewItem(
              photoModel: photoModel,
              weightController: weightController,
              heightController: heightController,
              newController: newController,
            ),
          );
        },
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    Key? key,
    required this.photoModel,
    required this.weightController,
    required this.heightController,
    required this.newController,
  }) : super(key: key);

  final PhotosModel? photoModel;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController newController;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
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
                        photoModel!.imageURL,
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
                              photoModel!.title,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              photoModel!.releaseDateFormatted(),
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
                SizedBox(height: 20),
                WeightSentence(
                  weightController: weightController,
                ),
                SizedBox(height: 20),
                HeightSentence(
                  heightController: heightController,
                ),
                SizedBox(
                  height: 20,
                ),
                NewSentence(
                  newController: newController,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class WeightSentence extends StatelessWidget {
  const WeightSentence({
    super.key,
    required this.weightController,
  });

  final TextEditingController weightController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: TextField(
        controller: weightController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Podaj swoją wagę',
        ),
      ),
    );
  }
}

class HeightSentence extends StatelessWidget {
  const HeightSentence({
    super.key,
    required this.heightController,
  });

  final TextEditingController heightController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: TextField(
        controller: heightController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Podaj swój wzrost',
        ),
      ),
    );
  }
}

class NewSentence extends StatelessWidget {
  const NewSentence({
    super.key,
    required this.newController,
  });

  final TextEditingController newController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: TextField(
        controller: newController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Napisz swój cel',
        ),
      ),
    );
  }
}
