import 'dart:convert';

class UserAuth{
  String? token;
  String? id;
  bool? isAuthenticated;
  String? message;
  String? username;
  String? roles;
  String? name;
  String? email;
  UserAuth(
      {
        this.roles,
        this.isAuthenticated,
        this.token,
        this.username,
        this.id,
        this.message,
        // this.stateGender,
        this.name,
        this.email,
      }
      );


  // factory UserAuth.fromJson(Map<String,dynamic>item){
  //   return UserAuth(
  //     token: item['token'],
  //     username: item['username'],
  //     id: item['id'],
  //     isAuthenticated: item['isAuthenticated'],
  //     message: item['message'],
  //     roles: item['roles'],
  //     // stateGender: item['stateGender'],
  //     name: item['name'],
  //     email: item['email'],
  //   );
  // }
  factory UserAuth.getNewEmpty() {
    return UserAuth(
        id: '',
        name: '',
      email: '',
      isAuthenticated: false,
      message: '',
      roles: '',
      token: '',
      username: ''

    );
  }
  Map<String,dynamic> toJson(){
    return  {
      "token": token,
      "id": id,
      "isAuthenticated": isAuthenticated,
      "roles":roles,
      "username":username,
      "message":message,
      "name":name,
      "email":email
    };
  }

  factory UserAuth.fromJson(String source) => UserAuth.fromMap(json.decode(source));


  factory UserAuth.fromMap(Map<String, dynamic> json) {
    return UserAuth(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        message: json["message"] ?? '',
        isAuthenticated: json["isAuthenticated"] ?? '',
        token: json["token"] ?? '',
        email: json["email"] ?? '',
        username: json["username"] ?? '',
      roles: json["roles"] ?? '',

    );
  }


}