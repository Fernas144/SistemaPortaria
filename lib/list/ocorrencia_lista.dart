import 'package:crud_exemplo_1/menu_navegacao.dart';
import 'package:crud_exemplo_1/controller/ocorrencia_controller.dart';
import 'package:crud_exemplo_1/form/ocorrencia_form.dart';
import 'package:crud_exemplo_1/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OcorrenciasLista extends StatelessWidget {
  const OcorrenciasLista({super.key});

  @override
  Widget build(BuildContext context) {
    var ocorrenciaController = Provider.of<OcorrenciaController>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MenuNavegacao(),
        appBar: AppBar(
          title: const Text('Cadastro de Ocorrências'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //aqui definimos a rota da tela a ser aberta
            Navigator.pushNamed(context, Rotas.OCORRENCIA_ADD);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: ocorrenciaController.ocorrencias.length,
            itemBuilder: (BuildContext context, int index) {
              final ocorrencia = ocorrenciaController.ocorrencias[index];
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
                                ocorrenciaController.excluir(ocorrencia);
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
                  title: Text('Identificador: ${ocorrencia.id}'),
                  subtitle: Text('Motivo: ${ocorrencia.departamento}'),
                  onTap: () {},
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            OcorrenciaForm(ocorrenciaSelecionada: ocorrencia),
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
