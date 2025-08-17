import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';

class AuthService with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isAdmin => _currentUser?.type == UserType.admin;
  bool get isStudent => _currentUser?.type == UserType.student;
  bool get isAuthenticated => _currentUser != null;

  Future<void> login(String email, String password) async {
    // Simulação de login - na prática, você faria uma chamada à API
    await Future.delayed(const Duration(seconds: 1));
    
    // Exemplo de usuário admin
    if (email == 'admin@biblioteca.com' && password == 'admin123') {
      _currentUser = User(
        id: '1',
        name: 'Administrador',
        email: email,
        registration: 'ADM001',
        type: UserType.admin,
      );
    } 
    // Exemplo de usuário aluno
    else if (email == 'aluno@biblioteca.com' && password == 'aluno123') {
      _currentUser = User(
        id: '2',
        name: 'Aluno Teste',
        email: email,
        registration: 'ALU001',
        type: UserType.student,
      );
    } else {
      throw Exception('Credenciais inválidas');
    }
    
    notifyListeners();
  }

  Future<void> register(User user, String password) async {
    // Simulação de registro
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = user;
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }
}