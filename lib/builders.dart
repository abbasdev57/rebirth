import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FBuilder extends StatelessWidget {
  const FBuilder({super.key});

  Future<Map<String, dynamic>> fetchData() {
    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{flutter}'});
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    });
  }
  // publishedDatee is in volumeInfo inside of items
  // subtitle  title description page Count  imageLinks then smallThumbnail or thumbnail

  // pdf -> previewLink

  // in item -> pdf -> isAvailable, acsTokenLink

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder <Map<String,dynamic>>(future: fetchData(), builder: (context,snapshot){
        if(snapshot.connectionState== ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No data found'));
        } else {
          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data['items']?.length ?? 0,
            itemBuilder: (context, index) {
              final item = data['items'][index];
              return ListTile(
                title: Text(item['volumeInfo']['title'] ?? 'No title'),
                subtitle: Text(item['volumeInfo']['authors']?.join(', ') ?? 'No authors'),
              );
            },
          );
        }
      }),
    );
  }
}
