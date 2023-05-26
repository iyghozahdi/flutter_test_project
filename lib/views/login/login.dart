import 'package:flutter/material.dart';
import 'package:flutter_test_project/provider/auth_provider.dart';
import 'package:flutter_test_project/views/home/home.dart';
import 'package:flutter_test_project/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Declare Controller ETC
  final formKey = GlobalKey<FormState>();
  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();

  /// Local Variable
  bool _obscureText = true;
  bool _isLoading = false;

  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text('Wrong Password'),
  );

  void doLogin() async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(
        Duration(seconds: 1),
      );

      if (controllerPassword.text == AuthProvider.instance.getPassword) {
        if (context.mounted) {
          AuthProvider.instance.setLoginData(token: "token");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[400]!,
              Colors.deepPurple[400]!,
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900]),
                              ),
                              Text(
                                'WELCOME TO FLUTTER MOBILE APPS',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blue[900]),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomTextField(
                                controller: controllerLogin,
                                labelText: "Username",
                                isDense: true,
                                prefixIcon: Icon(Icons.person),
                                errorValidation: "Username cannot be empty",
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomTextField(
                                controller: controllerPassword,
                                labelText: "Password",
                                isDense: true,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: _obscureText
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),
                                obscureText: _obscureText,
                                errorValidation: "Password cannot be empty",
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              _isLoading
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        backgroundColor: Colors.blue[900],
                                      ),
                                      onPressed: doLogin,
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        backgroundColor: Colors.blue[900],
                                      ),
                                      onPressed: doLogin,
                                      child: Text(
                                        "Login",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
