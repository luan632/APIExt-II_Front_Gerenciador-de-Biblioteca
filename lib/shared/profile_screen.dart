import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = auth.currentUser!;

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: user.photoUrl != null
                    ? NetworkImage(user.photoUrl!)
                    : const AssetImage('assets/default_avatar.png')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),
            Text('Nome: ${user.name}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${user.email}'),
            const SizedBox(height: 8),
            Text('Matrícula: ${user.registration}'),
            const SizedBox(height: 8),
            Text('Tipo: ${user.type == UserType.admin ? 'Administrador' : 'Aluno'}'),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  auth.logout();
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Sair', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}