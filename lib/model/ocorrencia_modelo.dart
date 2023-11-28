class OcorrenciaModelo {
  String destinatario;
  String remetente;
  String loja;
  String placa;
  String motivo;
  DateTime dataHora;
  String departamento;
  String telefone;
  String pessoas;
  String id;

  OcorrenciaModelo(
      {required this.destinatario,
      required this.remetente,
      required this.loja,
      required this.placa,
      required this.motivo,
      required this.dataHora,
      required this.departamento,
      required this.telefone,
      required this.pessoas,
      required this.id});

  @override
  int get hashCode => placa.hashCode;

  @override
  bool operator ==(Object other) {
    if (OcorrenciaModelo != other.runtimeType) {
      return false;
    }
    other as OcorrenciaModelo;
    return placa == other.placa;
  }
}
