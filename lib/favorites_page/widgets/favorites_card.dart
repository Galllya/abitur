import 'package:abitur/domain/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class FavoritesCard extends StatelessWidget {
  final FavoritesDate _favoritesDate;
  final VoidCallback onButtonTap;

  const FavoritesCard(
      {Key? key,
      required FavoritesDate favoritesDate,
      required this.onButtonTap})
      : _favoritesDate = favoritesDate,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            onButtonTap();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _favoritesDate.title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            height: 22 / 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset('assets/icons/icon_calendar.svg',
                          height: 10, width: 10),
                    ),
                    Text(
                      DateFormat.yMd('ru_RU').format(_favoritesDate.dateFrom!),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 18 / 14,
                          color: Color(0xFF909090)),
                    )
                  ],
                ),
                const Icon(Icons.favorite)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
