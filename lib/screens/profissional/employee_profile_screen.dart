import 'package:event_uau/components/employee/profile_screen/profile_picture.dart';
import 'package:event_uau/components/employee/profile_screen/user_details.dart';
import 'package:flutter/material.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({Key key}) : super(key: key);

  static const routeName = '/employee/profile';

  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  final List<String> _imageList = [
    'https://upload.wikimedia.org/wikipedia/commons/7/7e/Borat_in_Cologne.jpg',
    'https://www.torredevigilancia.com/wp-content/uploads/2021/01/borat-2.png',
    'https://cdn.jornaldebrasilia.com.br/wp-content/uploads/2021/01/06152117/borat-subsequent-moviefilm-review-1200-1000x600.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 33,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(90),
            ),
            child: FittedBox(
              child: IconButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                ),
                iconSize: 100,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(90),
            ),
            child: IconButton(
              color: primaryColor,
              onPressed: () {},
              icon: Icon(
                Icons.edit,
              ),
              iconSize: 40,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ProfilePicture(imageList: _imageList),
          UserDetails(),
        ]),
      ),
    );
  }
}
