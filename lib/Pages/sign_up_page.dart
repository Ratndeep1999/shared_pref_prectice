import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Pages/home_page.dart';
import 'package:shared_pref_prectice/Widgets/filled_button_widget.dart';
import 'package:shared_pref_prectice/Widgets/text_form_field_widget.dart';
import '../Widgets/label_text_widget.dart';
import '../Widgets/phone_number_field-widget..dart';

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

  /// Focus Nodes
  late final FocusNode _fullNameNode;
  late final FocusNode _emailNode;
  late final FocusNode _usernameNode;
  late final FocusNode _passwordNode;
  late final FocusNode _confPasswordNode;
  late final FocusNode _mobileNoNode;

  /// Parameters
  final _fullName = '';
  final _email = '';
  final _userName = '';
  final _password = '';
  final _confPassword = '';
  final _mobileNo = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
    _mobileNoController = TextEditingController();
    _fullNameNode = FocusNode();
    _emailNode = FocusNode();
    _usernameNode = FocusNode();
    _passwordNode = FocusNode();
    _confPasswordNode = FocusNode();
    _mobileNoNode = FocusNode();
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
    _fullNameNode.dispose();
    _emailNode.dispose();
    _usernameNode.dispose();
    _passwordNode.dispose();
    _confPasswordNode.dispose();
    _mobileNoNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: LabelTextWidget(label: "SignUp Page", fontColor: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
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
                      LabelTextWidget(
                          label: "Enter Email Address", fontSize: 15),
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
                      LabelTextWidget(
                        label: "Enter Phone Number",
                        fontSize: 15,
                      ),
                      PhoneNumberFieldWidget(),
                      const SizedBox(height: 20),

                      /// Button
                      Center(
                        child: FilledButtonWidget(
                          buttonLabel: "Create Account",
                          onPress: () => _navigateToHomePage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  /// Method to navigate HomePage
  _navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}


