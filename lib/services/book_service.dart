import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';

class BookService with ChangeNotifier {
  final List<Book> _books = [
    Book(
      id: '1',
      title: 'Dom Casmurro',
      author: 'Machado de Assis',
      isbn: '9788535910663',
      publicationYear: 1899,
      publisher: 'Livraria Garnier',
      quantity: 5,
      coverUrl: 'https://covers.openlibrary.org/b/id/7890151-L.jpg',
      isDigital: false,
      categories: ['Literatura Brasileira', 'Romance'],
    ),
    Book(
      id: '2',
      title: 'Clean Code',
      author: 'Robert C. Martin',
      isbn: '9780132350884',
      publicationYear: 2008,
      publisher: 'Pearson',
      quantity: 3,
      coverUrl: 'https://covers.openlibrary.org/b/id/10900458-L.jpg',
      isDigital: true,
      digitalUrl: 'http://example.com/clean-code.pdf',
      categories: ['Programação', 'Engenharia de Software'],
    ),
  ];

  List<Book> get books => _books;

  get errorMessage => null;

  Null get isLoading => null;

  get hasError => null;

  Book? getBookById(String id) {
    try {
      return _books.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addBook(Book book) async {
    _books.add(book);
    notifyListeners();
  }

  Future<void> updateBook(Book updatedBook) async {
    final index = _books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      _books[index] = updatedBook;
      notifyListeners();
    }
  }

  Future<void> deleteBook(String id) async {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  List<Book> searchBooks(String query) {
    if (query.isEmpty) return _books;
    return _books.where((book) {
      return book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.author.toLowerCase().contains(query.toLowerCase()) ||
          book.isbn.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<void> fetchBooks() async {}
}