import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rebirth/forms.dart';
import 'package:rebirth/my_rp/my_riverpod.dart';
import 'builders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // get screen size
    var screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(child: MaterialApp(
        routes: {
          '/': (context) => const HomePage(),
          '/river': (context) => const RiverApp(),
          '/builder': (context) => const FBuilder(),
        },
        // home: const HomePage()
    ));
  }
}

httpEx() {
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
    var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': '{http}',
    });
    var response = http.get(url);
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter App')),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  //using named routes
                  Navigator.pushNamed(context, '/river');
                  //
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const RiverApp()),
                  // );
                },
                child: Text('RiverApp'),
              ),
              Flexible(
                flex: 2,
                child: Text('Hello, Flutter!', style: TextStyle(fontSize: 24)),
              ),
              // 411.4,914.3
              Text(
                MediaQuery.of(context).size.toString(),
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          // google_fonts package usage
          Row(
            children: [
              Text(
                'Using Google Fonts',
                style: GoogleFonts.numans(fontSize: 20, color: Colors.blue),
              ),
              Text(
                'Custom Font Example',
                style: TextStyle(
                  fontFamily: 'RusticRoadway',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Image.asset('assets/images/image3.jpg'),
          Row(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Forms()));
              }, child: Text('Forms'))
            ],
          )
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
