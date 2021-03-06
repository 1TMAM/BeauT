import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Function value;
  final Function validate;
  final Function onTab;
  final Function onSubmitted;
  final Widget icon;
  final Widget suffix;
  final double width;
  final double height;
  final TextInputType inputType;
  final String label;
  final String hint;
  final int lines;
  final bool secureText;
  final double raduis;
  final String initialText;

  const CustomTextField({
    Key key,
    this.value,
    this.validate,
    this.icon,
    this.width,
    this.height,
    this.inputType,
    this.label,
    this.hint,
    this.lines,
    this.secureText,
    this.raduis,
    this.initialText,
    this.onTab,
    this.onSubmitted,
    this.suffix,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
          // controller: widget.controller,
          onFieldSubmitted: widget.onSubmitted,
          onTap:widget. onTab,
          maxLines:widget. lines ?? 1,
          style: TextStyle(
              color: Colors.black, fontSize: 16.0),
          obscureText: widget.secureText ?? false,
          cursorColor: Colors.black,
          keyboardType: widget.inputType ?? TextInputType.multiline,
          validator:widget. validate,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.raduis ?? 10),
                borderSide: BorderSide(
                  color:  Theme.of(context).primaryColor,
                ),
              ),
              errorStyle: TextStyle(fontSize: 10.0),
              contentPadding: EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(widget.raduis ?? 10.0),
                borderSide: new BorderSide(color: Theme.of(context).primaryColor , width: 1),
              ),
              filled: true,
              fillColor: Colors.white,
              labelText: widget.label,
              prefixIcon: widget.icon??null,
              // errorText: widget.errorTxt,
              errorBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(widget.raduis ?? 10.0),
                borderSide: new BorderSide(color: Colors.red , width: 1),
              ),
              labelStyle: TextStyle(fontSize: 16 ,color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w400),
              hintStyle: TextStyle(fontSize: 14 , fontWeight: FontWeight.w400 ,color: Colors.grey ),
              hintText: widget.hint),
          onChanged: widget.value),
    );
  }
}
