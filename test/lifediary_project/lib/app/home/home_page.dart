import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

LoginPage moveToLogin() {
  return LoginPage();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 1) {
          return Center(
            child: Text('2'),
          );
        }
        if (currentIndex == 2) {
          return Center(
            child: Text('3'),
          );
        }
        if (currentIndex == 3) {
          return Center(
            child: Text('4'),
          );
        }
        if (currentIndex == 4) {
          return ToDoListContent();
        }
        if (currentIndex == 5) {
          return Center(
            child: Text('6'),
          );
        }
        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Konto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Dziennik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics_rounded),
            label: 'Trening',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Woda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'To Do List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: 'Plan dnia',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Zalogowano jako $email! '),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                //moveToLogin();
                //Navigator.of(context).pop();
                // Navigator.pushNamed(context, '/login');
              },
              child: const Text('Wyloguj')),
        ],
      ),
    );
  }
}

class ToDoListContent extends StatelessWidget {
  ToDoListContent({
    Key? key,
  }) : super(key: key);

  @override
  final controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIFEDIARY',
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('categories').add(
            {
              'title': controller.text,
            },
          );
          controller.clear();
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Wystapil blad');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Prosze czekac, trwa ladowanie');
            }

            final documents = snapshot.data!.docs;
            return ListView(
              children: [
                for (final document in documents) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('categories')
                          .doc(document.id)
                          .delete();
                    },
                    child: CategoryWidget(
                      document['title'],
                    ),
                  ),
                ],
                TextField(controller: controller),
              ],
            );
          }),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Text(title),
    );
  }
}
