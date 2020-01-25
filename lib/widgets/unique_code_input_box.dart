import 'package:flutter/material.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/widgets/text_tag.dart';

typedef void CodeDetectedCallback(List<String> codes);

/// A widget that allows to enter unique codes,
/// and keeps track of all valid entered codes.
class UniqueCodeInputBox extends StatefulWidget {
  /// Callback to fire when the inputted text is detected
  /// as a valid unique code.
  /// Receives as argument a list of all detected unique codes.
  final CodeDetectedCallback onUniqueCodeDetected;

  UniqueCodeInputBox({@required this.onUniqueCodeDetected});

  @override
  _UniqueCodeInputBoxState createState() => _UniqueCodeInputBoxState();
}

class _UniqueCodeInputBoxState extends State<UniqueCodeInputBox> {
  List<String> codes;

  @override
  void initState() {
    codes = [];

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
            onChanged: (text) {
              var potentialCode = text.trim();
              if (Util.isValidUniqueCode(potentialCode)) {
                this.setState(() {
                  this.codes.add(potentialCode);
                  controller.clear();
                  this.widget.onUniqueCodeDetected(this.codes);
                });
              }
            },
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: codes
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
}
