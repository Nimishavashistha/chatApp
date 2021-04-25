import 'package:chat_app/app/modules/auth_screen/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class UserImagePicker extends StatelessWidget {
  final void Function(File pickedImage) imagePickFn;

  const UserImagePicker({Key key, this.imagePickFn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (controller) => Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: controller.pickedImage != null
                      ? FileImage(controller.pickedImage)
                      : null,
                ),
                TextButton.icon(
                    icon: Icon(
                      Icons.image,
                    ),
                    onPressed: () {
//                      showModalBottomSheet(
//                          backgroundColor: Colors.transparent,
//                          context: context,
//                          builder: (builder) => controller.getImageFrom());
                      Get.bottomSheet(controller.getImageFrom(),
                          backgroundColor: Colors.transparent);
                    },
                    label: Text('Add Image'),
                    style: TextButton.styleFrom(
                        textStyle:
                            TextStyle(color: Theme.of(context).primaryColor)))
              ],
            ));
  }
}
