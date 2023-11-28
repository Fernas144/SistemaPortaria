import 'package:crud_exemplo_1/controller/funcionario_controller.dart';
import 'package:crud_exemplo_1/controller/navegacao_controller.dart';
import 'package:crud_exemplo_1/controller/ocorrencia_controller.dart';
import 'package:crud_exemplo_1/rotas.dart';
import 'package:crud_exemplo_1/controller/veiculo_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OcorrenciaController()),
        ChangeNotifierProvider(create: (context) => NavegacaoController()),
        ChangeNotifierProvider(create: (context) => FuncionarioController()),
        ChangeNotifierProvider(create: (context) => VeiculoController()),
      ],
      child: MaterialApp(
        initialRoute: '/ocorrencia',
        //aqui definimos as rotas para todas as telas do app
        routes: Rotas.widgetsMap(),
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.lightBlue,
        ),
      ),
    );
  }
}
