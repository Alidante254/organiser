import 'package:Organiser/widgets/form_items/buttons.dart';
import 'package:flutter/material.dart';

class AddTagDialog {
  static Future<String?> show(BuildContext context) async {
    TextEditingController tagController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Add Tag',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: tagController,
                  decoration: InputDecoration(
                    hintText: 'Enter tag',
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StyledButtons.secondaryOutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icons.cancel_outlined,
                      context: context,
                      text: 'Cancel',
                    ),
                    Text('|'),
                    StyledButtons.primaryElevatedButton(
                      onPressed: () {
                        String tag = tagController.text.trim();
                        if (tag.isNotEmpty) {
                          Navigator.of(context).pop(tag);
                        }
                      },
                      text: 'Done',
                      icon: Icons.check,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
