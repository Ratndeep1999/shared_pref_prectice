import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Widgets/filled_button_widget.dart';
import 'package:shared_pref_prectice/Widgets/label_text_widget.dart';
import 'package:shared_pref_prectice/core/app/app_routes.dart';
import 'package:shared_pref_prectice/core/constants/app_strings.dart';
import 'package:shared_pref_prectice/data/local/shared_pref_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

SharedPrefService prefService = SharedPrefService();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LabelTextWidget(
          label: AppStrings.homeTitle,
          fontColor: Colors.black,
        ),
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
                        const SizedBox(height: 20.0),
                        LabelTextWidget(label: SharedPrefService.kUserName),
                        LabelTextWidget(label: SharedPrefService.kFullName),
                        LabelTextWidget(label: SharedPrefService.kEmailId),
                        LabelTextWidget(label: SharedPrefService.kPassword),
                        LabelTextWidget(label: SharedPrefService.kPhoneNo),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),

                /// Logout Button
                Center(
                  child: FilledButtonWidget(
                    buttonLabel: AppStrings.logout,
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
    prefService.clearAll();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }
}
