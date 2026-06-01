import 'package:flutter/material.dart';
import 'package:library_flutter_smart_text_input/smarttextinput/smart_text_input.dart';

class Customformwithvalidation extends StatefulWidget {
  final String pageTitle;
  final String subTitle;
  final TextEditingController fullNametxtCtrl;
  final TextEditingController emailtxtCtrl;
  final TextEditingController phoneNumberCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController cnfPasswordCtrl;



  const Customformwithvalidation({
    super.key,
    required this.pageTitle,
    this.subTitle = "",
    required this.fullNametxtCtrl,
    required this.emailtxtCtrl,
    required this.phoneNumberCtrl,
    required this.passwordCtrl,
    required this.cnfPasswordCtrl,
  });

  @override
  State<Customformwithvalidation> createState() => _CustomformwithvalidationState();
}

class _CustomformwithvalidationState extends State<Customformwithvalidation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.pageTitle),
          Text(widget.subTitle),
          Text("Full Name"),
          SmartTextInput(txtCtrl: widget.fullNametxtCtrl),
          Text("Email Address"),
          SmartTextInput(txtCtrl: widget.fullNametxtCtrl,isGmail: true,),
          Text("Phone Number"),
          SmartTextInput(txtCtrl: widget.phoneNumberCtrl,isMobNumber: true),
          Text("Password"),
          SmartTextInput(txtCtrl: widget.passwordCtrl,isPassword: true,),
          Text("Confirm Password"),
          SmartTextInput(txtCtrl: widget.cnfPasswordCtrl,isPassword: true,),

        ],
      ),
    );
  }
}
