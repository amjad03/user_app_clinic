import 'package:flutter/material.dart';

import '../../controller/feedback_controller/feedback_controller.dart';
import '../../src/widgets/text_input_field.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {

  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final feedback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: name,
                    textAlign: TextAlign.start,
                    // cursorColor: Colors.grey,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        label: Text("Enter Your Name"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                          ),
                        )
                    ),
                    validator: (value) {
                      if(value.toString().isEmpty){
                        return "Required";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: email,
                    textAlign: TextAlign.start,
                    // cursorColor: Colors.grey,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        label: Text("Enter Your Email"),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        )
                    ),
                    validator: (value) {
                      if(value.toString().isEmpty){
                        return "Required";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: feedback,
                    minLines: 1,
                    maxLines: 10,
                    textAlign: TextAlign.start,
                    // cursorColor: Colors.grey,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        label: Text("Enter Your Feedback"),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        // hintText: "Enter Your Feedback",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        )
                    ),
                    validator: (value) {
                      if(value.toString().isEmpty){
                        return "Required";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                ),
                // CustomTextField(title: "Enter Your Name", icon: Icons.person, type: TextInputType.text, password: false, address: false),
                // CustomTextField(title: "Enter Your Email", icon: Icons.email, type: TextInputType.text, password: false, address: false),
                // CustomTextField(title: "Enter Your Feed back", icon: Icons.feedback, type: TextInputType.text, password: false, address: true),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color(0xFF0527DB),
                    )
                  ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        FeedbackController.instance.sendFeedback(name.text, email.text, feedback.text, context);
                      }

                    },
                    child: const Text("Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
