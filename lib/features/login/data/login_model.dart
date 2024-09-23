class LoginModel {
  String? message;
  Data? data;
}

class Data {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  Data(this.name, this.email, this.phone, this.image, this.token);

  Data.formJson({required Map<String, dynamic> data});
}
