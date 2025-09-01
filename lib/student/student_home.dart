import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/loan.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/services/loan_service.dart';
import 'package:flutter_application_1/shared/profile_screen.dart';
import 'package:flutter_application_1/student/book_catalog.dart';
import 'package:flutter_application_1/student/my_loans.dart';

// Adicione estas constantes para uso na classe LoanHistory
const Color _primaryDarkBlue = Color(0xFF1A2980);
const Color _primaryCyan = Color(0xFF26D0CE);
const Color _white = Colors.white;
const TextStyle _appBarTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: _white,
);

class LoanHistory extends StatelessWidget {
  const LoanHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoanService>(context, listen: false);
    final completedLoans = loanService.getCompletedLoans();

    return Scaffold(
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Histórico de Empréstimos', style: _appBarTitleStyle),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: _white),
          ),
          body: completedLoans.isEmpty
              ? _buildEmptyState()
              : _buildLoanList(completedLoans),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_primaryDarkBlue, _primaryCyan],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded, size: 64, color: Colors.white70),
          const SizedBox(height: 16),
          Text(
            'Nenhum empréstimo concluído',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Seus empréstimos anteriores aparecerão aqui',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanList(List<Loan> loans) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: loans.length,
      itemBuilder: (context, index) {
        final loan = loans[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.book_rounded, color: Colors.blue.shade700),
            ),
            title: Text(
              loan.bookTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Emprestado: ${_formatDate(loan.loanDate)}'),
                Text('Devolvido: ${_formatDate(loan.returnDate!)}'),
              ],
            ),
            trailing: Icon(Icons.check_circle_rounded, color: Colors.green.shade600),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  // =============== CONSTANTS AND STYLES ===============
  static const Color _primaryDarkBlue = Color(0xFF1A2980);
  static const Color _primaryCyan = Color(0xFF26D0CE);
  static const Color _white = Colors.white;
  static const Color _white70 = Colors.white70;
  static const double _drawerWidthFactor = 0.78;
  static const double _avatarRadius = 40.0;
  static const double _titleFontSize = 28.0;
  static const double _subtitleFontSize = 16.0;

  static const TextStyle _appBarTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: _white,
  );

  static const TextStyle _welcomeTitleStyle = TextStyle(
    color: _white,
    fontSize: _titleFontSize,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _welcomeSubtitleStyle = TextStyle(
    color: _white70,
    fontSize: _subtitleFontSize,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context),
          drawer: _buildCustomDrawer(context),
          body: _buildWelcomeContent(context),
        ),
      ),
    );
  }

  // =============== BACKGROUND DECORATION ===============
  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_primaryDarkBlue, _primaryCyan],
      ),
    );
  }

  // =============== APP BAR ===============
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Biblioteca Digital', style: _appBarTitleStyle),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: _white),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: _white),
          onPressed: () => _showDevelopmentSnackbar(context, 'Sistema de notificações'),
        ),
      ],
    );
  }

  // =============== CUSTOM DRAWER ===============
  Widget _buildCustomDrawer(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    final String userName = user?.displayName ?? 'Aluno';
    final String userEmail = user?.email ?? '';
    final String? userPhoto = user?.photoUrl;

    return Drawer(
      backgroundColor: _white.withOpacity(0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
      ),
      width: MediaQuery.of(context).size.width * _drawerWidthFactor,
      child: Column(
        children: [
          _buildDrawerHeader(context, userPhoto, userName, userEmail),
          Expanded(
            child: _buildDrawerMenuItems(context, authService),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, String? userPhoto, String userName, String userEmail) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_primaryDarkBlue, _primaryCyan],
        ),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: _white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUserAvatar(userPhoto),
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    color: _white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  userEmail,
                  style: const TextStyle(
                    color: _white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(String? userPhoto) {
    return CircleAvatar(
      radius: _avatarRadius,
      backgroundColor: _white,
      backgroundImage: userPhoto != null 
          ? NetworkImage(userPhoto)
          : null,
      child: userPhoto == null
          ? const Icon(Icons.person, size: 40, color: Colors.blue)
          : null,
    );
  }

  Widget _buildDrawerMenuItems(BuildContext context, AuthService authService) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      children: [
        _buildMenuItem(
          context,
          icon: Icons.menu_book_rounded,
          title: 'Catálogo de Livros',
          subtitle: 'Explore nosso acervo',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BookCatalog())),
        ),
        _buildMenuItem(
          context,
          icon: Icons.library_books_rounded,
          title: 'Meus Empréstimos',
          subtitle: 'Ver livros emprestados',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLoans())),
        ),
        _buildMenuItem(
          context,
          icon: Icons.history,
          title: 'Histórico',
          subtitle: 'Meus empréstimos anteriores',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoanHistory())),
        ),
        _buildMenuItem(
          context,
          icon: Icons.person_rounded,
          title: 'Meu Perfil',
          subtitle: 'Editar informações pessoais',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
        ),
        const Divider(indent: 20, endIndent: 20, thickness: 0.5),
        _buildMenuItem(
          context,
          icon: Icons.settings_rounded,
          title: 'Configurações',
          subtitle: 'Personalize sua experiência',
          onTap: () => _showDevelopmentSnackbar(context, 'Configurações'),
        ),
        _buildMenuItem(
          context,
          icon: Icons.help_rounded,
          title: 'Ajuda & Suporte',
          subtitle: 'Tire suas dúvidas',
          onTap: () => _showDevelopmentSnackbar(context, 'Central de ajuda'),
        ),
        const SizedBox(height: 20),
        _buildLogoutButton(context, authService),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue.shade700),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthService authService) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.logout, size: 20),
          label: const Text('Sair', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            authService.logout();
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: _white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  // =============== WELCOME CONTENT ===============
  Widget _buildWelcomeContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
          child: Text('Olá, Estudante!', style: _welcomeTitleStyle),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 30),
          child: Text('O que você gostaria de fazer hoje?', style: _welcomeSubtitleStyle),
        ),
        Expanded(
          child: _buildActionGrid(context),
        ),
      ],
    );
  }

  /// Constrói uma grade de ações com cards interativos para navegação.
  Widget _buildActionGrid(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20.0),
      crossAxisCount: 2,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
      childAspectRatio: 1.1,
      children: [
        _buildActionCard(
          context,
          icon: Icons.search_rounded,
          title: 'Buscar Livros',
          color: Colors.blue.shade700,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookCatalog()),
            );
          },
        ),
        _buildActionCard(
          context,
          icon: Icons.library_books_rounded,
          title: 'Meus Empréstimos',
          color: Colors.green.shade700,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyLoans()),
            );
          },
        ),
        _buildActionCard(
          context,
          icon: Icons.person_rounded,
          title: 'Meu Perfil',
          color: Colors.purple.shade700,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
        _buildActionCard(
          context,
          icon: Icons.star_rounded,
          title: 'Recomendações',
          color: Colors.orange.shade700,
          onTap: () => _showDevelopmentSnackbar(context, 'Recomendações'),
        ),
      ],
    );
  }

  /// Cria um card estilizado com ícone, título và cor personalizada.
  /// O card tem efeito de gradiente e toque responsivo.
  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    // Estilo do texto para os títulos
    final TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.8),
                color,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone centralizado com fundo semi-transparente
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30.0,
                  color: _white,
                ),
              ),
              const SizedBox(height: 15.0),
              // Título do card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== MÉTODOS DE APOIO ====================

  /// Exibe um snackbar informando que uma funcionalidade está em desenvolvimento.
  void _showDevelopmentSnackbar(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName está em desenvolvimento!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.orange.shade800,
      ),
    );
  }
}