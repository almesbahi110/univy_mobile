import 'package:flutter/material.dart';
import 'package:univy_mobile/providers/user.dart';


class UserProvider extends ChangeNotifier {
  UserAuth _user = UserAuth.getNewEmpty();
  UserAuth get user => _user;
  void setUser(String user) {
    _user = UserAuth.fromJson(user);
    notifyListeners();
  }

  void setObjectUser(UserAuth user) {
    _user = user;
    notifyListeners();
  }
}

