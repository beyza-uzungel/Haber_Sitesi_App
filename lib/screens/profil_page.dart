import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:my_news_app_/helpers/auth_helper_data.dart';
import 'package:my_news_app_/helpers/login_user_data.dart';
import 'package:my_news_app_/widgets/diyalog.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String loginUserName = LoginUserData.loginUserData;
  String loginUserEmail = LoginUserData.loginUserEmail;
  TextEditingController? _controllerUserName;
  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerUserName?.text = loginUserName;

    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xff9b1b30),
          title: Text('Profilim'),
          actions: [
            GestureDetector(
              onDoubleTap: () {},
              child: IconButton(
                  onPressed: () {},
                  tooltip: 'Puan ver',
                  icon: Icon(Icons.star)),
            ),
            GestureDetector(
              onLongPress: () {},
              child: IconButton(
                  onPressed: () {},
                  tooltip: 'Paylaş',
                  icon: Icon(Icons.share)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 170,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text('Kameradan Çek'),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text('Galeriden Seç'),
                                onTap: () {},
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: AdvancedAvatar(
                    size: 128,
                    name: loginUserName,
                    statusColor: Colors.green,
                    statusAlignment: Alignment.bottomRight,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: loginUserEmail,
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: 'Emailiniz',
                      hintText: 'email',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerUserName,
                  decoration: InputDecoration(
                      labelText: 'User Name',
                      hintText: 'User',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Değişiklikleri Kaydet'),
                  onPressed: () {
                    _userNameGuncelle(context);
                  },
                ),
              )
            ],
          )),
        ));
  }
void _userNameGuncelle(BuildContext context) async {
  if (loginUserName != _controllerUserName?.text) {
    var updateResult = await HelperFunctions.updateUserName(
      loginUserEmail,
      _controllerUserName!.text,
    );

    if (updateResult == true) {
      setState(() {
        loginUserName = _controllerUserName!.text;
      });

      PlatformDuyarliAlertDialog(
        baslik: "Başarılı",
        icerik: "Kullanıcı adı güncellendi",
        anaButonYazisi: 'Tamam',
      ).goster(context);
    } else {
      _controllerUserName?.text = loginUserName;
      PlatformDuyarliAlertDialog(
        baslik: "Hata",
        icerik: "Kullanıcı adı zaten kullanımda, farklı bir kullanıcı adı deneyiniz",
        anaButonYazisi: 'Tamam',
      ).goster(context);
    }
  }
}
}
