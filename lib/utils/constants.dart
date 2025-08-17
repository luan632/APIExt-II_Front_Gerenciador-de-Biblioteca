import 'dart:ui';

import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Gerenciador de Biblioteca';
  
  // Cores
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.green;
  static const Color errorColor = Colors.red;
  
  // Tempos
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Textos
  static const String loginErrorMessage = 'Email ou senha incorretos';
  static const String registerSuccessMessage = 'Registro realizado com sucesso!';
}

class ApiEndpoints {
  static const String baseUrl = 'https://api.biblioteca.com';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String books = '/books';
  static const String users = '/users';
  static const String loans = '/loans';
}