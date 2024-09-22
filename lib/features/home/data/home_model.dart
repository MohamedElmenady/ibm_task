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

/*
"message": "Human Brand Officer",
"userName": "Gerardo Abbott",
"image": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1097.jpg",
"time": "time 1",
"isActive": false,
"id": "1"
*/