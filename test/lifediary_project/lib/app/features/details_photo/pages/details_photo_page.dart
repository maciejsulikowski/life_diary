import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
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
  void initState() {
    weightController.text = widget.photoModel.weight;
    heightController.text = widget.photoModel.height;
    newController.text = widget.photoModel.goals;
    super.initState();
  }

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
                    setState(() {
                      context.read<DetailsPhotoCubit>().savePhotoData(
                            widget.id,
                            weightController.text,
                            heightController.text,
                            newController.text,
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Wprowadzono zmiany!"),
                        ),
                      );
                    });
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
  _ListViewItem({
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
    return Column(children: [
      Expanded(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Container(
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
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: QuoteSentence(),
              )
            ],
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.green,
        child: TextField(
          controller: weightController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Podaj swoją wagę w kg',
          ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.green,
        child: TextField(
          controller: heightController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Podaj swój wzrost w cm',
          ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.green,
        child: TextField(
          controller: newController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Napisz swój cel',
          ),
        ),
      ),
    );
  }
}

class QuoteSentence extends StatelessWidget {
  QuoteSentence({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final quotes = [
      'Człowiek staje się tym, o czym myśli. Ralph Waldo Emerson',
      'Prawdziwe szczęście jest rzeczą wysiłku, odwagi i pracy. Honore de Balzac',
      'Początek jest najważniejszą częścią pracy. Platon',
      'Zwycięzcy robią to, czego przegranym się nie chciało. Jonathan Carroll',
      'Z uśmiechem na twarzy człowiek podwaja swoje możliwości. Przysłowie japońskie',
    ];
    final randomQuote = quotes[random.nextInt(quotes.length)];
    final parts = randomQuote.split('.');
    final quoteText = parts.first.trim() + '.';
    final author = parts.last.trim();

    final quoteSpans = <TextSpan>[
      TextSpan(text: quoteText),
      TextSpan(text: ' '),
      TextSpan(text: author, style: TextStyle(color: Colors.grey)),
    ];
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      children: quoteSpans,
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
