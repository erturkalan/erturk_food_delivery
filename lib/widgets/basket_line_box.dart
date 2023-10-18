import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class BasketLineBox extends StatelessWidget {
  final String name;
  final String? image;
  final Function? increasedPressed;
  final Function? decreasePressed;
  final int quantity;
  final Function onDelete;

  const BasketLineBox(
      {Key? key,
      this.image,
      required this.name,
      this.decreasePressed,
      this.increasedPressed,
      this.quantity = 0,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: UniqueKey(),
        enabled: true,
        closeOnScroll: true,
        direction: Axis.horizontal,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            onDelete();
          }),
          children: [
            SlidableAction(
              onPressed: (c) {
                onDelete();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.1,
                  blurRadius: 11,
                  offset: const Offset(0, 5), // changes position of shadow
                )
              ],
            ),
            child: Row(
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => decreasePressed!(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 0.1,
                                      blurRadius: 11,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () => increasedPressed!(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 0.1,
                                      blurRadius: 11,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
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
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
