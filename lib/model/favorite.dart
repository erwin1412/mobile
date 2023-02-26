class Favorite {
  int idFavorite;
  int idUser;
  int idShoes;
  String namaBarang;
  List<String>? label;
  double price;
  List<String> sizes;
  List<String> colors;
  String? description;
  String image;

  Favorite({
    required this.colors,
    this.description,
    required this.idFavorite,
    required this.image,
    required this.namaBarang,
    required this.price,
    required this.sizes,
    this.label,
    required this.idShoes,
    required this.idUser,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        idFavorite: int.parse(json['id_favorit']),
        idShoes: int.parse(json['id_shoes']),
        idUser: int.parse(json['id_user']),
        namaBarang: json['nama_barang'],
        label: json['label'].toString().split(', '),
        price: double.parse(json['price']),
        sizes: json['sizes'].toString().split(', '),
        colors: json['colors'].toString().split(', '),
        description: json['description'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id_favorit': this.idFavorite,
        'id_user': this.idUser,
        'id_shoes': this.idShoes,
      };
}
