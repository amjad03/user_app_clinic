import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_app_clinic/constants/constants.dart';
import 'package:user_app_clinic/screens/appointment/appointment_status.dart';
import 'package:user_app_clinic/src/utils/payment.dart';

import '../../controller/auth_controller/sing_up_controller.dart';
import '../../controller/book_appointment_controller/book_appointment_controller.dart';
import '../../src/theme/theme.dart';
import '../../src/widgets/SelectBox.dart';
import '../../src/widgets/widgets.dart';
import '../../src/utils/time_stamp_for_appointment.dart';
import 'book_appointment/book_an_appointment.dart';

DateTime selectedDate = DateTime.now();
var date = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";


class BookAnAppointment extends StatefulWidget {
  BookAnAppointment({Key? key,
    required this.type,
    required this.price,
    required this.duration,
  }) : super(key: key);

  final String type;
  final String price;
  final String duration;

  static String time = DateTime.now().hour.toString();
  static String index = "";

  // static updateTimeSlot(String t,int i){
  //   this.time = t;
  //   index = i;
  // }

  @override
  State<BookAnAppointment> createState() => _BookAnAppointmentState();
}

class _BookAnAppointmentState extends State<BookAnAppointment> {
  _BookAnAppointmentState() {
    _selectedBloodGroup = _bloodGroupList[0];
    _selectedGender = _genderList[0];
  }

  bool isLoading = false;

  //------------- For blood Group --------------//
  final _bloodGroupList = [
    "Select",
    "A+",
    "B+",
    "O+",
    "AB+",
    "A-",
    "B-",
    "O-",
    "AB-",
  ];
  String? _selectedBloodGroup = "";

  //------------- For Gender  --------------//
  final _genderList = [
    "_Select_",
    "Male",
    "Female",
    "Others",
  ];
  String? _selectedGender = "";
  IconData? icon;

  final _timeStamp = [
    '09:30 - 10:30',
    '10:30 - 11:30',
    '11:30 - 12:30',
    '12:30 - 01:30',
    '02:30 - 03:30',
    '03:30 - 04:30',
    '04:30 - 05:30',
    '05:30 - 06:30',
    '06:30 - 07:30'
  ];


  // static String time = DateTime.now().hour.toString();

  String? myselfOrOthters;

  String? paymentMode;

  //-------------- text editing controller ----------------------//
  TextEditingController patient_name = TextEditingController();
  TextEditingController patient_age = TextEditingController();
  TextEditingController patient_phone = TextEditingController();
  TextEditingController patient_address = TextEditingController();
  TextEditingController patient_gender = TextEditingController();
  TextEditingController patient_blood = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();


    final themeProvider = Provider.of<ThemeProvider>(context);

    bool value = false;

