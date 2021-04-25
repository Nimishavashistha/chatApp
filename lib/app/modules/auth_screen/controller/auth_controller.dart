import 'dart:io';
import 'dart:math';
import 'package:chat_app/app/routes/route_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final formkey = GlobalKey<FormState>();
  var userEmail = "";
  var userName = "";
  var password = "";
  var isLogin = true;
  final auth = FirebaseAuth.instance;
  var isLoading = false;
  Rxn<User> firebaseUser = Rxn<User>(); //observable variable for state changes
  File pickedImage;
  File userImageFile;

  User get user => firebaseUser
      .value; //it will check user null or not and get values from firebase user

  @override
  void onInit() {
    firebaseUser.bindStream(
        auth.authStateChanges()); //it will check user loggedIn or not
    //called immediately after the widget is allocated memory
    super.onInit();
  }

  Widget getImageFrom() {
    return Container(
      height: 150,
      width: MediaQuery.of(Get.context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconCreation(
                  Icons.camera_alt, Colors.pink, "Camera", pickImageFromCamera),
              SizedBox(
                width: 40,
              ),
              iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                  pickImageFromGallery),
            ],
          ),
        ),
      ),
    );
  }

  void pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(source: ImageSource.gallery);
    pickedImage = File(pickedImageFile.path);
    update();
    Get.back();
  }

  void pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(source: ImageSource.camera);
    pickedImage = File(pickedImageFile.path);
    update();
    Get.back();
  }

  void submit(BuildContext context) {
    final isValid = formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (userImageFile == null) {
      Get.snackbar('error', 'Please pick an image');
      return;
    }
    if (isValid) {
      formkey.currentState.save();
      submitAuthForm(
          userEmail.trim(), password.trim(), userName.trim(), isLogin, context);
    }
  }

  String emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.isEmpty || value.length < 7) {
      return "Password must be 7 characters long";
    } else {
      return null;
    }
  }

  String usernameValidation(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Please enter at least 4 characters';
    } else {
      return null;
    }
  }

  void switchLogin() {
    isLogin = !isLogin;
    update();
  }

  void submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext context) async {
    UserCredential authResult;
    try {
      isLoading = true;
      update();
      if (isLogin) {
        authResult = await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .whenComplete(() {
          RoutesManagement.goToChatScreen();
        });
      } else {
        authResult = await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .whenComplete(() {
          RoutesManagement.goToChatScreen();
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
        });
        isLoading = false;
        update();
      }
    } on PlatformException catch (err) {
      var message = "An error occurred, Please check your credentials!";
      if (err.message != null) {
        message = err.message;
      }
      Get.showSnackbar(GetBar(
        message: message,
        backgroundColor: Theme.of(context).errorColor,
      ));
      isLoading = false;
      update();
    } catch (err) {
      print(err);
      isLoading = false;
      update();
    }
  }

  Widget iconCreation(
      IconData icon, Color color, String text, Function takePictureFrom) {
    return InkWell(
      onTap: takePictureFrom,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  void pickedImageFile(File image) {
    userImageFile = image;
    update();
  }
}
