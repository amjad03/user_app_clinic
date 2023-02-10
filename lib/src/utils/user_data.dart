
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static SharedPreferences? preferences;


  static const _keyUsername = 'user_name';
  static const _keyUserage = 'user_age';
  static const _keyUsergender = 'user_gender';
  static const _keyUserblood = 'user_blood';
  static const _keyUserphone = 'user_phone';
  static const _keyUseremail = 'user_email';
  static const _keyUseraddress = 'user_address';


  static Future init() async =>
      preferences = await SharedPreferences.getInstance();


  //----------------------------------------------------------------//
  static Future setUserName(String username) async =>
      await preferences?.setString(_keyUsername, username);

  static String? getUserName() => preferences?.getString(_keyUsername);



  //----------------------------------------------------------------//
  static Future setUserAge(String age) async =>
      await preferences?.setString(_keyUsername, age);

  static String? getUserAge() => preferences?.getString(_keyUserage);



  //----------------------------------------------------------------//
  static Future setUserGender(String gender) async =>
      await preferences?.setString(_keyUsername, gender);

  static String? getUserGender() => preferences?.getString(_keyUsergender);



  //----------------------------------------------------------------//
  static Future setUserBlood(String blood) async =>
      await preferences?.setString(_keyUsername, blood);

  static String? getUserBlood() => preferences?.getString(_keyUserblood);



  //----------------------------------------------------------------//
  static Future setUserPhone(String phone) async =>
      await preferences?.setString(_keyUsername, phone);

  static String? getUserPhone() => preferences?.getString(_keyUserphone);



  //----------------------------------------------------------------//
  static Future setUserEmail(String email) async =>
      await preferences?.setString(_keyUsername, email);

  static String? getUserEmail() => preferences?.getString(_keyUseremail);




  //----------------------------------------------------------------//
  static Future setUserAddress(String address) async =>
      await preferences?.setString(_keyUsername, address);

  static String? getUserAddress() => preferences?.getString(_keyUseraddress);


}