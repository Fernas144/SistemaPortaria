import 'package:crud_exemplo_1/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_exemplo_1/menu_navegacao.dart';
import 'package:crud_exemplo_1/controller/funcionario_controller.dart';
import 'package:crud_exemplo_1/form/funcionarios_form.dart';

class FuncionariosLista extends StatefulWidget {
  const FuncionariosLista({super.key});

  @override
  State<FuncionariosLista> createState() => _FuncionariosListaState();
}

class _FuncionariosListaState extends State<FuncionariosLista> {
  @override
  Widget build(BuildContext context) {
    var funcionarioController = Provider.of<FuncionarioController>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MenuNavegacao(),
        appBar: AppBar(
          title: const Text('Cadastro de Funcionario'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //aqui definimos a rota da tela a ser aberta
            Navigator.pushNamed(context, Rotas.FUNCIONARIOS_ADD);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: funcionarioController.funcionarios.length,
            itemBuilder: (BuildContext context, int index) {
              final funcionario = funcionarioController.funcionarios[index];
              return Card(
                margin: const EdgeInsets.all(8),
                // incluir um botão para excluir neste card
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirmar Exclusão"),
                          content:
                              const Text("Tem certeza que deseja excluir?"),
                          actions: [
                            TextButton(
                              child: const Text('Confirmar'),
                              onPressed: () {
                                funcionarioController.excluir(funcionario);
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  title: Text('Nome: ${funcionario.nome}'),
                  subtitle: Text('Email: ${funcionario.email}'),
                  onTap: () {},
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => FuncionarioForm(
                            funcionarioSelecionado: funcionario),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
