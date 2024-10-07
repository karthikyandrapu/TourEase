class TouristPlacesModel {
  final String name;
  final String image;
  TouristPlacesModel({
    required this.name,
    required this.image,
  });
}

List<TouristPlacesModel> touristPlaces = [
  TouristPlacesModel(name: "Mountain", image: "lib/images/icons/mountain.png"),
  TouristPlacesModel(name: "Beach", image: "lib/images/icons/beach.png"),
  TouristPlacesModel(name: "Forest", image: "lib/images/icons/forest.png"),
  TouristPlacesModel(name: "City", image: "lib/images/icons/city.png"),
  TouristPlacesModel(name: "Desert", image: "lib/images/icons/desert.png"),
];
