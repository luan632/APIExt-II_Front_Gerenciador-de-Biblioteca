import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/loan.dart';

class LoanService with ChangeNotifier {
  final List<Loan> _loans = [
    // Adicione alguns empréstimos de exemplo para teste
    Loan(
      id: '1',
      bookId: '101',
      userId: 'user1',
      bookTitle: 'Dom Casmurro',
      loanDate: DateTime(2024, 1, 15),
      dueDate: DateTime(2024, 2, 15),
      returnDate: DateTime(2024, 2, 10),
      isDigital: false,
    ),
    Loan(
      id: '2',
      bookId: '102',
      userId: 'user1',
      bookTitle: 'O Cortiço',
      loanDate: DateTime(2024, 2, 1),
      dueDate: DateTime(2024, 3, 1),
      returnDate: DateTime(2024, 2, 28),
      isDigital: true,
    ),
    // Empréstimo atual (não devolvido)
    Loan(
      id: '3',
      bookId: '103',
      userId: 'user1',
      bookTitle: 'Memórias Póstumas de Brás Cubas',
      loanDate: DateTime(2024, 3, 1),
      dueDate: DateTime(2024, 4, 1),
      returnDate: null,
      isDigital: false,
    ),
  ];

  List<Loan> get loans => _loans;

  List<Loan> getLoansByUser(String userId) {
    return _loans.where((loan) => loan.userId == userId).toList();
  }

  Future<void> addLoan(Loan loan) async {
    _loans.add(loan);
    notifyListeners();
  }

  Future<void> returnLoan(String loanId) async {
    final index = _loans.indexWhere((loan) => loan.id == loanId);
    if (index != -1) {
      _loans[index] = Loan(
        id: _loans[index].id,
        bookId: _loans[index].bookId,
        userId: _loans[index].userId,
        bookTitle: _loans[index].bookTitle, // Adicione esta linha
        loanDate: _loans[index].loanDate,
        dueDate: _loans[index].dueDate,
        returnDate: DateTime.now(),
        isDigital: _loans[index].isDigital,
      );
      notifyListeners();
    }
  }

  List<Loan> getOverdueLoans() {
    return _loans.where((loan) => loan.isOverdue).toList();
  }

  // Método getCompletedLoans corrigido
  List<Loan> getCompletedLoans() {
    return _loans.where((loan) => loan.returnDate != null).toList();
  }
  
  // Método adicional para obter empréstimos ativos
  List<Loan> getActiveLoans() {
    return _loans.where((loan) => loan.returnDate == null).toList();
  }
}