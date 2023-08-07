import 'package:flutter/material.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/model/db_model.dart';




class favIcon extends StatefulWidget {
  SongInfo currentSong;
  bool isfav;
  favIcon({super.key, required this.currentSong, required this.isfav});

  @override
  State<favIcon> createState() => _favIconState();
}

class _favIconState extends State<favIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(
          () {
            if (widget.isfav) {
              widget.isfav = false;
             removeFavourite(widget.currentSong);
            //  SnackBaaaar(text: 'Removed from favorite', context: context);
            } else {
              widget.isfav=true;
              addFavourite(widget.currentSong);
            //   SnackBaaaar(text: 'Added to favourite', context: context,);
            }
          },
        );
      },
      child: (widget.isfav)
          ? const Icon(Icons.favorite_sharp,color: Color.fromARGB(255, 21, 216, 83),)
          : const Icon(Icons.favorite_border,color: Colors.white,),
    );
  }
}