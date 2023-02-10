import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app_clinic/src/widgets/notifications.dart';
import '../../../controller/database_controller/appointments/controller.dart';

//--------------carousel slider library --------------//
import '../../src/theme/theme.dart';
import '../../src/utils/user_data.dart';
import '../appointment/appointment/appointments.dart';
import '../appointment/appointment/appointments_page.dart';
import '../appointment/appointment/total_appointment_status.dart';
import '../carousel/carousel_page.dart';


//--------------- ntp package for real time ----------------//
import 'package:ntp/ntp.dart';
import 'package:url_launcher/url_launcher.dart';


//---------------------- screens ---------------------//
import 'package:user_app_clinic/screens/contact_doctor/contact_doctor.dart';
import 'package:user_app_clinic/screens/home_screens/settings.dart';
import 'package:user_app_clinic/src/widgets/google_map.dart';
import '../appointment/appointment_status.dart';
import '../appointment/scannings/scannings_page.dart';

import '../../constants/constants.dart';

//------------ Navigation Drawer ----------------------//

import '../profile_screens/profile_page.dart';
import 'navigation_drawer.dart';




class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // var dt = DateTime.now();

  String name1="";
  String age1="";
  String gender1="";
  String blood1="";
  String phone1="";
  String email1="";
  String address1="";

  DateTime ntpTime = DateTime.now();
  late DateTime ntpTimeNew ;

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.initializeNotifications();
    _loadNtpTime();
    Constants();
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

  void _loadNtpTime() async {
    ntpTime = await NTP.now();
    setState(() {
      ntpTimeNew = ntpTime;
    });
  }

  @override
  Widget build(BuildContext context) {

    var time = ntpTime.hour;
    var timecheck1 = (time>=9&&time<19) ? "Clinic is Opened " : "Clinic is Closed" ;
    var timecheck2 = (time>=9&&time<19) ? "Closes at 07:00 pm" : "Opens Tomorrow at 9:30 am" ;


    // var clinic_name = FirebaseDatabase.instance.ref().child('Clinic Info/clinic_name').get();
    // var doctor_name = FirebaseDatabase.instance.ref().child('Clinic Info/doctor_name').get();
    // var doctor_stream = FirebaseDatabase.instance.ref().child('Clinic Info/stream').get();
    // var experience = FirebaseDatabase.instance.ref().child('Clinic Info/experience').get();
    // var doctor_experience = "10+ years of experience in\n $experience";
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.themeMode == ThemeMode.dark ? Colors.grey.shade700 : Colors.white ;
    final colorGrey = themeProvider.themeMode == ThemeMode.dark ? Colors.grey.shade800 : Colors.grey.shade300 ;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
        elevation: 5,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                child: const Icon(Icons.person),
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(address: address1.toString(),age: age1.toString(),blood: blood1.toString(),email: email1.toString(),gender: gender1.toString(),name: name1.toString(),phone: phone1.toString(),)));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: const Icon(Icons.settings),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            // color: Colors.white
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: const [
                  //   BoxShadow(
                  //     color: Colors.black26,
                  //     blurRadius: 10,
                  //   )
                  // ]
                  border: Border.all(
                    color: Colors.black26
                  )
              ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactDoctor()));
                  },
                  child:  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Welcome To ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        const SizedBox(height: 10,),
                        Text(Constants.hospital_name.toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactDoctor()));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(11),
                            padding: const EdgeInsets.all(11),
                            width: double.maxFinite,
                            height: 100,
                            decoration: BoxDecoration(
                                color: colorGrey,
                                borderRadius: BorderRadius.circular(11)
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  fit: StackFit.loose,
                                  alignment: Alignment.topRight,
                                  children: <Widget>[
                                    Container(
                                      width: 70,
                                      height: 70,
                                      // margin: const EdgeInsets.only(top: 8,right: 8),
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              image: AssetImage('assets/images/doctor.jpg'),
                                              fit: BoxFit.cover
                                          ),
                                          borderRadius: BorderRadius.circular(11),
                                          border: Border.all(color: (time>=9&&time<19) ? Colors.green :Colors.red,width: 3)
                                      ),
                                    ),
                                    // Positioned(
                                    //   top: 0,
                                    //   right: 0,
                                    //   child: Container(
                                    //     width: 20,
                                    //     height: 20,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(50),
                                    //       color: (time>=9&&time<19) ? Colors.green :Colors.red,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Constants.doctor_name.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                      Text(Constants.doctor_stream.toString(),style: const TextStyle(fontSize: 14),),
                                      if(time>=9&&time<19)
                                        Text(Constants.doctor_available.toString(),style: TextStyle(fontSize: 15,color: Colors.green.shade500,fontWeight: FontWeight.w500),)
                                      else
                                        Text(Constants.doctor_unavailable.toString(),style: TextStyle(fontSize: 15,color: Colors.red.shade500,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(color: Colors.black45,indent: 11,endIndent: 11,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 27.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/medical_logo_new.png',),
                                      fit: BoxFit.cover,
                                      // colorFilter:
                                    )
                                ),
                              ),
                              const SizedBox(width: 25,),
                              Text(Constants.doctor_experience.toString(),textAlign: TextAlign.center,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.black45,indent: 11,endIndent: 11,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(timecheck1,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            const SizedBox(width: 10,),
                            Text(timecheck2,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(color: Colors.black26,),
              const SizedBox(height: 10,),
              // const BannerSlider(),
              const CustomBannerSlider(),
              const SizedBox(height: 10,),
              const Divider(color: Colors.black26,),
              const SizedBox(height: 10,),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          child: cardWithIconAndText(Icons.perm_contact_calendar,"Book an Appointment"),
                        onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanningAvailable()));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanningsPage()));
                        },
                      ),
                      // const SizedBox(width: 20,),
                      InkWell(
                          child: cardWithIconAndText(Icons.pending_actions,"Appointment Status"),
                        onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentsPage()));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const TotalAppointments()));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  // InkWell(
                  //   onTap: () {
                  //     Uri call = Uri.parse('tel:9986458809');
                  //     launchUrl(call);
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(12.0),
                  //     child: Container(
                  //       width: double.minPositive,
                  //       height: 150,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         color: const Color(0xFF127AFE),
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Container(
                  //             width: 70,
                  //             height: 70,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(50),
                  //                 color: Colors.white
                  //             ),
                  //             child: const Center(
                  //               child: Icon(Icons.contact_phone,size: 50,color: Colors.black45,),
                  //             ),
                  //           ),
                  //           const SizedBox(height: 10,),
                  //           const Center(
                  //             child: Text("Contact Clinic",
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //               textAlign: TextAlign.center,
                  //             ),
                  //
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Uri call = Uri.parse(Constants.clinic_number);
                          Uri call = Uri.parse('tel:9986458809');
                          launchUrl(call);
                        },
                          child: cardWithIconAndText(Icons.contact_phone,"Contact Clinic")),
                      // const SizedBox(width: 20,),
                      InkWell(
                        onTap: () {
                          // MapUtils.openMap(14.632598196453523, 74.84669784272853);
                          MapUtils.openMap(Constants.map_lattitude, Constants.map_longitude);
                        },
                          child: cardWithIconAndText(Icons.place,"Clinic Address")
                      ),
                    ],
                  )
                ],
              ),
              ),
              const SizedBox(height: 10,),
              const Divider(color: Colors.black26,),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.maxFinite,
                child: InkWell(
                  onTap: () {
                    // // MapUtils.openMap(14.632598196453523,74.84669784272853);
                    // User? user = FirebaseAuth.instance.currentUser;
                    // // print((user).toString());
                    MapUtils.openMap(Constants.map_lattitude, Constants.map_longitude);
                  },
                  child: const Image(
                    image: AssetImage('assets/images/google_map.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Divider(color: Colors.black26,),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () async{
                    // notificationServices.scheduleNotification();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TotalAppointments()));

                    // SharedPreferences sp = await SharedPreferences.getInstance();
                    // // sp.setString('name', 'user name');
                    // var name = sp.getString('name');
                    // print(name);
                  },
                  child: Text("Send Notification")
              )
            ],
          ),
        ),
      ),
      drawer: NavigationDrawer(),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: const EdgeInsets.all(0),
      //     children: [
      //       DrawerHeader(
      //         decoration: const BoxDecoration(
      //           color: Color(0xFF127AFE),
      //         ), //BoxDecoration
      //         child: InkWell(
      //           onTap: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
      //           },
      //           child: UserAccountsDrawerHeader(
      //             // margin: EdgeInsets.symmetric(horizontal: 22),
      //             decoration: BoxDecoration(color: Color(0xFF127AFE)),
      //             accountName: Text(
      //               Constants.user_name,
      //               style: const TextStyle(fontSize: 18),
      //             ),
      //             accountEmail: Text(Constants.user_email),
      //             currentAccountPictureSize: const Size.square(50),
      //             currentAccountPicture: CircleAvatar(
      //               backgroundColor: Color(0xFF79B0F6),
      //               child: Text(
      //                 Constants.user_name_first_letter,
      //                 style: TextStyle(fontSize: 30.0, color: Colors.white),
      //               ), //Text
      //             ), //circleAvatar
      //           ),
      //         ), //UserAccountDrawerHeader
      //       ), //DrawerHeader
      //       ListTile(
      //         leading: customIcon(Icons.home),
      //         title: customText('Dashboard'),
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
      //         },
      //       ),
      //       const Divider(height: 1,),
      //       ListTile(
      //         leading: customIcon(Icons.event_available),
      //         title: customText(' Book an Appointment '),
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => AvailableScanning(data: scanningController.scanningItemList,)));
      //         },
      //       ),
      //       const Divider(height: 1,),
      //       ListTile(
      //         leading: customIcon(Icons.pending_actions),
      //         title: customText(' Appointment Status '),
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentStatus()));
      //         },
      //       ),
      //       const Divider(height: 1,),
      //       ListTile(
      //         leading: customIcon(Icons.person),
      //         title: customText(' Profile '),
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
      //         },
      //       ),
      //       const Divider(height: 1,),
      //       ListTile(
      //         leading: customIcon(Icons.call),
      //         title: customText(' Contact Us '),
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactDoctor()));
      //         },
      //       ),
      //       const Divider(height: 1,),
      //       ListTile(
      //         leading: customIcon(Icons.settings),
      //         title: customText(' Settings '),
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
      //         },
      //       ),
      //       const Divider(height: 1,),
      //       ListTile(
      //         leading: customIcon(Icons.share),
      //         title: customText(' Share '),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       const Divider(height: 1,),
      //       ListTile(
      //         leading: customIcon(Icons.feedback),
      //         title: customText(' Feedback '),
      //         onTap: () {
      //           Navigator.push(context,MaterialPageRoute(builder: (context) => const FeedBackPage()));
      //         },
      //       ),
      //       const Divider(height: 1,),
      //       ListTile(
      //         leading: customIcon(Icons.logout),
      //         title: customText('LogOut'),
      //         onTap: () {
      //           // Navigator.pop(context);
      //           AuthenticationRepository.instance.logout();
      //         },
      //       ),
      //       const Divider(height: 1,),
      //     ],
      //   ),
      // ),
    );
  }


}






