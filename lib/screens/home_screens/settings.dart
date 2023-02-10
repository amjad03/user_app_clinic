import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/repository/authentication_repository.dart';
import '../../src/widgets/change_theme_button.dart';
import '../about/about.dart';
import '../profile_screens/profile_page.dart';
import '../profile_screens/update_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String name1="";
  String age1="";
  String gender1="";
  String blood1="";
  String phone1="";
  String email1="";
  String address1="";

  bool enableTheme = false;
  bool enablePromo = true;
  bool enablePersonal = true;

  Future<void> _showMyDialogForTheme(String title,String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title!'),
          content: Text(content),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    setState(() {
                      enableTheme = !enableTheme;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  Future<void> _showMyDialogForPromo(String title,String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title!'),
          content: Text(content),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    setState(() {
                      enablePromo = !enablePromo;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  Future<void> _showMyDialogForPersonal(String title,String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title!'),
          content: Text(content),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    setState(() {
                      enablePersonal = !enablePersonal;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name1 = sp.getString('name')!;
    age1 = sp.getString('age')!;
    gender1 = sp.getString('gender')!;
    blood1 = sp.getString('blood')!;
    phone1 = sp.getString('phone')!;
    email1 = sp.getString('email')!;
    address1 = sp.getString('address')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        // backgroundColor: Colors.white,
        // iconTheme: IconThemeData(color: ThemeMode == ThemeMode.dark ? Colors.white : Colors.black),
      ),
      body: Column(
        children: [
          // ListTile(
          //   title: enableTheme ? const Text("Change to Light Theme",style: TextStyle(fontSize: 20,),) : const Text("Change to Dark Theme",style: TextStyle(fontSize: 20),),
          //   trailing: Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     // child: enableTheme ? const Icon(Icons.toggle_on,size: 40,color: Colors.blue,) : const Icon(Icons.toggle_off,size: 40,)
          //   ),
          //   onTap: () {
          //     _showMyDialogForTheme("Confirmation","Do you want to change your Theme?");
          //     // setState(() {
          //     //   enableTheme = !enableTheme;
          //     // });
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Change Theme",style: TextStyle(fontSize: 20,),),
                ChangeThemeButton()
              ],
            ),
          ),
          const Divider(height: 1,),
          ExpansionTile(
              title: const Text("Manage Notifications",style: TextStyle(fontSize: 20),),
            trailing: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_drop_down,size: 30,),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: ListTile(
                  title: const Text("Promotion Notifications",style: TextStyle(fontSize: 20),),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                      child: enablePromo ? const Icon(Icons.toggle_on,size: 40,color: Colors.blue,) : const Icon(Icons.toggle_off,size: 40,)
                  ),
                  onTap: () {
                    if(enablePromo == true) {
                      _showMyDialogForPromo("Confirmation",
                          "Do you want to off the notification?");
                    }
                    else{
                    setState(() {
                      enablePromo = !enablePromo;
                    });
                    }
                  },
                ),
              ),
              const Divider(height: 1,indent: 12,endIndent: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: ListTile(
                  title: const Text("Personal Notifications",style: TextStyle(fontSize: 20),),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                      child: enablePersonal ? const Icon(Icons.toggle_on,size: 40,color: Colors.blue,) : const Icon(Icons.toggle_off,size: 40,)
                  ),
                  onTap: () {
                    if(enablePersonal == true) {
                      _showMyDialogForPersonal("Do you want to off the notification?","Remember , You will not receive any kind of notifications which belongs to your appointment alert in the future");
                    }
                    else {
                      setState(() {
                      enablePersonal = !enablePersonal;
                    });
                    }
                  },
                ),
              ),
            ],
          ),
          const Divider(height: 1,),
          const ListTile(
            title: Text("Rate Us",style: TextStyle(fontSize: 20),),
            trailing: Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.star,size: 30,),
            ),
          ),
          const Divider(height: 1,),
          ListTile(
            title: const Text("Update Profile",style: TextStyle(fontSize: 20),),
            trailing: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.update,size: 30,),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(address: address1.toString(),age: age1.toString(),blood: blood1.toString(),email: email1.toString(),gender: gender1.toString(),name: name1.toString(),phone: phone1.toString(),)));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            title: const Text("About",style: TextStyle(fontSize: 20),),
            trailing: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.info,size: 30,),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            title: const Text("Logout",style: TextStyle(fontSize: 20),),
            trailing: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(Icons.logout,size: 30,),
            ),
            onTap: () {
              Navigator.pop(context);
              AuthenticationRepository.instance.logout(context);
            },
          ),
          const Divider(height: 1,),
        ],
      ),
    );
  }
}
