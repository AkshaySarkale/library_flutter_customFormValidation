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

  final TextEditingController? addressCtrl;
  final TextEditingController? dobCtrl;

  final VoidCallback? onSubmit;
  final Function(Map<String, dynamic>)? onFormData;

  final bool showFullName;
  final bool showEmail;
  final bool showPhone;
  final bool showPassword;
  final bool showConfirmPassword;
  final bool showGender;
  final bool showAddress;
  final bool showDob;
  final bool showTermsAndConditions;

  final bool isLoading;

  final String submitButtonText;

  final String fullNameLabel;
  final String emailLabel;
  final String phoneLabel;
  final String passwordLabel;
  final String confirmPasswordLabel;
  final String genderLabel;
  final String addressLabel;
  final String dobLabel;

  final double fieldSpacing;

  final ValueChanged<String?>? onGenderChanged;
  final List<String> genderOptions;
  final String? initialGender;

  final Color? buttonColor;
  final Color? buttonTextColor;

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? labelStyle;

  const CustomFormWithValidation({
    super.key,
    required this.pageTitle,
    this.subTitle = "",
    required this.fullNametxtCtrl,
    required this.emailtxtCtrl,
    required this.phoneNumberCtrl,
    required this.passwordCtrl,
    required this.cnfPasswordCtrl,
    this.addressCtrl,
    this.dobCtrl,
    this.onSubmit,
    this.onFormData,
    this.showFullName = true,
    this.showEmail = true,
    this.showPhone = true,
    this.showPassword = true,
    this.showConfirmPassword = true,
    this.showGender = true,
    this.showAddress = false,
    this.showDob = false,
    this.showTermsAndConditions = false,
    this.isLoading = false,
    this.submitButtonText = "Submit",
    this.fullNameLabel = "Full Name",
    this.emailLabel = "Email Address",
    this.phoneLabel = "Phone Number",
    this.passwordLabel = "Password",
    this.confirmPasswordLabel = "Confirm Password",
    this.genderLabel = "Gender",
    this.addressLabel = "Address",
    this.dobLabel = "Date Of Birth",
    this.fieldSpacing = 12,
    this.onGenderChanged,
    this.genderOptions = const ["Male", "Female", "Other"],
    this.initialGender,
    this.buttonColor,
    this.buttonTextColor,
    this.titleStyle,
    this.subtitleStyle,
    this.labelStyle,
  });

  @override
  State<CustomFormWithValidation> createState() =>
      _CustomFormWithValidationState();
}

class _CustomFormWithValidationState
    extends State<CustomFormWithValidation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedGender;
  bool acceptTerms = false;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialGender;
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && widget.dobCtrl != null) {
      widget.dobCtrl!.text =
      "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  void validateAndSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (widget.showTermsAndConditions && !acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please accept Terms & Conditions"),
        ),
      );
      return;
    }

    widget.onFormData?.call({
      "fullName": widget.fullNametxtCtrl.text,
      "email": widget.emailtxtCtrl.text,
      "phone": widget.phoneNumberCtrl.text,
      "gender": selectedGender,
      "address": widget.addressCtrl?.text,
      "dob": widget.dobCtrl?.text,
    });

    widget.onSubmit?.call();
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
              Text(
                widget.pageTitle,
                style: widget.titleStyle ??
                    const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (widget.subTitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.subTitle,
                    style: widget.subtitleStyle ??
                        const TextStyle(color: Colors.grey),
                  ),
                ),
              const SizedBox(height: 20),

              if (widget.showFullName) ...[
                Text(widget.fullNameLabel, style: widget.labelStyle),
                const SizedBox(height: 6),
                SmartTextInput(
                  txtCtrl: widget.fullNametxtCtrl,
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
                Text(widget.emailLabel, style: widget.labelStyle),
                const SizedBox(height: 6),
                SmartTextInput(
                  txtCtrl: widget.emailtxtCtrl,
                  isGmail: true,
                ),
                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showPhone) ...[
                Text(widget.phoneLabel, style: widget.labelStyle),
                const SizedBox(height: 6),
                SmartTextInput(
                  txtCtrl: widget.phoneNumberCtrl,
                  isMobNumber: true,
                ),
                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showGender) ...[
                Text(widget.genderLabel, style: widget.labelStyle),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: widget.genderOptions.map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select gender";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() => selectedGender = value);
                    widget.onGenderChanged?.call(value);
                  },
                ),
                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showAddress) ...[
                Text(widget.addressLabel, style: widget.labelStyle),
                const SizedBox(height: 6),
                SmartTextInput(
                  txtCtrl: widget.addressCtrl!,
                ),
                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showDob) ...[
                Text(widget.dobLabel, style: widget.labelStyle),
                const SizedBox(height: 6),
                TextFormField(
                  controller: widget.dobCtrl,
                  readOnly: true,
                  onTap: pickDate,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select date of birth";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showPassword) ...[
                Text(widget.passwordLabel, style: widget.labelStyle),
                const SizedBox(height: 6),
                SmartTextInput(
                  txtCtrl: widget.passwordCtrl,
                  isPassword: true,
                ),
                SizedBox(height: widget.fieldSpacing),
              ],

              if (widget.showConfirmPassword) ...[
                Text(widget.confirmPasswordLabel, style: widget.labelStyle),
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

              if (widget.showTermsAndConditions)
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: acceptTerms,
                  title: const Text("I accept Terms & Conditions"),
                  onChanged: (value) {
                    setState(() {
                      acceptTerms = value ?? false;
                    });
                  },
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: widget.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.buttonColor,
                  ),
                  onPressed: validateAndSubmit,
                  child: Text(
                    widget.submitButtonText,
                    style: TextStyle(
                      color: widget.buttonTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
