import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';


class ImageTile extends StatelessWidget {

  const ImageTile({
    Key? key,
    required this.index,
    required this.height,
  }) : super(key: key);

  final int index;
  final int height;

  Future<ui.Image> _getImage() {
    Completer<ui.Image> completer= Completer<ui.Image>();
    NetworkImage('https://source.unsplash.com/random/300x$height?sig=$index'),
    .resolve(const ImageConfiguration())
    .addListener(
      ImageStreamListener((ImageInfo info,bool _){
        completer.complete(info.image);
      }),
    );
    return completer.future;
    }

  @override
   Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(15) // Adjust the radius as needed
        ),
        child:FutureBuilder<ui.Image>(
          future: _getImage(),
          builder: (BuildContext context,AsyncSnapshot<ui.Image>snapshot){
            if(snapshot.hasData){
              ui.Image? image= snapshot.data;
              return
              RawImage(image:image,
              width: image!.width.toDouble(),
              height: image!.height.toDouble(),
              fit:BoxFit.cover,
              );
            }else{
              return const Text( 'Loading images ')
            }
          },
          )
        );
        }
        }