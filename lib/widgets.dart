import 'package:flutter/material.dart';

import './globals.dart' as globals;
//ignore: must_be_immutable
class Button extends StatefulWidget {
  String? text;
  Function? onClick;
  Button({Key? key, this.text, this.onClick}) : super(key: key);

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

//ignore: must_be_immutable
class OutlinedButton extends StatefulWidget {
  String? text;
  Function? onClick;
  OutlinedButton({Key? key, this.text, this.onClick}) : super(key: key);

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
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17, color: globals.red),
        ),
      ),
    );
  }
}

