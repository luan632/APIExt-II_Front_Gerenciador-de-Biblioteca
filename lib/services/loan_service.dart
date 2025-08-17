import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/loan.dart';

class LoanService with ChangeNotifier {
  final List<Loan> _loans = [];

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
}