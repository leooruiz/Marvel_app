import 'dart:convert';

import 'package:equatable/equatable.dart';

class MarvelHero extends Equatable {
  const MarvelHero({
    required this.name,
    required this.id,
    required this.description,
    required this.image,
  });
  factory MarvelHero.fromMap(Map<String, dynamic> map) {
    return MarvelHero(
      name: map['name'],
      id: map['id'],
      description: map['description'],
      image: '${map['thumbnail']['path']}.${map['thumbnail']['extension']}',
    );
  }

  factory MarvelHero.fromLocalMap(Map<String, dynamic> map) {
    return MarvelHero(
      name: map['name'],
      id: map['id'],
      image: map['image'],
      description: map['description'],
    );
  }
  factory MarvelHero.fromLocalJson(String json) {
    final result = jsonDecode(json);
    return MarvelHero.fromLocalMap(result);
  }

  final String name;
  final int id;
  final String description;
  final String image;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'description': description,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Hero(name: $name, id: $id, description: $description, image: $image)';
  }

  @override
  List<Object?> get props => [name, id, description, image];
}
