import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_olsztyn/app/home/restaurants/cubit/restaurants_cubit.dart';

class RestaurantsPageContent extends StatelessWidget {
  const RestaurantsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantsCubit(),
      child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Coś poszło nie tak: ${state.errorMessage}'),
            );
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = state.documents;

          return ListView(
            children: [
              for (final document in documents) ...[
                Dismissible(
                  key: ValueKey(document.id),
                  onDismissed: (_) {
                    FirebaseFirestore.instance
                        .collection('restaurants')
                        .doc(document.id)
                        .delete();
                  },
                  child: Container(
                    color: Colors.blue[400],
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                document['name'],
                                style: GoogleFonts.anton(
                                  fontSize: 20,
                                  color: Colors.purple[700],
                                ),
                              ),
                              Text(
                                document['pizza'],
                                style: GoogleFonts.anton(
                                  fontSize: 20,
                                  color: Colors.yellow[400],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            document['rating'].toString(),
                            style: GoogleFonts.lato(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ],
          );

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("restaurants")
                  .orderBy('rating', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Coś poszło nie tak'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('Ładujemy'));
                }

                final documents = snapshot.data!.docs;

                return ListView(
                  children: [
                    for (final document in documents) ...[
                      Dismissible(
                        key: ValueKey(document.id),
                        onDismissed: (_) {
                          FirebaseFirestore.instance
                              .collection('restaurants')
                              .doc(document.id)
                              .delete();
                        },
                        child: Container(
                          color: Colors.blue[400],
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document['name'],
                                      style: GoogleFonts.anton(
                                        fontSize: 20,
                                        color: Colors.purple[700],
                                      ),
                                    ),
                                    Text(
                                      document['pizza'],
                                      style: GoogleFonts.anton(
                                        fontSize: 20,
                                        color: Colors.yellow[400],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  document['rating'].toString(),
                                  style: GoogleFonts.lato(fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ],
                );
              });
        },
      ),
    );
  }
}
