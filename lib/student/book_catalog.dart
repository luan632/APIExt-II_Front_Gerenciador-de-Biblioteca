import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/book_service.dart';
import 'package:flutter_application_1/student/book_detail.dart';
import 'package:flutter_application_1/widgets/book_card.dart';
// ignore: unused_import
import 'package:flutter_application_1/models/book.dart';
import 'package:provider/provider.dart';

class BookCatalog extends StatefulWidget {
  const BookCatalog({super.key});

  @override
  _BookCatalogState createState() => _BookCatalogState();
}

class _BookCatalogState extends State<BookCatalog> {
  final _searchController = TextEditingController();
  final _debounce = Duration(milliseconds: 300); // Para evitar rebuilds muito frequentes
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    final bookService = Provider.of<BookService>(context);
    final books = _searchController.text.isEmpty
        ? bookService.books
        : bookService.searchBooks(_searchController.text);

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Livros')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                if (_debounceTimer?.isActive ?? false) {
                  _debounceTimer?.cancel();
                }
                _debounceTimer = Timer(_debounce, () {
                  setState(() {});
                });
              },
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? const Center(child: Text('Nenhum livro encontrado'))
                : ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return BookCard(
                        book: book,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetail(book: book),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}