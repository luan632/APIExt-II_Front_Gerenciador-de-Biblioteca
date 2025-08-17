import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/services/loan_service.dart';
import 'package:flutter_application_1/widgets/loan_card.dart';
import 'package:provider/provider.dart';

class MyLoans extends StatelessWidget {
  const MyLoans({super.key});

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoanService>(context);
    final auth = Provider.of<AuthService>(context);
    final loans = loanService.getLoansByUser(auth.currentUser!.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Empréstimos')),
      body: loans.isEmpty
          ? const Center(child: Text('Nenhum empréstimo encontrado'))
          : ListView.builder(
              itemCount: loans.length,
              itemBuilder: (context, index) {
                final loan = loans[index];
                return LoanCard(
                  loan: loan,
                  onReturn: () {
                    loanService.returnLoan(loan.id);
                  },
                );
              },
            ),
    );
  }
}