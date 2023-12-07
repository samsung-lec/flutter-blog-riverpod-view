class User {
  int id;
  String username;
  String imgUrl;

  User({required this.id, required this.username, required this.imgUrl});

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["username"],
        imgUrl = json["imgUrl"];
}
