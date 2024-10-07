import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourease/user/user_data.dart';
import 'package:tourease/widget/appbar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  var user = UserData.myUser;
  bool isLoading = false;

  Future<void> _updateImage() async {
    setState(() {
      isLoading = true; // Set isLoading to true while loading the image
    });

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      setState(() {
        isLoading = false; // Set isLoading to false after loading is complete
      });
      return;
    }

    final newImage = File(image.path);

    String imagePath =
        'user_images/${user.name}/${DateTime.now().millisecondsSinceEpoch}';
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(imagePath)
          .putFile(newImage);
    } catch (e) {
      print('Error uploading image: $e');
      setState(() {
        isLoading = false; // Set isLoading to false after loading is complete
      });
      return;
    }

    String downloadURL;
    try {
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(imagePath)
          .getDownloadURL();
    } catch (e) {
      print('Error getting download URL: $e');
      setState(() {
        isLoading = false; // Set isLoading to false after loading is complete
      });
      return;
    }

    setState(() {
      user.image = downloadURL;
      isLoading = false; // Set isLoading to false after loading is complete
    });

    UserData.updateUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 330,
              child: const Text(
                "Upload a photo of yourself:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 330,
                child: GestureDetector(
                  onTap: _updateImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      user.image.isNotEmpty
                          ? user.image.startsWith('http')
                              ? Image.network(
                                  user.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  File(user.image).path,
                                  fit: BoxFit.cover,
                                )
                          : Placeholder(
                              fallbackHeight: 200,
                            ),
                      if (isLoading)
                        CircularProgressIndicator(), // Show CircularProgressIndicator while loading
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      UserData.updateUser(user);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
