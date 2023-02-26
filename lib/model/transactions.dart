class Transactions {
  int idTransactions;
  int idUser;
  String listShop;
  String ekspedisi;
  String pembayaran;
  String? alamat;
  double total;
  String bukti;
  String arrived;
  DateTime tanggal;

  Transactions({
    required this.idTransactions,
    required this.arrived,
    required this.ekspedisi,
    required this.idUser,
    required this.bukti,
    required this.listShop,
    this.alamat,
    required this.pembayaran,
    required this.total,
    required this.tanggal,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        arrived: json['arrived'],
        ekspedisi: json['ekspedisi'],
        idTransactions: int.parse(json['id_transactions']),
        idUser: int.parse(json['id_user']),
        bukti: json['bukti'],
        listShop: json['list_shop'],
        pembayaran: json['pembayaran'],
        total: double.parse(json['total']),
        alamat: json['alamat'],
        tanggal: DateTime.parse(json['tanggal']),
      );

  Map<String, dynamic> toJson(String imageBase64) => {
        'ekspedisi': this.ekspedisi,
        'id_transactions': this.idTransactions.toString(),
        'id_user': this.idUser.toString(),
        'bukti': this.bukti,
        'image_file': imageBase64,
        'list_shop': this.listShop,
        'pembayaran': this.pembayaran,
        'total': this.total.toStringAsFixed(2),
        'alamat': this.alamat ?? '',
      };
}
