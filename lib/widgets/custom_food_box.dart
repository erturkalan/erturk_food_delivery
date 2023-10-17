import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomFoodBox extends StatelessWidget {
  final String title;
  final String? image;
  final Function onPressed;
  final bool isFoodList;
  final bool isFavouriteActive;
  final Function? favouriteButtonPressed;
  final Function? addToBasketButtonPressed;
  final bool isInBasket;
  final Function? increasedPressed;
  final Function? decreasePressed;
  final int quantity;

  const CustomFoodBox(
      {Key? key,
      this.isFoodList = false,
      this.isFavouriteActive = false,
      required this.onPressed,
      this.image,
      required this.title,
      this.addToBasketButtonPressed,
      this.favouriteButtonPressed,
      this.isInBasket = false,
      this.decreasePressed,
      this.increasedPressed,
      this.quantity = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
      child: InkWell(
        onTap: () => onPressed(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.1,
                    blurRadius: 11,
                    offset: const Offset(0, 5), // changes position of shadow
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(
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
                      height: 38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    isFoodList
                        ? isInBasket
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () => decreasePressed!(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white60,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 0.1,
                                              blurRadius: 11,
                                              offset: const Offset(0,
                                                  5), // changes position of shadow
                                            )
                                          ],
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.remove,
                                            size: 32,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: const TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    InkWell(
                                      onTap: () => increasedPressed!(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white60,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 0.1,
                                              blurRadius: 11,
                                              offset: const Offset(0,
                                                  5), // changes position of shadow
                                            )
                                          ],
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.add,
                                            size: 32,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                child: InkWell(
                                    onTap: () => addToBasketButtonPressed!(),
                                    child: const Icon(
                                      Icons.shopping_basket_outlined,
                                      color: Colors.indigo,
                                    )),
                              )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
            isFoodList
                ? Positioned(
                    top: 10,
                    right: 10,
                    child: isFavouriteActive
                        ? InkWell(
                            onTap: () => favouriteButtonPressed!(),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white60.withOpacity(0.9),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ))
                        : InkWell(
                            onTap: () => favouriteButtonPressed!(),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white60.withOpacity(0.7),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            )),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
