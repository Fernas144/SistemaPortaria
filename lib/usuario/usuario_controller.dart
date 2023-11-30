import 'package:crud_exemplo_1/usuario/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioController extends ChangeNotifier {
  UsuarioModelo? usuarioLogado;

  Future<bool> login(String usuario, String senha) async {
    usuarioLogado = UsuarioModelo(usuario, senha);
    notifyListeners();
    return usuarioLogado != null;
  }

  Future<bool> loginAutomatico() async {
    // Busca o usuário salvo na máquina
    String? usuario =
        (await SharedPreferences.getInstance()).getString('usuario');
    String? senha = (await SharedPreferences.getInstance()).getString('senha');
    if (usuario != null && senha != null) {
      usuarioLogado = UsuarioModelo(usuario, senha);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
