import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Pages/login_page.dart';
import 'package:shared_pref_prectice/Widgets/filled_button_widget.dart';
import 'package:shared_pref_prectice/Widgets/label_text_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LabelTextWidget(label: "Home Page", fontColor: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Card to Show Saved Data
                Card(
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Saved Data
                        LabelTextWidget(label: "Profile :"),
                        const SizedBox(height: 20.0,),
                        LabelTextWidget(label: "ratndeep"),
                        LabelTextWidget(label: "Ratndeep Chandankhede", ),
                        LabelTextWidget(label: "ratndeepChandankhede@gmail.com"),
                        LabelTextWidget(label: "ratndeep@121"),
                        LabelTextWidget(label: "+91 8558830830"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                /// Logout Button
                Center(
                  child: FilledButtonWidget(
                    buttonLabel: "Logout",
                    onPress: () => _navigateToLoginPage(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Method to Navigate LoginPage()
  _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
