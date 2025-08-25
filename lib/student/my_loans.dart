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
      appBar: AppBar(
        title: const Text(
          '📚 Meus Empréstimos 📚',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1A2980),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A2980), // Azul escuro
              Color(0xFF26D0CE), // Ciano
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: loans.isEmpty
            ? const Center(
                child: Text(
                  'Nenhum empréstimo encontrado',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                ),
              )
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
      ),
    );
  }
}