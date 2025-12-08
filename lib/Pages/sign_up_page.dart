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
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confPasswordController;
  late final TextEditingController _mobileNoController;

  /// Parameters

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
    _mobileNoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    _mobileNoController.dispose();
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
                    controller: _fullNameController,
                    hintText: "Enter Your Full Name",
                  ),
                  const SizedBox(height: 20),

                  /// Email Section
                  LabelTextWidget(label: "Enter Email Address", fontSize: 15),
                  TextFormFieldWidget(
                    controller: _emailController,
                    hintText: "Enter Your Email Address",
                  ),
                  const SizedBox(height: 20),

                  /// User name Section
                  LabelTextWidget(label: "Enter User Name", fontSize: 15),
                  TextFormFieldWidget(
                    controller: _userNameController,
                    hintText: "Enter Your User Name",
                  ),
                  const SizedBox(height: 20),

                  /// Password Section
                  LabelTextWidget(label: "Enter Password", fontSize: 15),
                  TextFormFieldWidget(
                    controller: _passwordController,
                    hintText: "Enter Your Password",
                  ),
                  const SizedBox(height: 20),

                  /// Conform Password Section
                  LabelTextWidget(
                    label: "Enter Conform Password",
                    fontSize: 15,
                  ),
                  TextFormFieldWidget(
                    controller: _confPasswordController,
                    hintText: "Enter Your Conform Password",
                  ),
                  const SizedBox(height: 20),

                  /// Mobile No. Section
                  const SizedBox(height: 20),


                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
