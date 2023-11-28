class VeiculoModelo {
  String placa;
  String cor;
  String marca;
  String telefone;
  String pessoas;
  String id;

  VeiculoModelo(
      {required this.placa,
      required this.cor,
      required this.marca,
      required this.telefone,
      required this.pessoas,
      required this.id});

  @override
  int get hashCode => placa.hashCode;

  @override
  bool operator ==(Object other) {
    if (VeiculoModelo != other.runtimeType) {
      return false;
    }
    other as VeiculoModelo;
    return placa == other.placa;
  }
}
