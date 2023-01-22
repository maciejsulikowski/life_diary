import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiariesPageContent extends StatelessWidget {
  const DiariesPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'LIFEDIARY',
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: Container(
              child: Text(
                'Utwórz dziennik, klikając przycisk poniżej',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
