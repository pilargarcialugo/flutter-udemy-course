import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _createDecoration(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(
              product.picture
            ),
            _ProductDetails(
              product.id, 
              product.name
            ),
            Positioned(
              top: 0, 
              right: 0, 
              child: _PriceTag(product.price)
            ),
            if (!product.available)
              const Positioned(
                top: 0, 
                left: 0, 
                child: _NotAvailable()
              ) 
          ],
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => BoxDecoration(
    color: const Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}

class _BackgroundImage extends StatelessWidget {
  final String? imageUrl;

  const _BackgroundImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: imageUrl == null 
        ? const Image(
          image: AssetImage('assets/no-image.png'), 
          fit: BoxFit.cover,
          )
        : FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(imageUrl!),
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String? productId;
  final String productName;

  const _ProductDetails(this.productId, this.productName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName, 
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              productId!, 
              style: const TextStyle(fontSize: 15, color: Colors.white,),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Color(0xffe76f51),
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _PriceTag extends StatelessWidget {
  final double price;
  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xffe76f51),
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$price', style: const TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xffE9C46A),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Agotado', style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}

