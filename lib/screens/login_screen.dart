import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:primeiro_app/screens/register_screen.dart';
import 'package:primeiro_app/screens/reset_password_modal.dart';
import 'package:primeiro_app/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.pinkAccent,
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.hourglass_empty_rounded,
                          color: Colors.pinkAccent,
                          size: 76,
                        ),
                        const Text(
                          'Seja bem vindo(a)!',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'E-mail',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                            obscureText: true,
                            controller: _senhaController,
                            decoration: const InputDecoration(
                              hintText: 'Senha',
                              border: OutlineInputBorder(),
                            )),
                        const SizedBox(height: 16),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.pinkAccent,
                                ),
                                onPressed: () {
                                  authService
                                      .entrarUsuario(
                                          email: _emailController.text,
                                          senha: _senhaController.text)
                                      .then(
                                    (String? erro) {
                                      if (erro != null) {
                                        final snackBar = SnackBar(
                                            content: Text(erro),
                                            backgroundColor: Colors.red);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                  );
                                },
                                child: const Text('Entrar'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.pinkAccent,
                                ),
                                onPressed: () {
                                  signInWithGoogle();
                                },
                                child: const Text('Entrar com o google'),
                              )
                            ]),
                        const SizedBox(height: 16),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  child: const Text('Criar conta')),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: ((BuildContext context) {
                                        return const PasswordResetModal();
                                      }));
                                },
                                child: const Text('Recuperar senha'),
                              )
                            ])
                      ],
                    ))
              ],
            ))));
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
