import 'package:ds304/screens/blog_add.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Blog'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BlogInputScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit_rounded),
          ),
        ],
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlogCard(
                title: 'Express Js',
                content:
                    'Express.js, or simply Express, is a back end web application framework for building RESTful APIs with Node.js, released as free and open-source software under the MIT License. It is designed for building web applications and APIs. It has been called the de facto standard server framework for Node.js.',
                imageUrl:
                    'https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              ),
              BlogCard(
                title: 'Node Js',
                content:
                    "Node.js lets developers use JavaScript to write command line tools and for server-side scripting. The ability to run JavaScript code on the server is often used to generate dynamic web page content before the page is sent to the user's web browser. Consequently, Node.js represents a JavaScript everywhere paradigm, unifying web-application development around a single programming language, as opposed to using different languages for the server- versus client-side programming.",
                imageUrl:
                    'https://blog.appsignal.com/_next/image?url=%2Fimages%2Fblog%2F2022-04%2Fnode18.png&w=1200&q=50',
              ),
              BlogCard(
                title: 'Express Js',
                content:
                    'Express.js, or simply Express, is a back end web application framework for building RESTful APIs with Node.js, released as free and open-source software under the MIT License. It is designed for building web applications and APIs. It has been called the de facto standard server framework for Node.js.',
                imageUrl:
                    'https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              ),
              BlogCard(
                title: 'Node Js',
                content:
                    "Node.js lets developers use JavaScript to write command line tools and for server-side scripting. The ability to run JavaScript code on the server is often used to generate dynamic web page content before the page is sent to the user's web browser. Consequently, Node.js represents a JavaScript everywhere paradigm, unifying web-application development around a single programming language, as opposed to using different languages for the server- versus client-side programming.",
                imageUrl:
                    'https://blog.appsignal.com/_next/image?url=%2Fimages%2Fblog%2F2022-04%2Fnode18.png&w=1200&q=50',
              ),
              BlogCard(
                title: 'Express Js',
                content:
                    'Express.js, or simply Express, is a back end web application framework for building RESTful APIs with Node.js, released as free and open-source software under the MIT License. It is designed for building web applications and APIs. It has been called the de facto standard server framework for Node.js.',
                imageUrl:
                    'https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              ),
              BlogCard(
                title: 'Node Js',
                content:
                    "Node.js lets developers use JavaScript to write command line tools and for server-side scripting. The ability to run JavaScript code on the server is often used to generate dynamic web page content before the page is sent to the user's web browser. Consequently, Node.js represents a JavaScript everywhere paradigm, unifying web-application development around a single programming language, as opposed to using different languages for the server- versus client-side programming.",
                imageUrl:
                    'https://blog.appsignal.com/_next/image?url=%2Fimages%2Fblog%2F2022-04%2Fnode18.png&w=1200&q=50',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const BlogCard({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.only(left: 12, right: 12, top: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                title: title,
                content: content,
                imageUrl: imageUrl,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 250,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 0, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      content,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 8, top: 8),
              child: Container(
                width: 120,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const DetailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
