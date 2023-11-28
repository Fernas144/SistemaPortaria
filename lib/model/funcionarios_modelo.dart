class FuncionarioModelo {
  String nome;
  String email;
  DateTime dataNascimento;
  String departamento;
  String telefone;
  String endereco;
  String placa;
  String id;

  FuncionarioModelo(
      {required this.nome,
      required this.email,
      required this.dataNascimento,
      required this.departamento,
      required this.telefone,
      required this.endereco,
      required this.placa,
      required this.id});

  @override
  int get hashCode => email.hashCode;

  @override
  bool operator ==(Object other) {
    if (FuncionarioModelo != other.runtimeType) {
      return false;
    }
    other as FuncionarioModelo;
    return email == other.email;
  }
}
