import 'dart:collection';
import 'package:crud_exemplo_1/model/veiculo_modelo.dart';
import 'package:flutter/material.dart';

class VeiculoController extends ChangeNotifier {
  final HashMap<String, VeiculoModelo> _veiculo = HashMap();

  List<VeiculoModelo> get veiculos => List.unmodifiable(_veiculo.values);

  void salvar(VeiculoModelo veiculo) {
    _veiculo[veiculo.id] = veiculo;
    notifyListeners();
  }

  void excluir(VeiculoModelo veiculo) {
    _veiculo.remove(veiculo.id);
    notifyListeners();
  }
}
