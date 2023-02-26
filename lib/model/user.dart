class User {
  int idUser;
  String name;
  String email;
  String password;
  String phone;

  User(this.idUser, this.name, this.email, this.password, this.phone);

  factory User.fromJson(Map<String, dynamic> json) => User(
        int.parse(json['id_user']),
        json['name'],
        json['email'],
        json['password'],
        json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'id_user': this.idUser.toString(),
        'name': this.name,
        'email': this.email,
        'password': this.password,
        'phone': this.phone,
      };
}
