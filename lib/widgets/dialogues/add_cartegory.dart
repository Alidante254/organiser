import 'package:Organiser/widgets/form_items/buttons.dart';
import 'package:flutter/material.dart';

class AddCategoryDialog {
  static Future<String?> show(BuildContext context) async {
    TextEditingController categoryController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Add Category',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    hintText: 'Enter category',
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
                        String category = categoryController.text.trim();
                        if (category.isNotEmpty) {
                          Navigator.of(context).pop(category);
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
