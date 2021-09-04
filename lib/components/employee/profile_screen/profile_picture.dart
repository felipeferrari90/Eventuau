import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key key, @required this.imageList}) : super(key: key);

  final List<String> imageList;

  @override
  PprofilePictureState createState() => PprofilePictureState();
}

class PprofilePictureState extends State<ProfilePicture> {
  int _imageIndex = 0;

  void _nextImage() => _imageIndex != widget.imageList.length - 1
      ? setState(() => _imageIndex++)
      : false;

  void _previousImage() =>
      _imageIndex > 0 ? setState(() => _imageIndex--) : false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(widget.imageList[_imageIndex],
              fit: BoxFit.fitHeight,
              alignment: Alignment.topCenter,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : Center(child: CircularProgressIndicator())),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.imageList.length > 1)
                  ...widget.imageList.map((element) {
                    return Container(
                      height: 4,
                      width: (MediaQuery.of(context).size.width /
                              widget.imageList.length) *
                          0.90,
                      decoration: BoxDecoration(
                          color:
                              widget.imageList.indexOf(element) == _imageIndex
                                  ? Colors.white
                                  : Colors.white24,
                          borderRadius: BorderRadius.circular(100)),
                    );
                  })
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: _previousImage,
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              InkWell(
                onTap: _nextImage,
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
