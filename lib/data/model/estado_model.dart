import 'dart:convert';

class EstadoModel {
  final String uuid;
  final int id;
  final String sigla;
  final String nome;
  EstadoModel({
    required this.uuid,
    required this.id,
    required this.sigla,
    required this.nome,
  });

  EstadoModel copyWith({
    String? uuid,
    int? id,
    String? sigla,
    String? nome,
  }) {
    return EstadoModel(
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      sigla: sigla ?? this.sigla,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'id': id,
      'sigla': sigla,
      'nome': nome,
    };
  }

  factory EstadoModel.fromMap(Map<String, dynamic> map) {
    return EstadoModel(
      uuid: map['uuid'] ?? '',
      id: map['id']?.toInt() ?? 0,
      sigla: map['sigla'] ?? '',
      nome: map['nome'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EstadoModel.fromJson(String source) =>
      EstadoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EstadoModel(uuid: $uuid, id: $id, sigla: $sigla, nome: $nome)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EstadoModel &&
        other.uuid == uuid &&
        other.id == id &&
        other.sigla == sigla &&
        other.nome == nome;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^ id.hashCode ^ sigla.hashCode ^ nome.hashCode;
  }
}
