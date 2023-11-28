import 'dart:io';

import 'package:crud_exemplo_1/controller/ocorrencia_controller.dart';
import 'package:crud_exemplo_1/model/ocorrencia_modelo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class OcorrenciaForm extends StatefulWidget {
  OcorrenciaModelo? ocorrenciaSelecionada;

  OcorrenciaForm({super.key, this.ocorrenciaSelecionada});

  @override
  _OcorrenciaFormState createState() =>
      _OcorrenciaFormState(ocorrenciaSelecionada);
  String? savedImagePath;
  File? produtoImage;
}

class _OcorrenciaFormState extends State<OcorrenciaForm> {
  //Identificador global deste form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formatoData = DateFormat('dd/MM/yyyy');
  static const Uuid geradorId = Uuid();

  String destinatario = '';
  String remetente = '';
  String loja = '';
  String placa = '';
  DateTime? dataHora;
  String departamento = '';
  String motivo = '';
  String telefone = '';
  String pessoas = '';
  String id = geradorId.v4();

  File? savedImagePath;

  _OcorrenciaFormState(OcorrenciaModelo? ocorrencia) {
    if (ocorrencia != null) {
      destinatario = ocorrencia.destinatario;
      remetente = ocorrencia.remetente;
      loja = ocorrencia.loja;
      placa = ocorrencia.placa;
      dataHora = ocorrencia.dataHora;
      departamento = ocorrencia.departamento;
      motivo = ocorrencia.motivo;
      telefone = ocorrencia.telefone;
      pessoas = ocorrencia.pessoas;
      id = ocorrencia.id;
    }
  }

  // Função para mostrar o calendário
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: dataHora ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selecionado != null && selecionado != dataHora) {
      setState(() {
        dataHora = selecionado;
      });
    }
  }

  //Função para escolher uma imagem
  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile == null) {
      // O usuário cancelou a operação
      return;
    }
    // Processar o arquivo de imagem capturado

    final image = File(imageFile.path);
    // Faça algo com a imagem, como exibí-la na interface ou salvá-la no armazenamento.

    // Obtenha o diretório de documentos do aplicativo para salvar a imagem.
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    final imageFileName = '${DateTime.now()}.jpg';
    savedImagePath =
        await image.copy('${appDocumentDirectory.path}/$imageFileName');
  }

  @override
  Widget build(BuildContext context) {
    //Para acessarmos o controller que gerencia os dados de pessoa
    final pessoaController = Provider.of<OcorrenciaController>(context);

    // Formatando a data selecionada para mostrar
    final dataNascimentoFormatada =
        dataHora == null ? '' : formatoData.format(dataHora!);

    final departamentos = ['Veículo', 'Entrega', 'Extra'];
    final lojas = [
      'Aliexpress',
      'Amazon',
      'Shopee',
      'iFood',
      'Mercado Livre',
      'Outro'
    ];
    var elementos = <Widget>[];

    var campodrop = DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 60,
      leadingIcon: const Icon(Icons.storefront),
      label: const Text("Ocorrência"),
      initialSelection: departamento,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          departamento = value!;
        });
      },
      dropdownMenuEntries:
          departamentos.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );

    if (departamento == '') {
      elementos = <Widget>[
        const SizedBox(height: 20),
        campodrop,
      ];
    } else if (departamento == 'Veículo') {
      elementos = <Widget>[
        const SizedBox(height: 20),
        campodrop,
        const SizedBox(height: 20),
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration:
                    const InputDecoration(labelText: 'Data da Ocorrência'),
                controller:
                    TextEditingController(text: dataNascimentoFormatada),
                validator: (value) {
                  if (dataHora == null) {
                    return 'Selecione a data da ocorrência';
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
        /*DropdownMenu<String>(
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
          dropdownMenuEntries:
              departamentos.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),*/
        TextFormField(
          initialValue: motivo,
          decoration: const InputDecoration(labelText: 'Motivo'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Digite o motivo da ocorrência';
            }
            return null;
          },
          onSaved: (value) {
            motivo = value!;
          },
        ),
        TextFormField(
          initialValue: telefone,
          decoration: const InputDecoration(labelText: 'Telefone'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Digite o telefone dos envolvidos';
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
              return 'Digite o nome das pessoas envolvidas';
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
            _tirarFoto();
          },
          child: const Text('Escolher Imagem'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              pessoaController.salvar(OcorrenciaModelo(
                  destinatario: destinatario,
                  remetente: remetente,
                  loja: loja,
                  placa: placa,
                  motivo: motivo,
                  dataHora: dataHora!,
                  departamento: departamento,
                  telefone: telefone,
                  pessoas: pessoas,
                  id: id));
              Navigator.pop(context);
            }
          },
          child: const Text('Salvar'),
        ),
      ];
    } else if (departamento == 'Entrega') {
      elementos = [
        const SizedBox(height: 20),
        campodrop,
        const SizedBox(height: 20),
        DropdownMenu<String>(
          width: MediaQuery.of(context).size.width - 60,
          leadingIcon: const Icon(Icons.delivery_dining),
          label: const Text("Escolha o tipo de Entrega"),
          initialSelection: loja,
          onSelected: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              loja = value!;
            });
          },
          dropdownMenuEntries:
              lojas.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
        TextFormField(
          initialValue: remetente,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Responsável'),
          validator: (value) {
            if ((value ?? '').isEmpty) {
              return 'Informe quem recebeu a Entrega';
            }
            return null;
          },
          onSaved: (value) {
            remetente = value!;
          },
        ),
        TextFormField(
          initialValue: destinatario,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Destinatário'),
          validator: (value) {
            if ((value ?? '').isEmpty) {
              return 'Informe para quem é a Entrega';
            }
            return null;
          },
          onSaved: (value) {
            destinatario = value!;
          },
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Data da Entrega'),
                controller:
                    TextEditingController(text: dataNascimentoFormatada),
                validator: (value) {
                  if (dataHora == null) {
                    return 'Selecione a data da entrega';
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
        ElevatedButton(
          onPressed: () {
            _tirarFoto();
          },
          child: const Text('Escolher Imagem'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              pessoaController.salvar(OcorrenciaModelo(
                  destinatario: destinatario,
                  remetente: remetente,
                  loja: loja,
                  placa: placa,
                  motivo: motivo,
                  dataHora: dataHora!,
                  departamento: departamento,
                  telefone: telefone,
                  pessoas: pessoas,
                  id: id));
              Navigator.pop(context);
            }
          },
          child: const Text('Salvar'),
        ),
      ];
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Ocorrência'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            //aqui especificamos o identificador do form
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: elementos,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
