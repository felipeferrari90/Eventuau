import 'package:flutter/material.dart';

class AddDocumentCard extends StatefulWidget {
  const AddDocumentCard(
      {Key key,
      @required this.text,
      @required this.onTap,
      this.isOnRow = false})
      : super(key: key);

  final String text;
  final Function onTap;
  final bool isOnRow;

  @override
  _AddDocumentCardState createState() => _AddDocumentCardState();
}

class _AddDocumentCardState extends State<AddDocumentCard> {
  bool hasAddedPhoto = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: !widget.isOnRow ? double.infinity : 130,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: widget.onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // MOSTRAR SÓ SE TIVER FOTO
              if (hasAddedPhoto)
                Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                    )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                    size: 42,
                  ),
                  Text(
                    widget.text,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
