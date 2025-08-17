import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/book_management.dart';
import 'package:flutter_application_1/admin/reports_screen.dart';
import 'package:flutter_application_1/admin/user_management.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/shared/profile_screen.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Painel do Administrador')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu do Administrador',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Gerenciar Livros'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookManagement()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Gerenciar Usuários'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserManagement()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Relatórios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {
                Provider.of<AuthService>(context, listen: false).logout();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Bem-vindo ao Painel do Administrador'),
      ),
    );
  }
}