//-----------Custom Icon------------------//
Widget customIcon(IconData icon){
  return Icon(icon,size: 24,);
}



//--------------Custom Text-----------------//
Widget customText(String title){
  return Text(title,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),);
}






//-------------------Banner Slider--------------------------//
// class BannerSlider extends StatefulWidget {
//   const BannerSlider({Key? key}) : super(key: key);
//
//   @override
//   State<BannerSlider> createState() => _BannerSliderState();
// }
//
// class _BannerSliderState extends State<BannerSlider> {
//
//   final urlImages = [
//     'assets/images/banner1.jpeg',
//     'assets/images/banner2.jpeg',
//     'assets/images/banner3.jpeg',
//     'assets/images/banner4.jpeg',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CarouselSlider.builder(
//               itemCount: urlImages.length,
//               itemBuilder: (context,index,realIndex){
//                 final urlImage = urlImages[index];
//                 return buildImage(urlImage,index);
//               },
//               options: CarouselOptions(height: 170,autoPlay: true,))
//         ],
//       ),
//     );
//   }
// }
//
// Widget buildImage(String urlImage, int index) => Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(7)
//   ),
//   margin: const EdgeInsets.symmetric(horizontal: 7),
//   child: Image.asset(urlImage,fit: BoxFit.fill,),
// );

