import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        margin: EdgeInsets.zero,
        child: Center(
          child: Stack(
            children: [
              Image.network(
                'https://picsum.photos/200/300',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
               
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(height: 15),
                    Icon(
                        Icons.location_on,
                        size: 50,
                      ),
                     
                    SizedBox(height: 15),
                    Text(
                      'Select Location',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}
