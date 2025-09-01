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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _BookDetailBody(book: book),
    );
  }
}

class _BookDetailBody extends StatelessWidget {
  final Book book;

  const _BookDetailBody({required this.book});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BookCover(coverUrl: book.coverUrl),
          const SizedBox(height: 24),
          _BookTitle(title: book.title),
          const SizedBox(height: 12),
          _BookAuthor(author: book.author),
          const SizedBox(height: 20),
          _BookDetails(book: book),
          const SizedBox(height: 20),
          _BookCategories(categories: book.categories),
          const SizedBox(height: 32),
          _BookActions(book: book),
        ],
      ),
    );
  }
}

class _BookCover extends StatelessWidget {
  final String? coverUrl;

  const _BookCover({this.coverUrl});

  @override
  Widget build(BuildContext context) {
    if (coverUrl == null) {
      return Center(
        child: Container(
          height: 200,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.book_outlined,
            size: 60,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Center(
      child: Image.network(
        coverUrl!,
        height: 200,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.broken_image_outlined,
              size: 60,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}

class _BookTitle extends StatelessWidget {
  final String title;

  const _BookTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _BookAuthor extends StatelessWidget {
  final String author;

  const _BookAuthor({required this.author});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Autor: $author',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.grey[700],
          ),
    );
  }
}

class _BookDetails extends StatelessWidget {
  final Book book;

  const _BookDetails({required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailItem(
          label: 'ISBN:',
          value: book.isbn,
        ),
        const SizedBox(height: 8),
        _DetailItem(
          label: 'Ano de Publicação:',
          value: book.publicationYear.toString(),
        ),
        const SizedBox(height: 8),
        _DetailItem(
          label: 'Editora:',
          value: book.publisher,
        ),
        const SizedBox(height: 8),
        _DetailItem(
          label: 'Quantidade Disponível:',
          value: book.quantity.toString(),
          highlight: book.quantity > 0,
        ),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _DetailItem({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          TextSpan(
            text: ' $value',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: highlight ? Theme.of(context).primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookCategories extends StatelessWidget {
  final List<String> categories;

  const _BookCategories({required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox();
    }

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: categories
          .map((category) => Chip(
                label: Text(
                  category,
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              ))
          .toList(),
    );
  }
}

class _BookActions extends StatelessWidget {
  final Book book;

  const _BookActions({required this.book});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    
    return Column(
      children: [
        if (auth.isStudent) _LoanButton(book: book),
        if (book.isDigital) const SizedBox(height: 16),
        if (book.isDigital) _DigitalBookButton(),
      ],
    );
  }
}

class _LoanButton extends StatelessWidget {
  final Book book;

  const _LoanButton({required this.book});

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoanService>(context, listen: false);
    final auth = Provider.of<AuthService>(context, listen: false);

    if (book.quantity <= 0) {
      return OutlinedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.inventory_outlined),
        label: const Text('Indisponível para empréstimo'),
      );
    }

    return FilledButton.icon(
      onPressed: () {
        _handleLoan(context, loanService, auth);
      },
      icon: const Icon(Icons.library_books_outlined),
      label: const Text('Pegar Emprestado'),
    );
  }

  void _handleLoan(
    BuildContext context,
    LoanService loanService,
    AuthService auth,
  ) async {
    try {
      final newLoan = Loan(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        bookId: book.id,
        userId: auth.currentUser!.id,
        bookTitle: book.title, // CORREÇÃO: Adicionei o bookTitle aqui
        loanDate: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 14)),
        isDigital: book.isDigital,
      );

      await loanService.addLoan(newLoan);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Livro emprestado com sucesso!'),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao realizar empréstimo: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

class _DigitalBookButton extends StatelessWidget {
  const _DigitalBookButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        // TODO: Implementar abertura do livro digital
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Funcionalidade de livro digital em desenvolvimento'),
          ),
        );
      },
      icon: const Icon(Icons.desktop_windows_outlined),
      label: const Text('Acessar Versão Digital'),
    );
  }
}