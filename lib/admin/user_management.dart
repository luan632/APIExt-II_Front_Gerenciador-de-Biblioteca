import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/widgets/user_card.dart';
import 'package:provider/provider.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    // Na prática, você teria um UserService para gerenciar usuários
    // Aqui estamos usando apenas para demonstração
    final auth = Provider.of<AuthService>(context);
    final users = [
      auth.currentUser!,
      User(
        id: '2',
        name: 'Aluno Teste',
        email: 'aluno@teste.com',
        registration: 'ALU002',
        type: UserType.student,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar Usuários')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return UserCard(
            user: user,
            onEdit: () {
              // Navegar para tela de edição de usuário
            },
            onDelete: () {
              // Implementar exclusão de usuário
            },
          );
        },
      ),
    );
  }
}