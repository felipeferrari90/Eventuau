import 'package:event_uau/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key key, this.userData}) : super(key: key);

  final User userData;

  

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    print(userData.address.toString());
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
                    text: userData.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: " "),
                TextSpan(
                  text: (DateTime.now().year - userData.birthDate.year)
                      .toString(),
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
                  Text(userData.partnerData?.grade ?? 'Novo!')
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
                    'R\$${userData.partnerData.valorHora.toStringAsFixed(2)}/h',
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
          if (userData.address != null) ...[
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: primaryColor,
                  size: 26,
                ),
                Text(
                    '${userData.address.bairro} - ${userData.address.cidade}/${userData.address.estado}')
              ],
            ),
            SizedBox(
              height: 4,
            ),
          ],
          ...userData.partnerData.especialidades
              .map(
                (e) => Chip(
                  shape: StadiumBorder(side: BorderSide(color: primaryColor)),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  label: Text(e.descricao),
                  labelStyle: Theme.of(context).textTheme.headline2,
                ),
              )
              .toList(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Sobre mim',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text(
            userData.aboutMe ?? 'Não há nada aqui, ainda...',
            style: userData.aboutMe == null
                ? TextStyle(color: Colors.grey[500])
                : null,
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
