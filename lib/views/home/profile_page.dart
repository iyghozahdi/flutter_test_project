import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/provider/auth_provider.dart';
import 'package:flutter_test_project/views/login/login.dart';
import 'package:flutter_test_project/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  final controllerChangePassword = TextEditingController();

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 320,
                        height: 320,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://i.pinimg.com/564x/03/2f/e5/032fe5fb270060c6fe19493d835a8567--clipart-black-and-white-minion.jpg'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue[900],
                ),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Text(
                  "Change Picture Gallery",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue[900],
                ),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: Text(
                  "Change Picture Camera",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                obscureText: true,
                controller: controllerChangePassword,
                labelText: "Change Password",
                isDense: true,
                errorValidation: "Username cannot be empty",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue[900],
                ),
                onPressed: () {
                  AuthProvider.instance
                      .changePassword(password: controllerChangePassword.text);
                  AuthProvider.instance.logOut();
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }
                },
                child: Text(
                  "Change Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blue[900],
                ),
                onPressed: () {
                  AuthProvider.instance.logOut();
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
