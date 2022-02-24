import 'dart:convert';

import 'package:desafio_viacep/data/model/estado_model.dart';

class DistritoModel {
  final String uuid;
  final String uuidEstado;
  final String id;
  final String nome;
  final EstadoModel? estadoModel;
  DistritoModel({
    required this.uuid,
    required this.uuidEstado,
    required this.id,
    required this.nome,
    this.estadoModel,
  });

  DistritoModel copyWith({
    String? uuid,
    String? uuidEstado,
    String? id,
    String? nome,
    EstadoModel? estadoModel,
  }) {
    return DistritoModel(
      uuid: uuid ?? this.uuid,
      uuidEstado: uuidEstado ?? this.uuidEstado,
      id: id ?? this.id,
      nome: nome ?? this.nome,
      estadoModel: estadoModel ?? this.estadoModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'uuidEstado': uuidEstado,
      'id': id,
      'nome': nome,
      'estadoModel': estadoModel?.toMap(),
    };
  }

  factory DistritoModel.fromMap(Map<String, dynamic> map) {
    return DistritoModel(
      uuid: map['uuid'] ?? '',
      uuidEstado: map['uuidEstado'] ?? '',
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      estadoModel: map['estadoModel'] != null
          ? EstadoModel.fromMap(map['estadoModel'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistritoModel.fromJson(String source) =>
      DistritoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DistritoModel(uuid: $uuid, uuidEstado: $uuidEstado, id: $id, nome: $nome, estadoModel: $estadoModel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DistritoModel &&
        other.uuid == uuid &&
        other.uuidEstado == uuidEstado &&
        other.id == id &&
        other.nome == nome &&
        other.estadoModel == estadoModel;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        uuidEstado.hashCode ^
        id.hashCode ^
        nome.hashCode ^
        estadoModel.hashCode;
  }
}
