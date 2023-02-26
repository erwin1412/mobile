class Keranjang {
  int idKeranjang;
  int idUser;
  int idShoes;
  String namaBarang;
  List<String>? label;
  double price;
  List<String> sizes;
  List<String> colors;
  String? description;
  String image;
  int quantity;
  String color;
  String size;

  Keranjang({
    required this.colors,
    this.description,
    required this.idKeranjang,
    required this.idShoes,
    required this.idUser,
    required this.image,
    required this.namaBarang,
    required this.price,
    required this.sizes,
    this.label,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory Keranjang.fromJson(Map<String, dynamic> json) => Keranjang(
        idKeranjang: int.parse(json['id_keranjang']),
        idShoes: int.parse(json['id_shoes']),
        idUser: int.parse(json['id_user']),
        namaBarang: json['nama_barang'],
        label: json['label'].toString().split(', '),
        price: double.parse(json['price']),
        sizes: json['ukuran'].toString().split(', '),
        colors: json['colors'].toString().split(', '),
        description: json['description'],
        image: json['image'],
        quantity: int.parse(json['quantity']),
        color: json['color'],
        size: json['size'],
      );

  Map<String, dynamic> toJson() => {
        'id_keranjang': this.idKeranjang,
        'id_shoes': this.idShoes,
        'id_User': this.idUser,
        'quantity': this.quantity,
        'color': this.color,
        'size': this.size,
      };
}
