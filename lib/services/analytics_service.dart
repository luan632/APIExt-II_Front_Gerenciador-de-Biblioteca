import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_application_1/models/book.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logBookView(Book book) async {
    await _analytics.logEvent(
      name: 'view_book',
      parameters: {
        'book_id': book.id,
        'book_title': book.title,
        'category': book.categories.isNotEmpty ? book.categories.first : null,
      },
    );
  }

  Future<void> logSearch(String query) async {
    await _analytics.logEvent(
      name: 'search',
      parameters: {'query': query},
    );
  }
}