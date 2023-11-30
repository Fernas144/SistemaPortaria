import 'dart:js';
import 'package:crud_exemplo_1/form/funcionarios_form.dart';
import 'package:crud_exemplo_1/list/funcionarios_lista.dart';
import 'package:crud_exemplo_1/form/ocorrencia_form.dart';
import 'package:crud_exemplo_1/list/ocorrencia_lista.dart';
import 'package:crud_exemplo_1/form/veiculo_form.dart';
import 'package:crud_exemplo_1/list/veiculo_lista.dart';
import 'package:crud_exemplo_1/usuario/login_form.dart';
import 'package:flutter/material.dart';

class Rotas {
  //Rotas principais
  static const String LOGIN = '/login';
  static const String REGISTRAR = '/registrar';
  static const String PESSOAS = '/ocorrencia';
  static const String VEICULOS = '/veiculos';
  static const String FUNCIONARIOS = '/funcionarios';

  //Sub-rotas
  static const String PESSOAS_ADD = '/pessoas/add';
  static const String OCORRENCIA_ADD = '/ocorrencia/add';
  static const String FUNCIONARIOS_ADD = '/funcionarios/add';
  static const String VEICULO_ADD = '/veiculo/add';

  //Mapeamento de rotas para telas
  static Map<String, WidgetBuilder> widgetsMap() {
    return {
      LOGIN: (context) => const LoginForm(),
      FUNCIONARIOS: (context) => FuncionariosLista(),
      FUNCIONARIOS_ADD: (context) => FuncionarioForm(),
      PESSOAS: (context) => OcorrenciasLista(),
      OCORRENCIA_ADD: (context) => OcorrenciaForm(),
      VEICULOS: (context) => VeiculoLista(),
      VEICULO_ADD: (context) => VeiculoForm(),
    };
  }
}
