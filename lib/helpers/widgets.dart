import 'package:flutter/material.dart';

import 'globals.dart' as globals;

class Button extends StatefulWidget {
  final String? text;
  final Function? onClick;
  const Button({Key? key, this.text, this.onClick}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          widget.onClick!();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          '${widget.text}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }
}

class OutlinedButton extends StatefulWidget {
  final String? text;
  final Function? onClick;
  const OutlinedButton({Key? key, this.text, this.onClick}) : super(key: key);

  @override
  _OutlinedButtonState createState() => _OutlinedButtonState();
}

class _OutlinedButtonState extends State<OutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          widget.onClick!();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
          primary: globals.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: globals.red),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        // style: ElevatedButton.styleFrom(
        //   padding: EdgeInsets.symmetric(vertical: 16),
        //   elevation: 0,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        // ),
        child: Text(
          '${widget.text}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: globals.red),
        ),
      ),
    );
  }
}

class Input extends StatefulWidget {
  final String? hintText;
  final Function? onChanged;
  final border;
  const Input({Key? key, this.hintText, this.onChanged, this.border}) : super(key: key);

  @override
  State<Input> createState() => InputState();
}

class InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: widget.border,
        focusedBorder: widget.border,
        enabledBorder: widget.border,
        hintText: widget.hintText,
      ),
    );
  }
}
