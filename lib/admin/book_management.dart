import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/book_service.dart';
import 'package:flutter_application_1/student/book_detail.dart';
import 'package:flutter_application_1/widgets/book_card.dart';
// ignore: unused_import
import 'package:flutter_application_1/models/book.dart';
import 'package:provider/provider.dart';

class BookManagement extends StatefulWidget {
  const BookManagement({super.key});

  @override
  _BookManagementState createState() => _BookManagementState();
}

class _BookManagementState extends State<BookManagement> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookService = Provider.of<BookService>(context);
    final books = _searchController.text.isEmpty
        ? bookService.books
        : bookService.searchBooks(_searchController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Livros'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegar para tela de adicionar livro
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddBookScreen()));
            },
          ),
        ],
      ),
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
              onChanged: (value) => setState(() {}),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Dismissible(
                  key: Key(book.id),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    bookService.deleteBook(book.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${book.title} removido')),
                    );
                  },
                  child: BookCard(
                    book: book,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetail(book: book),
                        ),
                      );
                    },
                    showAdminOptions: true,
                  ),
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
    super.dispose();
  }
}