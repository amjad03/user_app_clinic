import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../src/theme/theme.dart';



class ContactDoctor extends StatefulWidget {
  const ContactDoctor({Key? key}) : super(key: key);

  @override
  State<ContactDoctor> createState() => _ContactDoctorState();
}

class _ContactDoctorState extends State<ContactDoctor> {
  // var dt = DateTime.now();
  DateTime ntpTime = DateTime.now();
  DateTime ntpTimeNew = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadNtpTime();
  }


  // void _loadNtpTime() async {
  //   setState(() async {
  //     ntpTime = await NTP.now();
  //   });
  // }
  void _loadNtpTime() async {
    ntpTime = await NTP.now();
    setState(() {
      ntpTimeNew = ntpTime;
    });
  }
  bool readMore = false;
  @override
  Widget build(BuildContext context) {
    var time = ntpTime.hour;
    var timecheck1 = (time>=9&&time<19) ? "Clinic is Opened " : "Clinic is Closed" ;
    var timecheck2 = (time>=9&&time<19) ? "Closes at 07:00 pm" : "Opens Tomorrow at 9:30 am" ;


    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.themeMode == ThemeMode.dark ? Colors.grey.shade700 : Colors.grey.shade300 ;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Doctor"),
        centerTitle: true,
        // backgroundColor: Colors.white,
        // iconTheme: const IconThemeData.fallback(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(11),
                padding: const EdgeInsets.all(11),
                width: double.maxFinite,
                height: 120,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(11)
                ),
                child: Row(
                  children: [
                    // Container(
                    //   width: 100,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //     image: const DecorationImage(
                    //       image: AssetImage('assets/images/doctor.jpg'),
                    //       fit: BoxFit.cover
                    //     ),
                    //     borderRadius: BorderRadius.circular(11),
                    //     border: Border.all(color: Colors.black45,width: 0.5)
                    //   ),
                    // ),
                    Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8,right: 8),
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/doctor.jpg'),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(color: Colors.black45,width: 0.5)
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: (time>=9&&time<19) ? Colors.green :Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Dr.William Watson",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                          Text("MBBS,MD",style: TextStyle(fontSize: 14),),
                          Text("Immunologist",style: TextStyle(fontSize: 14),),
                          Text("SSS Clinic Sirsi (U.k)",style: TextStyle(fontSize: 11),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.star,color: Colors.orange,),
                            Icon(Icons.star,color: Colors.orange,),
                            Icon(Icons.star,color: Colors.orange,),
                            Icon(Icons.star,color: Colors.orange,),
                            Icon(Icons.star,color: Colors.orange,),
                          ],
                        ),
                        const SizedBox(height: 7,),
                        const Text("4.8 ratings")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("3000+"),
                        SizedBox(height: 7,),
                        Text("reviews")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("5000+"),
                        SizedBox(height: 7,),
                        Text("patients")
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7,),
              const Divider(color: Colors.black45,indent: 11,endIndent: 11,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/medicalLogo.jpg'),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    SizedBox(width: 25,),
                    Text("10+ years of experiance in\nImmunology",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              const Divider(color: Colors.black45,indent: 11,endIndent: 11,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Text("About William Watson :",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                    const SizedBox(height: 10,),
                    Text(maxLines: readMore ? 10 : 4,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w300),"Dr. William Watson is the top most immunologist in the town of Sirsi. He has achived several awards for his wonderful contribution in medical field. He is available for private consultation.Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit, numquam veniam? Aspernatur, facilis. Nam pariatur earum consequatur fugit consequuntur sequi!"),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          readMore = !readMore;
                        });
                      },
                      child: Text(readMore ? "Read Less" : "Read More",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 10,),
                      Text("Working Time :",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                      SizedBox(height: 10,),
                      Text(style: TextStyle(fontWeight: FontWeight.w300),"Monday - Saturday, 09:00 AM - 07:00 PM "),
                    ]
                ),
              ),
              const SizedBox(height: 25,),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Uri call = Uri.parse('tel:9986458809');
                    launchUrl(call);
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF0527DB),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.call,color: Colors.white,),
                          SizedBox(width: 11,),
                          Text("Call Us",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
