import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  static bool isLogin = false;
  static String loginUserName = "";
  static String loginUserEmail = "";

  static Future saveUserLoggedInSharedPreference(bool isUserLoggedIn) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("ISLOGGEDIN", isUserLoggedIn);
    getUserLoggedInSharedPreference();
  }

  static Future saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("USERNAMEKEY", userName);
    getUserNameSharedPreference();
  }

  static Future saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("USEREMAILKEY", userEmail);
    getUserEmailSharedPreference();
  }

  static getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool("ISLOGGEDIN") ?? false;
    return isLogin;
  }

  static getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserName = prefs.getString("USERNAMEKEY") ?? "";
    return loginUserName;
  }

  static getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserEmail = prefs.getString("USEREMAILKEY") ?? "";
    return loginUserEmail;
  }

  static Future deleteSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
static Future<bool> updateUserName(String loginUserEmail, String yeniUserName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var users = await FirebaseFirestore.instance
      .collection('users')
      .where('Name', isEqualTo: yeniUserName)
      .get();

  if (users.docs.length > 0) {
    return false; // Kullanıcı adı zaten kullanımda
  } else {
    // Güncelleme işlemi
    var document = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: loginUserEmail)
        .get();

    if (document.docs.length == 1) {
      String documentId = document.docs.first.id;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .update({'Name': yeniUserName});

      return true; // Güncelleme başarılı
    } else {
      return false; // Kullanıcı belirtilen e-posta ile bulunamadı
    }
  }
}
}


 