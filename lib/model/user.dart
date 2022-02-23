class User {
  //data Type
  String? id;
  String? name;

// constructor
  User({
    this.id,
    this.name,
  });

  //method that assign values to respective datatype vairables
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
