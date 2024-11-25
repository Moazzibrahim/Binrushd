import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/fetch_posts_provider.dart';
import 'package:provider/provider.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({super.key});

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch posts when the screen loads
    Provider.of<FetchPostsProvider>(context, listen: false).fetchPosts(context);
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<FetchPostsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('مقالات صحية'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: postsProvider.postResponse == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : postsProvider.postResponse!.data.isEmpty
              ? const Center(
                  child: Text(
                    'لا توجد مقالات حالياً.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: postsProvider.postResponse!.data.length,
                    itemBuilder: (context, index) {
                      final article = postsProvider.postResponse!.data[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Article image
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(article.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Article title
                            Text(
                              article.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Article content
                            Text(
                              article.content,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
