import 'package:logbox_academic/model/user.dart';

class RootState {
  late User user;

  // Singleton code
  static final RootState _singleton = RootState._internal();
  factory RootState() {
    return _singleton;
  }
  RootState._internal();
}
