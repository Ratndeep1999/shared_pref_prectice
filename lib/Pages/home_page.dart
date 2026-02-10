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

class _HomePageState extends State<HomePage> {
  SharedPrefService prefService = SharedPrefService();
  bool _isLoading = true;
  String? _userName;
  String? _fullName;
  String? _emailId;
  String? _password;
  String? _phoneNumber;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

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
                _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.purple,
                        strokeWidth: 8,
                        strokeAlign: 20,
                        padding: EdgeInsets.symmetric(vertical: 200.0),
                      )
                    : Card(
                        elevation: 5.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 50.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Saved Data
                              LabelTextWidget(label: "Profile :"),
                              const SizedBox(height: 20.0),
                              LabelTextWidget(label: _userName ?? ""),
                              LabelTextWidget(label: _fullName ?? ""),
                              LabelTextWidget(label: _emailId ?? ""),
                              LabelTextWidget(label: _password ?? ""),
                              LabelTextWidget(label: _phoneNumber ?? ""),
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

  Future<void> initializeData() async {
    _userName = await prefService.getPrefString(
      key: SharedPrefService.kUserName,
    );
    _fullName = await prefService.getPrefString(
      key: SharedPrefService.kFullName,
    );
    _emailId = await prefService.getPrefString(key: SharedPrefService.kEmailId);
    _password = await prefService.getPrefString(
      key: SharedPrefService.kPassword,
    );
    _phoneNumber = await prefService.getPrefString(
      key: SharedPrefService.kPhoneNo,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);
  }
}
