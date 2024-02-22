import 'dart:convert';

class MarvelHero {
  String name;
  int id;
  String? description;
  String? image;
  MarvelHero({
    required this.name,
    required this.id,
    this.description,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'description': description,
      'image': image,
    };
  }

  factory MarvelHero.fromMap(Map<String, dynamic> map) {
    return MarvelHero(
      name: map['name'],
      id: map['id'],
      description: map['description'],
      image: map['thumbnail']['path'] + '.' + map['thumbnail']['extension'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Hero(name: $name, id: $id, description: $description, image: $image)';
  }
}
