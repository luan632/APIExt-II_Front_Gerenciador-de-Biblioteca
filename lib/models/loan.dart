class Loan {
  final String id;
  final String bookId;
  final String userId;
  final DateTime loanDate;
  final DateTime dueDate;
  final DateTime? returnDate;
  final bool isDigital;

  Loan({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.loanDate,
    required this.dueDate,
    this.returnDate,
    required this.isDigital,
  });

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      id: map['id'],
      bookId: map['bookId'],
      userId: map['userId'],
      loanDate: DateTime.parse(map['loanDate']),
      dueDate: DateTime.parse(map['dueDate']),
      returnDate: map['returnDate'] != null ? DateTime.parse(map['returnDate']) : null,
      isDigital: map['isDigital'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'userId': userId,
      'loanDate': loanDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
      'isDigital': isDigital,
    };
  }

  bool get isOverdue => DateTime.now().isAfter(dueDate) && returnDate == null;
}