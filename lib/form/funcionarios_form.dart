import 'package:crud_exemplo_1/controller/funcionario_controller.dart';
import 'package:crud_exemplo_1/model/funcionarios_modelo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FuncionarioForm extends StatefulWidget {
  FuncionarioModelo? funcionarioSelecionado;

  FuncionarioForm({super.key, this.funcionarioSelecionado});

  @override
  _FuncionarioFormState createState() =>
      _FuncionarioFormState(funcionarioSelecionado);
}

class _FuncionarioFormState extends State<FuncionarioForm> {
  //Identificador global deste form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formatoData = DateFormat('dd/MM/yyyy');
  static const Uuid geradorId = Uuid();

  String nome = '';
  DateTime? dataNascimento;
  String departamento = '';
  String email = '';
  String telefone = '';
  String endereco = '';
  String placa = '';
  String id = geradorId.v4();

  _FuncionarioFormState(FuncionarioModelo? funcionario) {
    if (funcionario != null) {
      nome = funcionario.nome;
      dataNascimento = funcionario.dataNascimento;
      departamento = funcionario.departamento;
      email = funcionario.email;
      telefone = funcionario.telefone;
      endereco = funcionario.endereco;
      id = funcionario.id;
    }
  }

  // Função para mostrar o calendário
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: dataNascimento ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selecionado != null && selecionado != dataNascimento) {
      setState(() {
        dataNascimento = selecionado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Para acessarmos o controller que gerencia os dados de pessoa
    final funcionarioController = Provider.of<FuncionarioController>(context);

    // Formatando a data selecionada para mostrar
    final dataNascimentoFormatada =
        dataNascimento == null ? '' : formatoData.format(dataNascimento!);

    final departamentos = [
      'Contábil',
      'Recursos Humanos',
      'TI',
      'Segurança',
      'Aluno'
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Funcionário'),
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
                    initialValue: nome,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe o nome';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nome = value!;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                              labelText: 'Data de Nascimento'),
                          controller: TextEditingController(
                              text: dataNascimentoFormatada),
                          validator: (value) {
                            if (dataNascimento == null) {
                              return 'Selecione a data de nascimento';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          _selecionarData(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width - 60,
                    leadingIcon: const Icon(Icons.storefront),
                    label: const Text("Departamento"),
                    initialSelection: departamento,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        departamento = value!;
                      });
                    },
                    dropdownMenuEntries: departamentos
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                  TextFormField(
                    initialValue: email,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: telefone,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o telefone';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      telefone = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: endereco,
                    decoration: const InputDecoration(labelText: 'Endereço'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o endereço';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      endereco = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: placa,
                    decoration: const InputDecoration(labelText: 'Placa'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a placa';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      placa = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        funcionarioController.salvar(FuncionarioModelo(
                            nome: nome,
                            email: email,
                            dataNascimento: dataNascimento!,
                            departamento: departamento,
                            telefone: telefone,
                            endereco: endereco,
                            placa: placa,
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
