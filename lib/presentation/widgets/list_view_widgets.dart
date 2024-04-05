import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    super.key,
    required this.characters,
    required this.onTap,
  });

  final MyCharacterss characters;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 37,
              backgroundImage: NetworkImage(characters.image ?? ''),
            ),
            const SizedBox(
              width: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  characters.status ?? '',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.60,
                    letterSpacing: 1.50,
                  ),
                ),
                Text(
                  characters.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.60,
                    letterSpacing: 1.50,
                  ),
                ),
                Text(
                  '${characters.species}, ${characters.gender}',
                  style: const TextStyle(
                    color: Color(0xff6E798C),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.60,
                    letterSpacing: 1.50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
