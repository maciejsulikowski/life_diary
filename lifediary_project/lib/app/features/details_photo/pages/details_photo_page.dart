import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_cubit.dart';
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_state.dart';
import 'package:lifediary_project/app/injection_container.dart';

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
      create: (context) => getIt<DetailsPhotoCubit>()..getPhotosID(widget.id),
      child: BlocBuilder<DetailsPhotoCubit, DetailsPhotoState>(
        builder: (context, state) {
          final photoModel = state.photosModel;
          if (state.status == Status.error) {
            return const CircularProgressIndicator();
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: Text(
                'ZDJĘCIA',
                style: GoogleFonts.buenard(
                    fontSize: 22,
                    color: Colors.yellow[400],
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      if (weightController.text.isEmpty ||
                          heightController.text.isEmpty ||
                          newController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    "Wprowadź wszystkie dane!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        return;
                      }
                      context.read<DetailsPhotoCubit>().savePhotoData(
                            widget.id,
                            weightController.text,
                            heightController.text,
                            newController.text,
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          content: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Icon(Icons.check_box, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  "Wprowadzono zmiany!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.indigo[700]),
                  ),
                  icon: Icon(Icons.check, color: Colors.yellow[400]),
                  label: Text(
                    'Zapisz',
                    style: GoogleFonts.buenard(
                        fontSize: 20,
                        color: Colors.yellow[400],
                        fontWeight: FontWeight.bold),
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
    return Column(children: [
      if (photoModel != null)
        Expanded(
          child: Container(
            color: Colors.black87,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.black87,
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
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Container(
                            color: Colors.indigo[700],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  photoModel!.title,
                                  style: GoogleFonts.buenard(
                                      fontSize: 22,
                                      color: Colors.yellow[400],
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  photoModel!.releaseDateFormatted(),
                                  style: GoogleFonts.buenard(
                                      fontSize: 18,
                                      color: Colors.yellow[400],
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
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      WeightSentence(
                        weightController: weightController,
                      ),
                      const SizedBox(height: 10),
                      HeightSentence(
                        heightController: heightController,
                      ),
                      const SizedBox(height: 10),
                      NewSentence(
                        newController: newController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
                // const Expanded(
                //   flex: 1,
                //   child: QuoteSentence(),
                // )
              ],
            ),
          ),
        ),
    ]);
  }
}

class WeightSentence extends StatefulWidget {
  const WeightSentence({
    Key? key,
    required this.weightController,
  }) : super(key: key);

  final TextEditingController weightController;

  @override
  State<WeightSentence> createState() => _WeightSentenceState();
}

class _WeightSentenceState extends State<WeightSentence> {
  bool showSuffix = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.weightController,
        style: GoogleFonts.buenard(
          fontSize: 20,
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(255, 238, 88, 1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(255, 238, 88, 1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.indigo[700],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: 'Podaj swoją wagę np. 80 kg',
          hintStyle: const TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
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
      child: TextField(
        controller: heightController,
        style: GoogleFonts.buenard(
            fontSize: 20, color: Colors.yellow, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(255, 238, 88, 1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(255, 238, 88, 1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.indigo[700],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: 'Podaj wzrost np. 180cm',
          hintStyle: const TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
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
      child: TextField(
        controller: newController,
        style: GoogleFonts.buenard(
            fontSize: 20, color: Colors.yellow, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(255, 238, 88, 1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(255, 238, 88, 1),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.indigo[700],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: 'Podaj swój cel np. Chcę schudnąć',
          hintStyle: const TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

// class QuoteSentence extends StatelessWidget {
//   const QuoteSentence({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final random = Random();
//     final quotes = [
//       'Człowiek staje się tym, o czym myśli. Ralph Waldo Emerson',
//       'Prawdziwe szczęście jest rzeczą wysiłku, odwagi i pracy. Honore de Balzac',
//       'Początek jest najważniejszą częścią pracy. Platon',
//       'Zwycięzcy robią to, czego przegranym się nie chciało. Jonathan Carroll',
//       'Z uśmiechem na twarzy człowiek podwaja swoje możliwości. Przysłowie japońskie',
//     ];
//     final randomQuote = quotes[random.nextInt(quotes.length)];
//     final parts = randomQuote.split('.');
//     final quoteText = '${parts.first.trim()}.';
//     final author = parts.last.trim();

//     final quoteSpans = <TextSpan>[
//       TextSpan(text: quoteText),
//       const TextSpan(text: ' '),
//       TextSpan(text: author, style: const TextStyle(color: Colors.grey)),
//     ];
//     return Column(
//       children: [
//         Expanded(
//           flex: 1,
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               color: Colors.black,
//               border: Border.all(
//                 color: Colors.white,
//                 width: 2,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Center(
//                 child: RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                       children: quoteSpans,
//                       style: const TextStyle(
//                           fontSize: 16,
//                           fontStyle: FontStyle.italic,
//                           color: Colors.white)),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
