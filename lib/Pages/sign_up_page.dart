import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Widgets/text_form_field_widget.dart';
import '../Widgets/label_text_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  /// Controllers
  late final TextEditingController fullNameController;

  /// Parameters

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fullNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: LabelTextWidget(label: "SignUp Page"),
      centerTitle: true,
      backgroundColor: Colors.purple,
    ),
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: AutofillGroup(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Full Name Section
                  LabelTextWidget(label: "Enter Full Name", fontSize: 15),
                  TextFormFieldWidget(
                    controller: fullNameController,
                    hintText: "Enter Your Full Name",
                  ),

                  /// Email Section

                  /// User name Section

                  /// Password Section

                  /// Conform Password Section

                  /// Mobile No. Section
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