    _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Booking!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    children: [
                      boldText("Name :"),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(patient_name.text.toString(),overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      boldText("Scan Type :"),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(widget.type.toString(),overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      boldText("Scan Amount :"),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Rs: ${widget.price.toString()}',overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      boldText("Date :"),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(date.toString(),overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      boldText("Time :"),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(BookAnAppointment.time.toString(),overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      boldText("Payment Mode :"),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 80,
                        alignment: Alignment.centerRight,
                        child: Text("paymentMode!",maxLines: 1,overflow: TextOverflow.ellipsis,)
                      )
                    ],
                  ),
                ],
              ),
            ),
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
                    onPressed: () async{
                      // Navigator.of(context).pop();
                      if(_formKey.currentState!.validate()) {
                        BookAppointmentController.instance.bookAppointment(
                            patient_name.text.toString(),
                            patient_age.text.toString(),
                            _selectedBloodGroup.toString(),
                            _selectedGender.toString(),
                            patient_phone.text.toString(),
                            patient_address.text.toString(),
                            date.toString(),
                            // DateTime.now().hour.toString(),
                            BookAnAppointment.time.toString(),
                            BookAnAppointment.index.toString(),
                            widget.price.toString(),
                            widget.type.toString(),
                            "pending",
                            "pending",
                            context
                        );
                        Navigator.of(context).pop();
                        await BookAppointmentController.instance.showSuccess(context);
                        // Future.delayed(const Duration(seconds: 5),() => Navigator.pop(context));
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              "Book An Appointment",
            ),
            centerTitle: true,
            // backgroundColor: Colors.white,
            // iconTheme: const IconThemeData.fallback(),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    onChanged: myselfOrOthters == "myself" ? getUserData() : removeData(),
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text("For Myself"),
                            value: "myself",
                            dense: true,
                            groupValue: myselfOrOthters,
                              onChanged: (value){
                                setState(() {
                                  myselfOrOthters = value.toString();
                                });
                              },
                          )
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text("For Others"),
                            value: "others",
                            dense: true,
                            groupValue: myselfOrOthters,
                              onChanged: (value){
                                setState(() {
                                  myselfOrOthters = value.toString();
                                });
                              },
                          )
                        ),
                      ],
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //------------- Name --------------//
                        Row(
                          children: [
                            boldText("Name"),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              // child: textFieldWithoutIcon("Patient Name", TextInputType.text, false)
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  enabled: myselfOrOthters == "others" ? true : false,
                                  controller: patient_name,
                                  textAlign: TextAlign.start,
                                  cursorColor: Colors.grey,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      label: Text("Patient Full Name"),
                                      border: OutlineInputBorder(),
                                      iconColor: Colors.black45,
                                      // labelStyle: TextStyle(color: Colors.black45),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            // color: Colors.black45
                                        ),
                                      )
                                  ),
                                  validator: (value){
                                    if(value.toString().isEmpty){
                                      return "Required";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            boldText("Age"),
                            const SizedBox(
                              width: 10,
                            ),
                            //------------- Age --------------//
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(right: 20),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: TextFormField(
                                    enabled: myselfOrOthters == "others" ? true : false,
                                    controller: patient_age,
                                    textAlign: TextAlign.start,
                                    cursorColor: Colors.grey,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(15),
                                        label: Text("Age"),
                                        border: OutlineInputBorder(),
                                        iconColor: Colors.black45,
                                        // labelStyle: TextStyle(color: Colors.black45),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              // color: Colors.black45
                                          ),
                                        )
                                    ),
                                    validator: (value){
                                      if(value.toString().isEmpty){
                                        return "Required";
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              )
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            boldText("Blood"),
                            const SizedBox(
                              width: 5,
                            ),
                            //------------- Blood Group --------------//
                            // Expanded(
                            //     child: Container(
                            //     margin: const EdgeInsets.only(top: 15),
                            //     child: DropdownButtonFormField(
                            //       alignment: Alignment.center,
                            //       value: _selectedBloodGroup,
                            //       items: _bloodGroupList
                            //           .map((e) => DropdownMenuItem(
                            //                 value: e,
                            //                 child: Text(e),
                            //               ))
                            //           .toList(),
                            //       onChanged: (val) {
                            //         setState(() {
                            //           _selectedBloodGroup = val as String;
                            //         });
                            //       },
                            //       icon: const Icon(Icons.arrow_drop_down),
                            //       decoration: const InputDecoration(
                            //           labelText: "Blood Group",
                            //           // prefixIcon: Icon(Icons.bloodtype),
                            //           border: OutlineInputBorder(
                            //               borderSide:
                            //                   BorderSide(color: Colors.black45)),
                            //           focusedBorder: OutlineInputBorder(
                            //               borderSide:
                            //                   BorderSide(color: Colors.black45)),
                            //           labelStyle: TextStyle(color: Colors.black45),
                            //           contentPadding: EdgeInsets.all(13.0)),
                            //     ),
                            //   )
                            // ),
                            Expanded(
                                child: myselfOrOthters == "others" ? Container(
                                  // margin: const EdgeInsets.only(top: 0),
                                  child: DropdownButtonFormField(
                                    alignment: Alignment.center,
                                    value: _selectedBloodGroup,
                                    items: _bloodGroupList
                                        .map((e) => DropdownMenuItem(
                                      enabled: (e.isAlphabetOnly) ? false : true,
                                      value: e,
                                      child: Text(e),
                                    ))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedBloodGroup = val as String;
                                      });
                                    },
                                    icon: const Icon(Icons.arrow_drop_down),
                                    decoration: const InputDecoration(
                                        labelText: "Blood Group",
                                        // prefixIcon: Icon(Icons.bloodtype),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black45)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black45)
                                        ),
                                        labelStyle: TextStyle(color: Colors.black45),
                                        contentPadding: EdgeInsets.all(13.0)
                                    ),
                                  ),
                                ) :
                                Expanded(
                                  // child: textFieldWithoutIcon("Patient Name", TextInputType.text, false)
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      enabled: false,
                                      controller: patient_blood,
                                      textAlign: TextAlign.start,
                                      cursorColor: Colors.grey,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(15),
                                          label: Text("Blood"),
                                          border: OutlineInputBorder(),
                                          iconColor: Colors.black45,
                                          // labelStyle: TextStyle(color: Colors.black45),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              // color: Colors.black45
                                            ),
                                          )
                                      ),
                                      validator: (value){
                                        if(value.toString().isEmpty){
                                          return "Required";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //------------- Gender --------------//
                        Row(
                          children: [
                            boldText("Select Gender"),
                            const SizedBox(
                              width: 20,
                            ),
                            // Expanded(
                            //     child: Container(
                            //     margin: const EdgeInsets.only(top: 8),
                            //     child: DropdownButtonFormField(
                            //       alignment: Alignment.center,
                            //       value: _selectedGender,
                            //       items: _genderList
                            //           .map((e) => DropdownMenuItem(
                            //                 value: e,
                            //                 child: Text(e),
                            //               ))
                            //           .toList(),
                            //       onChanged: (v) {
                            //         setState(() {
                            //           _selectedGender = v as String;
                            //           if (_selectedGender == "Male") {
                            //             icon = Icons.male;
                            //           } else if (_selectedGender == "Female") {
                            //             icon = Icons.female;
                            //           } else if (_selectedGender == "Others") {
                            //             icon = Icons.transgender;
                            //           }
                            //         });
                            //       },
                            //       icon: const Icon(Icons.arrow_drop_down),
                            //       decoration: InputDecoration(
                            //           labelText: "Gender",
                            //           prefixIcon: Icon(icon),
                            //           border: const OutlineInputBorder(
                            //               borderSide:
                            //                   BorderSide(color: Colors.black45)),
                            //           focusedBorder: const OutlineInputBorder(
                            //               borderSide:
                            //                   BorderSide(color: Colors.black45)),
                            //           labelStyle:
                            //               const TextStyle(color: Colors.black45),
                            //           contentPadding: const EdgeInsets.all(13.0)),
                            //     ),
                            //   )
                            // ),
                            Expanded(
                                child:myselfOrOthters == "others" ? Container(
                                  margin: const EdgeInsets.only(top: 10,bottom: 8),
                                  child: DropdownButtonFormField(
                                    alignment: Alignment.center,
                                    value: _selectedGender,
                                    items: _genderList
                                        .map((e) => DropdownMenuItem(
                                      enabled: (e.isAlphabetOnly) ? true : false,
                                      value: e,
                                      child: Text(e),
                                    ))
                                        .toList(),
                                    onChanged: (v) {
                                      setState(() {
                                        _selectedGender = v as String;
                                        if (_selectedGender == "Male") {
                                          icon = Icons.male;
                                        } else if (_selectedGender == "Female") {
                                          icon = Icons.female;
                                        } else if (_selectedGender == "Others") {
                                          icon = Icons.transgender;
                                        }
                                      }
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_drop_down),
                                    decoration: InputDecoration(
                                        labelText: "Gender",
                                        prefixIcon: Icon(icon),
                                        border: const OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black45)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.black45)),
                                        labelStyle:
                                        const TextStyle(color: Colors.black45),
                                        contentPadding: const EdgeInsets.all(13.0)),
                                  ),
                                ) :
                                Expanded(
                                  // child: textFieldWithoutIcon("Patient Name", TextInputType.text, false)
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      enabled: false,
                                      controller: patient_gender,
                                      textAlign: TextAlign.start,
                                      cursorColor: Colors.grey,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(15),
                                          label: Text("Patient Gender"),
                                          border: OutlineInputBorder(),
                                          iconColor: Colors.black45,
                                          // labelStyle: TextStyle(color: Colors.black45),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              // color: Colors.black45
                                            ),
                                          )
                                      ),
                                      validator: (value){
                                        if(value.toString().isEmpty){
                                          return "Required";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                            ),
                          ],
                        ),
                        //------------- Phone Number --------------//
                        Row(
                          children: [
                            // const Text("Phone "),
                            boldText("Phone"),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              // child: textFieldWithoutIcon("Phone Number", TextInputType.number, false)
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  enabled: myselfOrOthters == "others" ? true : false,
                                  controller: patient_phone,
                                  textAlign: TextAlign.start,
                                  cursorColor: Colors.grey,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      label: Text("Phone Number"),
                                      border: OutlineInputBorder(),
                                      // iconColor: Colors.black45,
                                      // labelStyle: TextStyle(color: Colors.black45),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            // color: Colors.black45
                                        ),
                                      )
                                  ),
                                  validator: (value){
                                    if(value.toString().isEmpty){
                                      return "Required";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        //------------- Address --------------//
                        Row(
                          children: [
                            boldText("Address"),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                // child: textFieldWithoutIcon("Enter Your full address", TextInputType.text, true),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: TextFormField(
                                  enabled: myselfOrOthters == "others" ? true : false,
                                  controller: patient_address,
                                  textAlign: TextAlign.start,
                                  cursorColor: Colors.grey,
                                  maxLines: 4,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      label: Text("Patient Full Adress"),
                                      border: OutlineInputBorder(),
                                      // iconColor: Colors.black45,
                                      // labelStyle: TextStyle(color: Colors.black45),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            // color: Colors.black45
                                        ),
                                      )
                                  ),
                                  validator: (value){
                                    if(value.toString().isEmpty){
                                      return "Required";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            boldText("Select Date"),
                            const SizedBox(
                              width: 20,
                            ),
                            const DatePicker()
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            boldText("Select Time"),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     timeStamp(_timeStamp[0], false),
                        //     timeStamp(_timeStamp[1], false),
                        //     timeStamp(_timeStamp[2], false),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     timeStamp(_timeStamp[3], true),
                        //     timeStamp(_timeStamp[4], false),
                        //     timeStamp(_timeStamp[5], false),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     timeStamp(_timeStamp[6], false),
                        //     timeStamp(_timeStamp[7], true),
                        //     timeStamp(_timeStamp[8], true),
                        //   ],
                        // // ),
                        const TimeStampList(),
                        // Expanded(
                        //     child: TimeStampList()
                        // ),
                        // TimeStampList(),
                        // const SizedBox(
                        //   width: double.maxFinite,
                        //     child: TimeStampList()
                        // ),
                        // const BookingCalendarDemoApp(),
                        const SizedBox(height: 10,),
                        const Divider(),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            boldText("Scan Duration :"),
                            const SizedBox(width: 10,),
                            boldText(widget.duration)
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            boldText("Scan Amount :"),
                            const SizedBox(width: 10,),
                            boldText("₹ ${widget.price}")
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Align(alignment: Alignment.centerLeft,child: boldText("Payment Mode :"),),
                        const SizedBox(height: 11,),
                        Form(
                          onChanged: paymentMode == "UPI" ? makePayment(context) : null,
                          child: Column(
                            children: [
                              RadioListTile(
                                title: const Text("Pay in Clinic"),
                                value: "Pay in Clinic",
                                // dense: true,
                                groupValue: paymentMode,
                                onChanged: (value){
                                  setState(() {
                                    paymentMode = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text("UPI"),
                                value: "UPI",
                                // dense: true,
                                groupValue: paymentMode,
                                onChanged: (value){
                                  setState(() {
                                    paymentMode = value.toString();
                                  });
                                },
                              ),
                              // paymentMode == "UPI" ? makePayment(context) : Container()
                              // RadioListTile(
                              //   title: const Text("Net Banking"),
                              //   value: "Net Banking",
                              //   // dense: true,
                              //   groupValue: paymentMode,
                              //   onChanged: (value){
                              //     setState(() {
                              //       paymentMode = value.toString();
                              //     });
                              //   },
                              // ),
                              // RadioListTile(
                              //   title: const Text("Debit / Credit Card"),
                              //   value: "Debit / Credit Card",
                              //   // dense: true,
                              //   groupValue: paymentMode,
                              //   onChanged: (value){
                              //     setState(() {
                              //       paymentMode = value.toString();
                              //     });
                              //   },
                              // )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        //------------- Book Appointment Button --------------//
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      )
                                  ),
                                  // backgroundColor: const MaterialStatePropertyAll<Color?>(
                                  //   Color(0xFF00527DB)
                                  // )
                              ),
                              onPressed: () async{
                                Navigator.pop(context);
                                await removeData();
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text("Cancel"),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                  ),
                                  // backgroundColor: const MaterialStatePropertyAll<Color?>(
                                  //   Color(0xFF00527DB)
                                  // )
                              ),
                              onPressed: () {
                                if(_formKey.currentState!.validate()) {
                                  _showMyDialog();
                                }
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const TimeStampList()));
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingCalendarDemoApp()));                          },
                              },
                              // onPressed: () async {
                              //   // Constants.data();
                              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                              //   if(_formKey.currentState!.validate()) {
                              //     BookAppointmentController.instance.bookAppointment(
                              //         patient_name.text.toString(),
                              //         patient_age.text.toString(),
                              //         _selectedBloodGroup.toString(),
                              //         _selectedGender.toString(),
                              //         patient_phone.text.toString(),
                              //         patient_address.text.toString(),
                              //         selectedDate.toString()
                              //     );
                              //
                              //   }
                              // },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text("Confirm"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.8,
          child: isLoading ? ModalBarrier(dismissible: false, color: Colors.black) : null,
        ),
        Center(
          child: isLoading ? CircularProgressIndicator() : null,
        ),
      ]
    );

  }

  makePayment(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(amount: '${widget.price}',)));
    // Payment();
    // void _launchURL() async {
    //   String _url='upi://pay?pa=dinesh@dlanzer&pn=Dinesh&am=1&tn=Test Payment&cu=INR';
    //   Uri uri = Uri.parse(_url);
    //   var result = await launchUrl(uri);
    //   debugPrint(result.toString());
    //   if (result ==true) {
    //     print("Done");
    //   } else if (result ==false){
    //     print("Fail");
    //   }
    // }
  }

  getUserData() {
    // setState(() {
    //   isLoading = true;
    // });
    // print(isLoading);
    // void hide(){
    //   setState((){
    //     isLoading = false;
    //   });
    // }
    // isLoading = true;
    // ShowProgressIndicator();
    Future<void> getData()async{
      User? user = await FirebaseAuth.instance.currentUser;
      var thisUser = user?.uid.toString() as String;

      DatabaseReference ref = FirebaseDatabase.instance.ref("Users").child(thisUser);

      DatabaseReference name = ref.child('name');
      DatabaseEvent event1 = await name.once();
      patient_name.text = event1.snapshot.value.toString();

      DatabaseReference age = ref.child('age');
      DatabaseEvent event2 = await age.once();
      patient_age.text = event2.snapshot.value.toString();

      DatabaseReference blood = ref.child('blood');
      DatabaseEvent event3 = await blood.once();
      // _selectedBloodGroup = event3.snapshot.value.toString();
      patient_blood.text = event3.snapshot.value.toString();

      DatabaseReference gender = ref.child('gender');
      DatabaseEvent event4 = await gender.once();
      // _selectedGender = event4.snapshot.value.toString();
      patient_gender.text = event4.snapshot.value.toString();

      DatabaseReference phone = ref.child('phone');
      DatabaseEvent event5 = await phone.once();
      patient_phone.text = event5.snapshot.value.toString();

      DatabaseReference address = ref.child('address');
      DatabaseEvent event6 = await address.once();
      patient_address.text = event6.snapshot.value.toString();

      // Future.delayed(Duration(seconds: 3),() => );
      // hide();
      // setState((){
      //   isLoading = false;
      // });
      // print(isLoading);
      // return;
      // HideProgressIndicator();
      // setState(() {
      //   isLoading = false;
      // });
      // Future.delayed(Duration(seconds: 3),() =>
      //   setState(() {
      //     isLoading = false;
      //   })
      // );
    }
    getData();
    // setState(() {
    //   isLoading = false;
    // });
  }

  removeData(){

    patient_name.text = "";

    patient_age.text = "";

    patient_phone.text = "";

    patient_address.text = "";

  }
}



