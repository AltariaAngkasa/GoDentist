import 'package:flutter/material.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';

class TxtFormField extends StatefulWidget {
  final String label;
  final Color color;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool showPasswordToggle; // Parameter baru

  const TxtFormField({
    required this.label,
    required this.color,
    required this.obscureText,
    required this.keyboardType,
    required this.controller,
    this.validator,
    this.showPasswordToggle = false, // Set default value
    super.key,
  });

  @override
  State<TxtFormField> createState() => _TxtFormFieldState();
}

class _TxtFormFieldState extends State<TxtFormField> {
  late FocusNode _focusNode;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _isObscure = widget.obscureText; // Set initial value
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _toggleObscureText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: _isObscure,
      cursorColor: ColorConstant.primaryColor,
      keyboardType: widget.keyboardType,
      focusNode: _focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: _focusNode.hasFocus ? ColorConstant.primaryColor : Colors.grey,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffixIcon: widget.showPasswordToggle
            ? _buildSuffixIcon()
            : null, // Tampilkan sufix icon jika parameter showPasswordToggle true
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return IconButton(
      icon: _isObscure ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
      onPressed: _toggleObscureText,
    );
  }
}
