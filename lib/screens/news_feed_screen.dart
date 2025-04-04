import 'package:flutter/material.dart';
import '../models/news_article.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy news data
    final news = [
      NewsArticle(
        title: 'Breaking News',
        content: 'This is a sample news article.',
        time: '2 hours ago',
      ),
      NewsArticle(
        title: 'Technology Update',
        content: 'New features have been released.',
        time: '5 hours ago',
      ),
    ];

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final article = news[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(article.content),
                const SizedBox(height: 8),
                Text(
                  article.time,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 