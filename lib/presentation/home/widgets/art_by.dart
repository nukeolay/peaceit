import 'package:flutter/material.dart';
import 'package:peaceit/core/constants/default_game_settings.dart';

class ArtBy extends StatelessWidget {
  const ArtBy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'art by ',
            style: TextStyle(fontSize: 16),
          ),
          Image(
            image: AssetImage(DefaultGameSettings.igLogoImage),
            height: 18,
            color: Colors.white,
          ),
          Text(
            ' dinaornot',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
