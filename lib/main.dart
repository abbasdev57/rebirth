import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'builders.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}

httpEx(){
  // Example of an HTTP request using the http package




  // http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')).then((response) {
  //   if (response.statusCode == 200) {
  //     print('Response data: ${response.body}');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // });
}

class HomePage extends StatelessWidget {
   const HomePage({super.key});



  @override
  Widget build(BuildContext context) {

    var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    var response = http.get(url);
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter App')),
      body: Column(
        children: [
          const Center(
            child: Text('Hello, Flutter!', style: TextStyle(fontSize: 24)),
          ),
          // google_fonts package usage

          Row(
            children: [
              Text(
                'Using Google Fonts',
                style: GoogleFonts.numans(fontSize: 20, color: Colors.blue),
              ),
              Text('Custom Font Example',
                  style: TextStyle(fontFamily:'RusticRoadway', fontSize: 20, color: Colors.black)),
            ],
          ),
          const SizedBox(height: 20),
          Image.asset('assets/images/image3.jpg'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to perform when the button is pressed
        //   move to another page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FBuilder()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
