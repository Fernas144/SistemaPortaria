import 'dart:collection';
import 'package:crud_exemplo_1/model/ocorrencia_modelo.dart';
import 'package:flutter/material.dart';

class OcorrenciaController extends ChangeNotifier {
  final HashMap<String, OcorrenciaModelo> _ocorrencia = HashMap();

  List<OcorrenciaModelo> get ocorrencias =>
      List.unmodifiable(_ocorrencia.values);

  void salvar(OcorrenciaModelo ocorrencia) {
    _ocorrencia[ocorrencia.id] = ocorrencia;
    notifyListeners();
  }

  void excluir(OcorrenciaModelo ocorrencia) {
    _ocorrencia.remove(ocorrencia.id);
    notifyListeners();
  }
}
