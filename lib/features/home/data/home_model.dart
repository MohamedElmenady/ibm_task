class HomeModel {
  String? message;
  String? userName;
  String? image;
  String? id;

  HomeModel(
      {required this.message,
      required this.userName,
      required this.image,
      required this.id});
  HomeModel.formjson({required Map<String, dynamic> data}) {
    message = data['message'];
    userName = data['userName'];
    image = data['image'];
    id = data['id'];
  }
}
