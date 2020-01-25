import 'package:flutter/material.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/models/unique_code_meta.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/widgets/text_tag.dart';

typedef void CodeDetectedCallback(Map<String, UniqueCodeMeta> codes);

/// A widget that allows to enter unique codes,
/// and keeps track of all valid entered codes.
class UniqueCodeInputBox extends StatefulWidget {
  /// Callback to fire when the inputted text is detected
  /// as a valid unique code.
  /// Receives as argument a map of all detected unique codes
  /// and their metadata.
  final CodeDetectedCallback onUniqueCodeDetected;

  UniqueCodeInputBox({@required this.onUniqueCodeDetected});

  @override
  _UniqueCodeInputBoxState createState() => _UniqueCodeInputBoxState();
}

class _UniqueCodeInputBoxState extends State<UniqueCodeInputBox> {
  Map<String, UniqueCodeMeta> codes;

  @override
  void initState() {
    codes = {};

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = new TextEditingController();

    return Column(
      children: <Widget>[
        Container(
          height: 40.0,
          child: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter a 6-digit unique code',
              hintStyle: TextStyle(color: Colors.brown),
              contentPadding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 15.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.yellow[800],
            ),
            onChanged: (text) async {
              var potentialCode = text.trim();
              if (Util.isValidUniqueCode(potentialCode)) {
                var meta =
                    await FirebaseService.getUniqueCodeMeta(potentialCode);

                if (meta == null) {
                  return this._showDialog(context, 'Error',
                      'There was an error in validating unique code');
                } else if (Util.isEmptyOrNull(meta.orderPath)) {
                  return this._showDialog(context, 'Invalid Unique Code',
                      'The unique code $potentialCode has not been attached with an order yet.');
                }

                this.setState(() {
                  this.codes[potentialCode] = meta;
                  controller.clear();
                  this.widget.onUniqueCodeDetected(this.codes);
                });
              }
            },
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: codes.keys
              .map((code) => TextTag(
                    text: code,
                    onCancelPressed: () {
                      this.setState(() => this.codes.remove(code));
                    },
                  ))
              .toList(),
        )
      ],
    );
  }

  Future<void> _showDialog(BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
