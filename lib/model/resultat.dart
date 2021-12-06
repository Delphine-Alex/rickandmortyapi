class Resultat {
  late int id;
  late String name;
  late String status;
  late String species;
  late String type;
  late String gender;
  late String image;

  Resultat.json(Map<String, dynamic> map){
    id = map ['id'];
    name = map ['name'];
    status = map ['status'];
    species = map ['species'];
    type = map ['type'];
    gender = map ['gender'];
    image = map ['image'];
  }
}