class Shoes {
  int idShoes;
  String namaBarang;
  List<String>? label;
  double price;
  List<String> sizes;
  List<String> colors;
  String? description;
  String image;

  Shoes({
    required this.colors,
    this.description,
    required this.idShoes,
    required this.image,
    required this.namaBarang,
    required this.price,
    required this.sizes,
    this.label,
  });

  factory Shoes.fromJson(Map<String, dynamic> json) => Shoes(
        idShoes: int.parse(json['id_shoes']),
        namaBarang: json['nama_barang'],
        label: json['label'].toString().split(', '),
        price: double.parse(json['price']),
        sizes: json['ukuran'].toString().split(', '),
        colors: json['colors'].toString().split(', '),
        description: json['description'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id_shoes': this.idShoes,
        'namaBarang': this.namaBarang,
        'label': this.label,
        'price': this.price,
        'sizes': this.sizes,
        'colors': this.colors,
        'description': this.description,
        'image': this.image,
      };
}
