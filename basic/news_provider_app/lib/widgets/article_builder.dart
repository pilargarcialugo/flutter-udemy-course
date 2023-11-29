import 'package:flutter/material.dart';
import 'package:news_provider_app/models/news_response.dart';

class ArticleBuilder extends StatelessWidget {
  final Article article;
  final int index;

  const ArticleBuilder({
    super.key, 
    required this.article, 
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(article: article, index: index,),
        _CardTitle(title: article.title),
        _CardImage(article.urlToImage),
        _CardBody(article.description),
        _CardFooter('description'),
        const SizedBox(height: 10,),
        const Divider(),
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article article;
  final int index;

  const _TopBarCard({
    required this.article, 
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: const TextStyle(color: Color(0xfff4a261)),),
          Text('${article.source.name}.', style: const TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final String title;
  
  const _CardTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
    );
  }
}

class _CardImage extends StatelessWidget {
  final String? imageUrl;
  
  const _CardImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          child: imageUrl != null
          ? FadeInImage(
            placeholder: const AssetImage('assets/giphy.gif'), 
            image: NetworkImage(imageUrl!)
          )
          : const Image(image: AssetImage('assets/no-image.png'), )
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final String? description;
  
  const _CardBody(this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Text(description != null ? description! : ''),
    );
  }
}

class _CardFooter extends StatelessWidget {
  final String? description;
  
  const _CardFooter(this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () => {},
          fillColor: const Color(0xfff4a261),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: const Icon(Icons.star_border_outlined),
        ),
        const SizedBox(width: 10,),
        RawMaterialButton(
          onPressed: () => {},
          fillColor: const Color(0xfff4a261),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: const Icon(Icons.more_horiz_outlined),
        ),
      ],
    );
  }
}