//---------------------------Banner Slider Ends--------------------//









//-------------------Grid Layout --------------------------//

// class GridLayout extends StatefulWidget {
//   const GridLayout({Key? key}) : super(key: key);
//
//   @override
//   State<GridLayout> createState() => _GridLayoutState();
// }
//
// class _GridLayoutState extends State<GridLayout> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 90,
//       height: 90,
//       // margin: const EdgeInsets.all(0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               cardWithIconAndText(Icons.perm_contact_calendar,"Book an Appointment"),
//               const SizedBox(width: 20,),
//               cardWithIconAndText(Icons.pending_actions,"Appointment Status"),
//             ],
//           ),
//           const SizedBox(height: 20,),
//           Row(
//             children: [
//               cardWithIconAndText(Icons.contact_phone,"Contact Clinic"),
//               const SizedBox(width: 20,),
//               cardWithIconAndText(Icons.place,"Clinic Address"),
//             ],
//           )
//         ],
//       )
//     );
//   }
// }

Widget cardWithIconAndText(IconData icon,String title){
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xFF127AFE),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white
          ),
          child: Center(
            child: Icon(icon,size: 50,color: Colors.black45,),
          ),
        ),
        const SizedBox(height: 10,),
        Center(
          child: Text(title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),

        )
      ],
    ),
  );
}
//-------------------Grid Layout ends--------------------------//











// class MapUtils {
//
//   MapUtils._();
//
//   static Future<void> openMap(double latitude, double longitude) async {
//     Uri googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
//     if (await canLaunchUrl(googleUrl)) {
//       await launchUrl(googleUrl);
//     } else {
//       throw 'Could not open the map.';
//     }
//   }
// }
// openMap(14.632598196453523, 74.84669784272853);