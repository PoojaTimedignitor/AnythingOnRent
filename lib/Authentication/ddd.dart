// register_phone.dart
import 'package:flutter/material.dart';

import 'common.dart';

class RegisterPhone extends StatelessWidget {
  final VoidCallback onPhoneRegister;

  const RegisterPhone({Key? key, required this.onPhoneRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      title: "Register Phone",
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPhoneRegister,
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
