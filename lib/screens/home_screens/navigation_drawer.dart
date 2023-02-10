import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app_clinic/screens/home_screens/settings.dart';

import '../../constants/constants.dart';
import '../../controller/database_controller/scannings/controller.dart';
import '../../src/repository/authentication_repository.dart';
import '../../src/theme/theme.dart';
import '../appointment/appointment/appointments_page.dart';
import '../appointment/scannings/all_available_scannings.dart';
import '../appointment/scannings/scannings_page.dart';
import '../contact_doctor/contact_doctor.dart';
import '../feedback/feedback_page.dart';
import '../profile_screens/profile_page.dart';
import 'dashboard.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  String name1="";
  String age1="";
  String gender1="";
  String blood1="";
  String phone1="";
  String email1="";
  String address1="";


  @override
  void initState() {
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

    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorSelected = themeProvider.themeMode == ThemeMode.light ? const Color(0xFF127AFE) : Colors.blue.shade300 ;

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Color(0xFF127AFE),
              color: colorSelected
            ), //BoxDecoration
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(address: address1.toString(),age: age1.toString(),blood: blood1.toString(),email: email1.toString(),gender: gender1.toString(),name: name1.toString(),phone: phone1.toString(),)));
              },
              child: UserAccountsDrawerHeader(
                // margin: EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(color: colorSelected),
                accountName: Text(
                  Constants.user_name,
                  style: const TextStyle(fontSize: 18,color: Colors.white),
                ),
                accountEmail: Text(Constants.user_email, style: const TextStyle(color: Colors.white)),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: CircleAvatar(
                  // backgroundColor: const Color(0xFF79B0F6),
                  backgroundColor: Colors.blue.shade500,
                  child: Text(
                    Constants.user_name_first_letter,
                    style: const TextStyle(fontSize: 30.0, color: Colors.white),
                  ), //Text
                ), //circleAvatar
              ),
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: customIcon(Icons.home),
            title: customText('Dashboard'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            leading: customIcon(Icons.event_available),
            title: customText('Book an Appointment '),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanningsPage()));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            leading: customIcon(Icons.pending_actions),
            title: customText('Appointment Status '),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentsPage()));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            leading: customIcon(Icons.person),
            title: customText('Profile '),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(address: address1.toString(),age: age1.toString(),blood: blood1.toString(),email: email1.toString(),gender: gender1.toString(),name: name1.toString(),phone: phone1.toString(),)));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            leading: customIcon(Icons.call),
            title: customText('Contact Us '),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactDoctor()));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            leading: customIcon(Icons.settings),
            title: customText('Settings '),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            leading: customIcon(Icons.share),
            title: customText('Share '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(height: 1,),
          ListTile(
            leading: customIcon(Icons.feedback),
            title: customText('Feedback '),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const FeedBackPage()));
            },
          ),
          const Divider(height: 1,),
          ListTile(
            leading: customIcon(Icons.logout),
            title: customText('LogOut'),
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
