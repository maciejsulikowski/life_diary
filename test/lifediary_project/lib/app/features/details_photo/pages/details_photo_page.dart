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
  final controller = TextEditingController();

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
            ),
            body: _ListViewItem(
              photoModel: photoModel,
              controller: controller,
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
    required this.controller,
  }) : super(key: key);

  final PhotosModel? photoModel;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        color: Colors.blueAccent[700],
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
                WriteSentence(controller: controller),
                SizedBox(height: 20),
                WriteSentence(controller: controller),
                SizedBox(height: 20),
                WriteSentence(controller: controller),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class WriteSentence extends StatelessWidget {
  const WriteSentence({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Write something here...',
          ),
        ),
      ],
    );
  }
}
