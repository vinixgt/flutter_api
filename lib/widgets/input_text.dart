import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool borderEnable;
  final double fontSize;
  final void Function(String text) onChanged;
  final void Function(String text) validator;


  const InputText({
    Key key, 
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnable=true,
    this.fontSize = 15,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType,
      obscureText: this.obscureText,
      onChanged: this.onChanged,
      validator: this.validator,
      style: TextStyle(fontSize: this.fontSize),
      decoration: InputDecoration(
        labelText: this.label,
        enabledBorder: this.borderEnable ? 
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)) : 
          InputBorder.none,
        labelStyle: TextStyle(
          color: Colors.black26,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}