// import 'package:flutter_test/flutter_test.dart';
// import 'package:marvel_app/data/api_service/data_api.dart';
// import 'package:marvel_app/domain/models/marvel_hero.dart';
// import 'package:mocktail/mocktail.dart';

// class MarvelHeroMock extends Mock implements MarvelHero {}

// void main() {
//   final marvelMock = MarvelHeroMock();
//   test('deve pegar uma lista de 20 herois da api', () async {
//     when(
//       marvelMock.toMap,
//     ).thenReturn({
//       'myName': 'Leonardo',
//     });
//     expect(marvelMock.toMap(), {'myName': 'Leonardo'});
//     verify(
//       marvelMock.toMap,
//     ).called(1);
//     final DataApi dataApi = DataApi();
//     final List<MarvelHero> heroesList = await dataApi.getHeroesList(offset: 0);
//     expect(heroesList.length, 20);
//     expect(heroesList.first.name, '3-D Man');
//     expect(heroesList.last.description, '');
//   });
// }
