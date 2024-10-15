import 'package:flutter/material.dart';
import 'package:primeiro_app/screens/login_screen.dart';
import 'package:primeiro_app/services/auth_service.dart';

class DeleteAccountModal extends StatefulWidget {
  const DeleteAccountModal({super.key});

  @override
  State<DeleteAccountModal> createState() => _DeleteAccountModalState();
}

class _DeleteAccountModalState extends State<DeleteAccountModal> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Deseja excluir sua conta?'),
        content: Form(
          key: _formKey,
          child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Digite sua senha')),
        ),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authService
                    .excluirConta(senha: _passwordController.text)
                    .then((String? erro) {
                  Navigator.of(context).pop();

                  if (erro != null) {
                    final snackBar = SnackBar(
                      content: Text(erro.toString()),
                      backgroundColor: Colors.red,
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    const snackBar = SnackBar(
                        content: Text('Sua conta foi excluída com sucesso!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              }
            },
            child: const Text('Excluir'),
          ),
        ]);
  }
}
