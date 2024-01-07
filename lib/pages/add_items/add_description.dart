import 'package:Organiser/widgets/form_items/buttons.dart';
import 'package:flutter/material.dart';

class DescriptionEditorPage extends StatefulWidget {
  @override
  _DescriptionEditorPageState createState() => _DescriptionEditorPageState();
}

class _DescriptionEditorPageState extends State<DescriptionEditorPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Description'),
        actions: [
          IconButton(
            icon: Icon(Icons.format_size),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.format_bold),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.format_underline),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          expands: true,
          maxLines: null,
          style: TextStyle(fontSize: 16.0),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your event's description here",
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyledButtons.primaryElevatedButton(
                onPressed: () {},
                text: 'Clear',
                icon: Icons.cancel,
              ),
              StyledButtons.primaryElevatedButton(
                onPressed: () {},
                text: 'Save',
                icon: Icons.check,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
