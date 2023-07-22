class User {
  int? id;
  String? name;
  String? password;

  User({
    this.id,
    this.name,
    this.password,
  });

  User.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        name = result["name"],
        password = result["password"];

  Map<String, Object> toMap() {
    return {
      'name': name!,
      'password': password!,
    };
  }
}
