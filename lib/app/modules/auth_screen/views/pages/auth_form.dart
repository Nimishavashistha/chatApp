import 'package:chat_app/app/modules/auth_screen/controller/auth_controller.dart';
import 'package:chat_app/app/modules/auth_screen/views/pages/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: GetBuilder<AuthController>(
              builder: (controller) => Form(
                key: controller.formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserImagePicker(),
                    TextFormField(
                      key: ValueKey("email"),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email address"),
                      validator: (value) {
                        return controller.emailValidator(value);
                      },
                      onSaved: (value) {
                        controller.userEmail = value;
                      },
                    ),
                    if (!controller.isLogin)
                      TextFormField(
                        key: ValueKey("username"),
                        decoration: InputDecoration(labelText: "Username"),
                        validator: (value) {
                          return controller.usernameValidation(value);
                        },
                        onSaved: (value) {
                          controller.userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey("password"),
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password"),
                      validator: (value) {
                        return controller.passwordValidator(value);
                      },
                      onSaved: (value) {
                        controller.password = value;
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    if (controller.isLoading) CircularProgressIndicator(),
                    if (!controller.isLoading)
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 90, height: 37),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.submit(context);
                          },
                          child: Text(controller.isLogin ? 'Login' : 'Signup'),
                        ),
                      ),
                    if (!controller.isLoading)
                      TextButton(
                        onPressed: () {
                          controller.switchLogin();
                        },
                        child: Text(controller.isLogin
                            ? "Create new account"
                            : "I already have an account"),
                        style: TextButton.styleFrom(
                            textStyle: TextStyle(
                                color: Theme.of(context).primaryColor)),
                      )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
