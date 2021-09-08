import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline4,
              children: [
                TextSpan(
                    text: 'Sacha Baron Cohen',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: " "),
                TextSpan(
                  text: '49',
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: primaryColor,
                    size: 26,
                  ),
                  Text(
                    '4.8',
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.attach_money,
                    color: primaryColor,
                    size: 26,
                  ),
                  Text(
                    'R\$20.00/h',
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.verified,
                    color: primaryColor,
                    size: 26,
                  ),
                  Text(
                    'Verificado',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: primaryColor,
                size: 26,
              ),
              Text(
                'A 20km de distância. Vila Mariana - São Paulo',
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          // Row(
          //   children: [
          //     Icon(
          //       Icons.watch_later,
          //       color: primaryColor,
          //       size: 26,
          //     ),
          //     Text(
          //       'Jornada de Trabaho: Seg a Sáb - 8h as 18h',
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: 4,
          // ),
          Chip(
            shape: StadiumBorder(side: BorderSide(color: primaryColor)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            label: Text('Animador'),
            labelStyle: Theme.of(context).textTheme.headline2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Sobre mim',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer congue tempus dui, ac rutrum tortor sollicitudin et. Duis eleifend bibendum lobortis. Maecenas cursus nulla nec rhoncus accumsan. Sed congue blandit tempor. Donec pretium eros sit amet efficitur rutrum. Maecenas finibus elementum odio eu efficitur. Sed posuere ipsum at lacus semper, a bibendum neque tincidunt.'),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
