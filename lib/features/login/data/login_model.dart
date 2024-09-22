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
/*
    "status": true,
    "message": "تم تسجيل الدخول بنجاح",
    "data": {
        "id": 55608,
        "name": "shimaa refaat",
        "email": "alshimaa.refaat@ibm.com",
        "phone": "011415281",
        "image": "https://student.valuxapps.com/storage/assets/defaults/user.jpg",
        "points": 0,
        "credit": 0,
        "token": "1B20yZ2DIZO3iDrWPIpwxuPiKM3ekFhEHXaCRZZ9R6MsxIqoF9YIjnmWpvmguirNDM09Fq"
        }
        */

        /*
    "status": false,
    "message": "لم نتمكن من تسجيل الدخول برجاء التأكد من البيانات المدخلة",
    "data": null
        */