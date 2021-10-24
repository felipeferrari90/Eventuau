import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/employee/profile_screen/profile_picture.dart';
import '../components/employee/profile_screen/user_details.dart';
import '../service/upload_service.dart' as UploadService;
import '../../../providers/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  static const routeName = '/employee/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {  
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Auth>(context).user;
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
        child: Column(
          children: [
            ProfilePicture(
                imageList: userData.profilePicture != null
                    ? [userData.profilePicture]
                    : []),
            UserDetails(
              userData: userData,
            ),
          ],
        ),
      ),
    );
  }
}
