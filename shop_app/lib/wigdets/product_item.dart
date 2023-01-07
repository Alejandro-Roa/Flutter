import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';

class ProdcutItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProdcutItem(this.id, this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTileBar(
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => {
              Navigator.of(context).pushNamed(
                MaterialPageRoute(
                  builder: ((ctx) => ProductDetailScreen(title)),
                ),
              ),
            },
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      header: Text(title),
      child: GestureDetector(
        onTap: () => {},
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
