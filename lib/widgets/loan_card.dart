import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/loan.dart';
import 'package:intl/intl.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  final VoidCallback? onReturn;

  const LoanCard({
    super.key,
    required this.loan,
    this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Livro ID: ${loan.bookId}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Data do empréstimo: ${dateFormat.format(loan.loanDate)}'),
            Text('Data de devolução: ${dateFormat.format(loan.dueDate)}'),
            if (loan.returnDate != null)
              Text('Devolvido em: ${dateFormat.format(loan.returnDate!)}'),
            if (loan.isOverdue)
              const Text(
                'ATRASADO',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            if (onReturn != null && loan.returnDate == null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onReturn,
                  child: const Text('Devolver'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}