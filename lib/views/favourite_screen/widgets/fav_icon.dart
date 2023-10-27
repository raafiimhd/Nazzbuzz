import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';

class FavIcon extends StatelessWidget {
  final SongInfo currentSong;
  final RxBool isFav = false.obs; // Use RxBool for reactivity

  FavIcon({Key? key, required this.currentSong, required bool isFav})
      : super(key: key) {
    this.isFav.value = isFav; // Set initial value
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isFav.value) {
          isFav.value = false;
          removeFavourite(currentSong);
          // SnackBaaaar(text: 'Removed from favorite', context: context);
        } else {
          isFav.value = true;
          addFavourite(currentSong);
          // SnackBaaaar(text: 'Added to favorite', context: context);
        }
      },
      child: Obx(() {
        return (isFav.value)
            ? const Icon(Icons.favorite_sharp, color: Color.fromARGB(255, 21, 216, 83))
            : const Icon(Icons.favorite_border, color: Colors.white);
      }),
    );
  }
}
