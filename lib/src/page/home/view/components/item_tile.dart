import 'package:flutter/material.dart';
import 'package:lab_app/src/model/item_model.dart';
import 'package:lab_app/src/page/product/product_screen.dart';
import 'package:lab_app/src/services/utils_services.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    super.key,
    required this.items,
    required this.cartAnimationMethod,
  });

  final ItemModel items;
  final Function(GlobalKey) cartAnimationMethod;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey gkImage = GlobalKey();

  final UtilsServices utilsServices = UtilsServices();

  IconData tileIcon = Icons.shopping_cart_checkout_outlined;

  Future<void> switchIcon() async {
    setState(() {
      tileIcon = Icons.check;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      tileIcon = Icons.shopping_cart_checkout_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ProductScreen(itemModel: widget.items);
              }),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.items.imageUrl,
                      child: Image.asset(
                        widget.items.imageUrl,
                        key: gkImage,
                      ),
                    ),
                  ),
                  Text(
                    widget.items.itemName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(widget.items.price),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "/${widget.items.unit}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(13),
              topRight: Radius.circular(15),
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  widget.cartAnimationMethod(gkImage);
                  switchIcon();
                },
                child: Ink(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
