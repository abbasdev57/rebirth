import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ab.dart';

class FBuilder extends StatelessWidget {
  const FBuilder({super.key});

  Future<Map<String, dynamic>> fetchData() {
    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': '{flutter}',
    });
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
    return Scaffold(
      appBar: AppBar(title: Text('Book Details'), centerTitle: true),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                final volumeInfo = item['volumeInfo'];
                final title = volumeInfo['title'] ?? 'No title';
                final subtitle = volumeInfo['subtitle'] ?? 'No subtitle';

                final description =
                    volumeInfo['description'] ?? 'No description';
                final pageCount =
                    volumeInfo['pageCount']?.toString() ?? 'No page count';
                final imageLinks = volumeInfo['imageLinks'];
                final iLink = imageLinks['thumbnail'] ?? 'No image';
                final previewLink =
                    item['volumeInfo']['previewLink'] ?? 'No preview link';
                final publishedDate =
                    item['volumeInfo']['publishedDate'] ?? 'No published date';
                final pdf = item['volumeInfo']['pdf'];
                // final isAvailable = pdf != null ? pdf['isAvailable'] ?? false : false;
                final acsTokenLink = pdf != null
                    ? pdf['acsTokenLink'] ?? 'No ACS token link'
                    : 'No ACS token link';
                // return Details(title: title, subtitle: subtitle) ;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          title: title,
                          subtitle: subtitle,
                          publishedDate: publishedDate,
                          pages: pageCount,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(iLink),
                    title: Text(title),
                    subtitle: Text(subtitle),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.title,
    required this.subtitle,
    required this.publishedDate,
    required this.pages,
  });

  final String title, subtitle, publishedDate, pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/image3.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text("Published: $publishedDate"),
            Text(title),
            Text(subtitle),
            //   horizontal line with padding
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: Colors.grey, thickness: 1.0),
            ),

            // Add more details here as needed
            Text('Pages: $pages'),

            Container(
              margin: EdgeInsets.all(4),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement download PDF functionality here
                  // You can use the acsTokenLink to download the PDF
                  print('Download PDF button pressed');
                },
                child: Text('Download PDF'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue
                    ,shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.amberAccent,
                ),
                Text('Abbas'),
                CircleAvatar(
                  radius: 150,

                  backgroundColor: Colors.blue,
                  child: Image.asset('assets/images/image3.jpg'),
                ),
                Positioned(
                  top: 250,
                  left: 100,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
