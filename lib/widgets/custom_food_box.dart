import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomFoodBox extends StatelessWidget {
  final String title;
  final String? image;
  final Function onPressed;
  final bool isFavouriteActive;
  final bool isAddToBasketActive;

  const CustomFoodBox(
      {Key? key,
      this.isAddToBasketActive = false,
      this.isFavouriteActive = false,
      required this.onPressed,
      this.image,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
      child: InkWell(
        onTap: () => onPressed(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 5), // changes position of shadow
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image != null
                        ? CachedNetworkImage(
                            fit: BoxFit.fitHeight,
                            imageUrl: image!,
                            placeholder: (context, url) =>
                                const Icon(Icons.photo),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Image.asset("images/noImage.jpg"),
                  ),
                ),
                SizedBox(
                  height: 96,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
