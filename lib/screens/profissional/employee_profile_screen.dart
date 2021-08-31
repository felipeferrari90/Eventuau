import 'package:flutter/material.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({Key key}) : super(key: key);

  static const routeName = '/employee/profile';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 350,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/7/7e/Borat_in_Cologne.jpg',
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
                Positioned(
                  width: mediaQuery.size.width,
                  bottom: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: mediaQuery.size.width * 0.97,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => print('i clicked left'),
                      child: Container(
                        height: double.infinity,
                        width: mediaQuery.size.width * 0.5,
                      ),
                    ),
                    InkWell(
                      onTap: () => print('i clicked right'),
                      child: Container(
                        height: double.infinity,
                        width: mediaQuery.size.width * 0.5,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