class ShowProgressIndicator extends StatelessWidget {
  const ShowProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Opacity(
          opacity: 0.8,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}

class HideProgressIndicator extends StatelessWidget {
  const HideProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [

      ],
    );
  }
}


//-----------------------Date picker calendar ------------------------//
class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  /// Which holds the selected date
  /// Defaults to today's date.
  // DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.themeMode == ThemeMode.dark ? Colors.grey.shade50.withOpacity(0.5) : Colors.grey;

    return Expanded(
      child: InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            width: 50,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.calendar_month,
                    // color: Colors.black45,
                  ),
                ),
                Center(
                    child: Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_drop_down),
                )
              ],
            ),
          )),
    );
  }
}







//----------------------Custom Time Stamp------------------------//
Widget timeStamp(time,bool booked) {
  return Column(
    children: [
      Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            color:  booked ? Colors.grey : const Color(0xFF0527DB),
            borderRadius: BorderRadius.circular(9)
        ),
        child: Center(
          child: booked ? Text(
            time,
            style: const TextStyle(color: Colors.white,decoration: TextDecoration.lineThrough)
            ,
          ) : Text(
            time,
            style: const TextStyle(color: Colors.white),
          ) ,
        ),
      ),
      booked ? const Center(child: Text("Unavailable",style: TextStyle(color: Colors.red),textAlign: TextAlign.center,)) : const Text("")
    ],
  );
}








//----------------------- custom text-field without icon ---------------------//
// Widget textFieldWithoutIcon(String title,TextInputType type,bool address) {
//   return Container(
//     margin: const EdgeInsets.only(top: 15),
//     child: TextFormField(
//       textAlign: TextAlign.start,
//       cursorColor: Colors.grey,
//       keyboardType: type,
//       maxLines: address ? 4 : 1,
//       decoration: InputDecoration(
//           contentPadding: const EdgeInsets.all(15),
//           label: Text(title),
//           border: const OutlineInputBorder(),
//           labelStyle: const TextStyle(color: Colors.black45),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(
//                 width: 2,
//                 color: Colors.black45
//             ),
//           )
//       ),
//     ),
//   );
// }








Widget boldText(String text){
  return Text(
    text,
    style: const TextStyle(
      // color: Colors.black,
      fontWeight: FontWeight.bold
    ),
  );
}





