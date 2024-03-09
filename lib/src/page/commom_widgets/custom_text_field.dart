import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.inputFormatter,
    this.initialValue,
    this.isSecret = false,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.onSaved,
    this.textInput,
    this.keyFormField,
  });

  final String label;
  final String? initialValue;
  final IconData icon;
  final bool isSecret;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final GlobalKey<FormFieldState>? keyFormField;
  final Function(String?)? onSaved;
  final TextInputType? textInput;

  final List<TextInputFormatter>? inputFormatter;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();

    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        readOnly: widget.readOnly,
        validator: widget.validator,
        controller: widget.controller,
        key: widget.keyFormField,
        onSaved: widget.onSaved,
        inputFormatters: widget.inputFormatter,
        initialValue: widget.initialValue,
        obscureText: isObscure,
        keyboardType: widget.textInput,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, size: 20),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: isObscure
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null,
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
