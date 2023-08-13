import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/features/details/cubit/details_cubit.dart';
import 'package:lifediary_project/app/features/details/cubit/details_state.dart';
import 'package:lifediary_project/app/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late quill.QuillController betterController;

  @override
  void initState() {
    super.initState();
    betterController = quill.QuillController.basic();
    betterController.document = quill.Document.fromJson(widget.itemModel.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DetailsCubit>()
            ..getItemWithID(widget.id),
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
                        AppLocalizations.of(context)!.savee,
                        style: GoogleFonts.buenard(
                            fontSize: 20,
                            color: Colors.yellow[400],
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (betterController.document.isEmpty()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              content:  Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.error, color: Colors.white),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!.change_some,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
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
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              content:  Padding(
                                padding:const  EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_box, color: Colors.white),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!.change_name,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
  const _DiaryPage({
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
              Container(
                color: Colors.grey[300],
                child: quill.QuillToolbar.basic(
                  controller: widget.betterController,
                  iconTheme: const quill.QuillIconTheme(
                      borderRadius: 16, iconUnselectedColor: Colors.black87),
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
