import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:primeiro_app/screens/delete_account_modal.dart';
import 'package:primeiro_app/services/auth_service.dart';

class Menu extends StatelessWidget {
  final User user;
  const Menu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName:
              Text((user.displayName != null) ? user.displayName! : ''),
          accountEmail: Text(user.email!),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
          ),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.manage_accounts_rounded, size: 48),
          ),
        ),
        ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              AuthService().sair();
            }),
        ListTile(
            leading: const Icon(Icons.delete_outline_outlined),
            title: const Text('Excluir conta'),
            textColor: Colors.red,
            onTap: () {
              // AuthService().excluirConta();
              showDialog(
                  context: context,
                  builder: ((BuildContext context) {
                    return const DeleteAccountModal();
                  }));
            })
      ],
    ));
  }
}
