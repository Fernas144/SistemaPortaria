import 'package:crud_exemplo_1/controller/veiculo_controller.dart';
import 'package:crud_exemplo_1/model/veiculo_modelo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class VeiculoForm extends StatefulWidget {
  VeiculoModelo? veiculoSelecionada;

  VeiculoForm({super.key, this.veiculoSelecionada});

  @override
  _VeiculoFormState createState() => _VeiculoFormState(veiculoSelecionada);
}

class _VeiculoFormState extends State<VeiculoForm> {
  //Identificador global deste form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const Uuid geradorId = Uuid();

  String placa = '';
  String cor = '';
  String marca = '';
  String telefone = '';
  String pessoas = '';
  String id = geradorId.v4();

  _VeiculoFormState(VeiculoModelo? veiculo) {
    if (veiculo != null) {
      placa = veiculo.placa;
      cor = veiculo.cor;
      marca = veiculo.marca;
      telefone = veiculo.telefone;
      pessoas = veiculo.pessoas;
      id = veiculo.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    //Para acessarmos o controller que gerencia os dados de pessoa
    final veiculoController = Provider.of<VeiculoController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Veículo'),
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
                    initialValue: placa,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Placa'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe a placa do veículo';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      placa = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: cor,
                    decoration:
                        const InputDecoration(labelText: 'Cor do Veículo'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a cor do veículo';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cor = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: marca,
                    decoration: const InputDecoration(labelText: 'Marca'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o marca do veículo';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      marca = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: telefone,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o telefone do dono';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      telefone = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: pessoas,
                    decoration: const InputDecoration(labelText: 'Pessoas'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o nome do dono';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      pessoas = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        veiculoController.salvar(VeiculoModelo(
                            placa: placa,
                            marca: marca,
                            cor: cor,
                            telefone: telefone,
                            pessoas: pessoas,
                            id: id));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Salvar'),
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
