import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'INSTRUCTION PAGE',
          style: GoogleFonts.lato(
              color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/math.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text('Konto',
                        style: GoogleFonts.lato(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text(' - kliknij w',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const Icon(Icons.person),
                    Text('aby sprawdzić informację o koncie użytkownika!',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(height: 30),
                    Text('Dziennik',
                        style: GoogleFonts.lato(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text(' - kliknij w ',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const Icon(Icons.book),
                    Text('aby móc stworzyć swoje własne dzienniki!',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(height: 30),
                    Text('Trening',
                        style: GoogleFonts.lato(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text(' - kliknij w',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const Icon(Icons.sports_martial_arts),
                    Text(
                        'aby móc dodawać swoje zdjęcia i później je porównywać!',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(height: 30),
                    Text('Woda',
                        style: GoogleFonts.lato(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text(' - kliknij w',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const Icon(Icons.water_drop),
                    Text('aby móc dowiedzieć się ile powinienieś pić wody!',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(height: 30),
                    Text('ToDoList',
                        style: GoogleFonts.lato(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text(' - kliknij w',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const Icon(Icons.list_alt),
                    Text(
                        'aby móc zrobić listę zadań i przesuń w lewo bądź w prawo, żeby je usunąć!',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(height: 30),
                    Text('Plan dnia',
                        style: GoogleFonts.lato(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text(' - kliknij w',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const Icon(Icons.lock_clock),
                    Text(
                        'aby móc zaplanować swój dzień dodając swój własny plan!',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
