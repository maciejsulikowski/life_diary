import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/data/remote_data_sources/items_remote_data_source.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/details/cubit/details_cubit.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class DetailsPageContent extends StatefulWidget {
  const DetailsPageContent({
    required this.itemModel,
    required this.id,
    Key? key,
  }) : super(key: key);

  final ItemModel itemModel;
  final String id;

  @override
  State<DetailsPageContent> createState() => _DetailsPageContentState();
}

class _DetailsPageContentState extends State<DetailsPageContent> {
  final controller = TextEditingController();
  final betterController = quill.QuillController.basic();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      betterController.document.insert(0, widget.itemModel.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsCubit(ItemsRepository(ItemsRemoteDataSource()))..getItemWithID(widget.id),
      child: BlocListener<DetailsCubit, DetailsState>(
        listener: (context, state) {},
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            final itemModel = state.itemModel;
            if (state.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'LIFEDIARY',
                    style: GoogleFonts.buenard(
                        fontSize: 22,
                        color: Colors.yellow[400],
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[700]),
                      ),
                      icon: Icon(Icons.add, color: Colors.yellow[400]),
                      label: Text(
                        'Zapisz',
                        style: GoogleFonts.buenard(
                            fontSize: 20,
                            color: Colors.yellow[400],
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (betterController.document.isEmpty()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Wprowadź jakieś zadanie!"),
                            ),
                          );
                          return;
                        } else {
                          final updatedText =
                              betterController.document.toDelta();
                          context
                              .read<DetailsCubit>()
                              .addtext(widget.id, updatedText);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Wprowadzono zmiany!"),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                  centerTitle: true,
                  backgroundColor: Colors.black87,
                ),
                body: Column(
                  children: [
                    if (itemModel != null) ...[
                      _ListViewItem(
                        itemModel: itemModel,
                      ),
                      Expanded(
                        child: _DiaryPage(
                          betterController: betterController,
                        ),
                      ),
                    ],
                  ],
                ));
          },
        ),
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.indigo[700],
            ),
            child: Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        itemModel.imageURL,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        itemModel.title,
                        style: GoogleFonts.buenard(
                            fontSize: 22,
                            color: Colors.yellow[400],
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.book, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DiaryPage extends StatefulWidget {
  _DiaryPage({
    Key? key,
    required this.betterController,
  }) : super(key: key);

  final quill.QuillController betterController;

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<_DiaryPage> {
  bool isBold = false;
  bool isColored = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        return Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  color: Colors.grey[300],
                  child: quill.QuillToolbar.basic(
                    controller: widget.betterController,
                    iconTheme: quill.QuillIconTheme(
                        borderRadius: 16, iconUnselectedColor: Colors.black87),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: quill.QuillEditor.basic(
                        controller: widget.betterController, readOnly: false),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
