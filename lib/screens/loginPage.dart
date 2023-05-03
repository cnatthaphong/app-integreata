// import 'package:basicflutter/screens/list-project.dart';
import 'package:flutter/material.dart';
import '../ProgressHUD.dart';
import '../service/api-service.dart';
import '../model/login-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool hidePassword = true;
  bool isApiCallProcess = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel = LoginRequestModel();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<Null> checkLogin() async {
    try {
      final SharedPreferences prefs = await _prefs;
      int memberId = prefs.getInt('memberId') ?? -1;
      if (memberId != -1) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    } catch (e) {}
    setState(() {
      isApiCallProcess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(inAsyncCall: isApiCallProcess, child: _uiSetup(context));
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: <Widget>[
                      // Image.asset("images/logo-main.png"),
                      SizedBox(height: 25),
                      
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? input) {
                          loginRequestModel.setEmail(input!);
                        },
                        validator: (input) => !input!.contains('@')
                            ? "Email Id should be valid"
                            : null,
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.2))),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        // style: const TextStyle(color: Colors.red),
                        keyboardType: TextInputType.text,
                        onSaved: (String? input) =>
                            loginRequestModel.setPassword(input!),
                        validator: (input) => input!.length < 3
                            ? "Password should be more than 3 characters"
                            : null,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).accentColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            APIService apiService = APIService();
                            apiService.login(loginRequestModel).then((value) {
                              if (value != null) {
                                setMemberId(value.memberId);
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                if (value.canLogin) {
                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             ListProject(isFirst: true)),
                                  //     (route) => false);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/', (route) => false);
                                } else {
                                  final snackBar =
                                      SnackBar(content: Text(value.error));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            });
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setMemberId(int IntMemberId) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt('memberId', IntMemberId);
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
