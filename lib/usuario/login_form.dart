import 'package:crud_exemplo_1/rotas.dart';
import 'package:crud_exemplo_1/usuario/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String usuario = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    var usuarioController = Provider.of<UsuarioController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Entrar no Sistema'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            //aqui especificamos o identificador do form
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: usuario,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Usuário'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe o usuário';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      usuario = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    initialValue: senha,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe a senha';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      senha = value!;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (await usuarioController.login(usuario, senha)) {
                          Navigator.pushReplacementNamed(
                              context, Rotas.VEICULOS);
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Usuário ou senha inválidos!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
