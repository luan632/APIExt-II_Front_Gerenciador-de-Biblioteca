import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/shared/profile_screen.dart';
import 'package:flutter_application_1/student/book_catalog.dart';
import 'package:flutter_application_1/student/my_loans.dart';
import 'package:provider/provider.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A2980),  // Azul escuro
              Color(0xFF26D0CE),  // Ciano
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Biblioteca'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: Drawer(
            // ignore: deprecated_member_use
            backgroundColor: Colors.white.withOpacity(0.9),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Text(
                    'Menu do Aluno',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.book, color: Colors.blue),
                  title: const Text('Catálogo de Livros'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BookCatalog()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.library_books, color: Colors.blue),
                  title: const Text('Meus Empréstimos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyLoans()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: const Text('Meu Perfil'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
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
            child: Text(
              'Bem-vindo à Biblioteca',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}