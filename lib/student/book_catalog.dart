import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
import 'package:flutter_application_1/services/book_service.dart';
import 'package:flutter_application_1/student/book_detail.dart';
import 'package:flutter_application_1/widgets/book_card.dart';
import 'package:provider/provider.dart';

class BookCatalog extends StatefulWidget {
  const BookCatalog({super.key});

  @override
  _BookCatalogState createState() => _BookCatalogState();
}

class _BookCatalogState extends State<BookCatalog> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Carregar livros ao iniciar (caso necessário)
    final bookService = Provider.of<BookService>(context, listen: false);
    bookService.fetchBooks(); // Supondo que você tenha esse método
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchQuery = value;
        });
      }
    });
  }

  List<Book> _getFilteredBooks(BookService bookService) {
    if (_searchQuery.isEmpty) return bookService.books;
    return bookService.searchBooks(_searchQuery);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Pesquisar livros...',
          prefixIcon: const Icon(Icons.search, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          hintStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
          ),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBookList(List<Book> books) {
    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.library_books_outlined, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty ? 'Nenhum livro disponível' : 'Nenhum livro encontrado',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      itemCount: books.length,
      separatorBuilder: (_, __) => const Divider(height: 8, color: Colors.transparent),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookService = Provider.of<BookService>(context);

    final filteredBooks = _getFilteredBooks(bookService);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📚 Catálogo de Livros',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white, // Alterado para branco para contrastar com o gradiente
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.transparent, // AppBar transparente para fundo gradiente
        foregroundColor: Colors.white, // Ícones e botões em branco
        iconTheme: const IconThemeData(color: Colors.white), // Garante que os ícones sejam brancos
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A2980),  // Azul escuro
              Color(0xFF26D0CE),  // Ciano
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: _buildBookList(filteredBooks),
            ),
          ],
        ),
      ),
    );
  }
}