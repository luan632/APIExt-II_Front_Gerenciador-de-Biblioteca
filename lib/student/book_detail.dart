import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
import 'package:flutter_application_1/models/loan.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/services/loan_service.dart';
import 'package:provider/provider.dart';

class BookDetail extends StatelessWidget {
  final Book book;

  const BookDetail({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoanService>(context);
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.coverUrl != null)
              Center(
                child: Image.network(
                  book.coverUrl!,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Autor: ${book.author}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('ISBN: ${book.isbn}'),
            Text('Ano de Publicação: ${book.publicationYear}'),
            Text('Editora: ${book.publisher}'),
            Text('Quantidade Disponível: ${book.quantity}'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              children: book.categories
                  .map((category) => Chip(label: Text(category)))
                  .toList(),
            ),
            const SizedBox(height: 24),
            if (auth.isStudent && book.quantity > 0)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final newLoan = Loan(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      bookId: book.id,
                      userId: auth.currentUser!.id,
                      loanDate: DateTime.now(),
                      dueDate: DateTime.now().add(const Duration(days: 14)),
                      isDigital: book.isDigital,
                    );
                    loanService.addLoan(newLoan);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Livro emprestado com sucesso!')),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Pegar Emprestado'),
                ),
              ),
            if (book.isDigital)
              const SizedBox(height: 16),
            if (book.isDigital)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Abrir livro digital
                  },
                  child: const Text('Acessar Versão Digital'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}