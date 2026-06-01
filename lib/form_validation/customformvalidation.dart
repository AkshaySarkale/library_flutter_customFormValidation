import 'package:flutter/material.dart';
import 'package:library_flutter_smart_text_input/smarttextinput/smart_text_input.dart';

class CustomFormWithValidation extends StatefulWidget {
  final String pageTitle;
  final String subTitle;

  final TextEditingController fullNametxtCtrl;
  final TextEditingController emailtxtCtrl;
  final TextEditingController phoneNumberCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController cnfPasswordCtrl;

  final VoidCallback? onSubmit;

  final bool showFullName;
  final bool showEmail;
  final bool showPhone;
  final bool showPassword;
  final bool showConfirmPassword;

  final bool isLoading;

  final String submitButtonText;

  final String fullNameLabel;
  final String emailLabel;
  final String phoneLabel;
  final String passwordLabel;
  final String confirmPasswordLabel;

  final double fieldSpacing;

  final bool showGender;
  final String genderLabel;
  final ValueChanged<String?>? onGenderChanged;

  const CustomFormWithValidation({
    super.key,
    required this.pageTitle,
    this.subTitle = "",

    required this.fullNametxtCtrl,
    required this.emailtxtCtrl,
    required this.phoneNumberCtrl,
    required this.passwordCtrl,
    required this.cnfPasswordCtrl,

    this.onSubmit,

    this.showFullName = true,
    this.showEmail = true,
    this.showPhone = true,
    this.showPassword = true,
    this.showConfirmPassword = true,

    this.isLoading = false,

    this.submitButtonText = "Submit",

    this.fullNameLabel = "Full Name",
    this.emailLabel = "Email Address",
    this.phoneLabel = "Phone Number",
    this.passwordLabel = "Password",
    this.confirmPasswordLabel = "Confirm Password",

    this.fieldSpacing = 12,

    this.showGender = true,
    this.genderLabel = "Gender",
    this.onGenderChanged,
  });

  @override
  State<CustomFormWithValidation> createState() =>
      _CustomFormWithValidationState();
}

class _CustomFormWithValidationState extends State<CustomFormWithValidation> {
  String? selectedGender;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.pageTitle, style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (widget.subTitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.subTitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              if (widget.showFullName) ...[
                Text(widget.fullNameLabel),
                const SizedBox(height: 6),

                SmartTextInput(txtCtrl: widget.fullNametxtCtrl,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Full Name is required";
                    }
                    return null;
                  },
                ),

                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showEmail) ...[
                Text(widget.emailLabel),
                const SizedBox(height: 6),

                SmartTextInput(
                  txtCtrl: widget.emailtxtCtrl,
                  isGmail: true,
                ),

                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showPhone) ...[
                Text(widget.phoneLabel),
                const SizedBox(height: 6),

                SmartTextInput(
                  txtCtrl: widget.phoneNumberCtrl,
                  isMobNumber: true,
                ),

                SizedBox(height: widget.fieldSpacing),
              ],
              if (widget.showGender) ...[
                Text(widget.genderLabel),

                const SizedBox(height: 6),

                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Male",
                      child: Text("Male"),
                    ),
                    DropdownMenuItem(
                      value: "Female",
                      child: Text("Female"),
                    ),
                    DropdownMenuItem(
                      value: "Other",
                      child: Text("Other"),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select gender";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });

                    widget.onGenderChanged?.call(value);
                  },
                ),

                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showPassword) ...[
                Text(widget.passwordLabel),
                const SizedBox(height: 6),

                SmartTextInput(
                  txtCtrl: widget.passwordCtrl,
                  isPassword: true,
                ),

                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showConfirmPassword) ...[
                Text(widget.confirmPasswordLabel),
                const SizedBox(height: 6),

                SmartTextInput(
                  txtCtrl: widget.cnfPasswordCtrl,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Confirm Password is required";
                    }

                    if (value != widget.passwordCtrl.text) {
                      return "Passwords do not match";
                    }

                    return null;
                  },
                ),

                SizedBox(height: widget.fieldSpacing),
              ],

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: widget.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ElevatedButton(
                  onPressed: validateAndSubmit,
                  child: Text(widget.submitButtonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}