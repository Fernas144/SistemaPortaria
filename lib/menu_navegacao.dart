import 'package:crud_exemplo_1/controller/navegacao_controller.dart';
import 'package:crud_exemplo_1/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuNavegacao extends StatefulWidget {
  const MenuNavegacao({super.key});

  @override
  State<MenuNavegacao> createState() => _MenuNavegacaoState();
}

class _MenuNavegacaoState extends State<MenuNavegacao> {
  String _getRotaSelecionada(int index) {
    return {
          0: Rotas.PESSOAS,
          1: Rotas.VEICULOS,
          2: Rotas.FUNCIONARIOS,
        }[index] ??
        Rotas.PESSOAS;
  }

  @override
  Widget build(BuildContext context) {
    var navegacaoController = Provider.of<NavegacaoController>(context);

    return NavigationBar(
      onDestinationSelected: (int index) {
        navegacaoController.atualizarTelaSelecionada(index);
        Navigator.pushReplacementNamed(context, _getRotaSelecionada(index));
      },
      indicatorColor: Colors.blue[800],
      selectedIndex: navegacaoController.telaSelecionada,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.dangerous),
          icon: Icon(
            Icons.dangerous_outlined,
          ),
          label: 'Ocorrência',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.car_crash),
          icon: Icon(Icons.car_crash_outlined),
          label: 'Veículos',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.person_2_outlined),
          label: 'Funcionários',
        ),
      ],
    );
  }
}
