// ignore_for_file: empty_constructor_bodies

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? password;

  UserModel({
      this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.password});
  
  // data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      password: map['password']
    );
  }

  // sending data our server
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password
    };
  }

}