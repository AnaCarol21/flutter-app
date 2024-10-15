import 'package:flutter/material.dart';
import 'package:primeiro_app/services/auth_service.dart';

class PasswordResetModal extends StatefulWidget {
  const PasswordResetModal({super.key});

  @override
  State<PasswordResetModal> createState() => _PasswordResetModalState();
}

class _PasswordResetModalState extends State<PasswordResetModal> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Recuperar senha'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Endereço de e-mail'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'E-mail inválido.';
            }
            return null;
          },
        ),
      ),
      actions: <TextButton>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authService
                    .redefinirSenha(email: _emailController.text)
                    .then((String? erro) {
                  Navigator.of(context).pop();

                  if (erro != null) {
                    final snackBar = SnackBar(
                        content: Text(erro), backgroundColor: Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                        content: Text(
                            'Foi enviado para o seu e-mail um link de redefinição de senha ${_emailController.text}'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              }
            },
            child: const Text('Recuperar senha'))
      ],
    );
  }
}
