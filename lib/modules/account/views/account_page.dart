import 'package:flutter/material.dart';
import '../widgets/guest_account_view.dart';
import '../widgets/logged_in_account_view.dart';
import 'login_page.dart';
import 'create_account_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isLoggedIn = false;
  Map<String, String>? _userData;

  void _handleLogin() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _isLoggedIn = true;
        _userData = result;
      });
    }
  }

  void _handleCreateAccount() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateAccountPage(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _isLoggedIn = true;
        _userData = result;
      });
    }
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _userData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LoggedInAccountView(
          userName: _userData?['name'] ?? 'Nathan',
          userEmail: _userData?['email'] ?? 'nathan@example.com',
          userAvatar: _userData?['avatar'] ?? 'assets/images/nathan.png',
          onLogout: _handleLogout,
        ),
      ),
    );
  }
}
