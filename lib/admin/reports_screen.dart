import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/loan_service.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoanService>(context);
    final overdueLoans = loanService.getOverdueLoans();

    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Empréstimos Atrasados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (overdueLoans.isEmpty)
              const Text('Nenhum empréstimo atrasado')
            else
              Column(
                children: overdueLoans
                    .map((loan) => ListTile(
                          title: Text('Empréstimo ID: ${loan.id}'),
                          subtitle: Text('Venceu em ${loan.dueDate.toString()}'),
                        ))
                    .toList(),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Gerar relatório completo
              },
              child: const Text('Gerar Relatório Completo'),
            ),
          ],
        ),
      ),
    );
  }
}