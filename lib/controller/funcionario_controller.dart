import 'dart:collection';

import 'package:crud_exemplo_1/model/funcionarios_modelo.dart';
import 'package:flutter/material.dart';

class FuncionarioController extends ChangeNotifier {
  final HashMap<String, FuncionarioModelo> _funcionarios = HashMap();

  List<FuncionarioModelo> get funcionarios =>
      List.unmodifiable(_funcionarios.values);

  void salvar(FuncionarioModelo funcionario) {
    _funcionarios[funcionario.id] = funcionario;
    notifyListeners();
  }

  void excluir(FuncionarioModelo funcionario) {
    _funcionarios.remove(funcionario.id);
    notifyListeners();
  }
}
