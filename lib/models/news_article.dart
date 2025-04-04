class NewsArticle {
  final String title;
  final String content;
  final String time;

  NewsArticle({
    required this.title,
    required this.content,
    required this.time,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] as String,
      content: json['content'] as String,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'time': time,
    };
  }
} 