import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/text_strings.dart';

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var otp;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tOtpTitle,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 60.0),
            ),
            Text(
              tOtpSubTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 40.0),
            const Text(
              "$tOtpMessage support@akkypatel990@gmail.com",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) {
                otp = code;
                FirebaseAuth.instance.verifyPasswordResetCode(code);
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.verifyPasswordResetCode(otp);
                },
                child: const Text(tNext),
              ),
            )
          ],
        ),
      ),
    );
  }
}
