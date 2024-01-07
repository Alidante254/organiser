import 'package:Organiser/models/sub_collections/event_model.dart';
import 'package:Organiser/pages/add_items/add_event.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatefulWidget {
  @override
  _CustomFABState createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController fabAnimation;
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    fabAnimation = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fabAnimation,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMenuOpen)
              buildMenuItem(Icons.check_circle, () {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              }),
            if (isMenuOpen)
              buildMenuItem(Icons.schedule, () {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              }),
            if (isMenuOpen)
              buildMenuItem(Icons.stars_rounded, () {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              }),
            if (isMenuOpen)
              buildMenuItem(Icons.event, () {
               EventModel eventModel = new EventModel(); // Initialize your EventModel instance
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateEventPage(eventModel)),
                );

                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              }),
            if (isMenuOpen)
              buildMenuItem(Icons.restaurant, () {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              }),
            FloatingActionButton(
              child: Icon(isMenuOpen ? Icons.close : Icons.add),
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              foregroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
                fabAnimation.status == AnimationStatus.completed
                    ? fabAnimation.reverse()
                    : fabAnimation.forward();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildMenuItem(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: FloatingActionButton(
        mini: !isMenuOpen,
        onPressed: onPressed,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 25.0,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    fabAnimation.dispose();
    super.dispose();
  }
}
