import 'package:flutter/material.dart';

class CollectionsWidget extends StatelessWidget {
  const CollectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> collectionImagePaths = [
      'assets/category_loafers.jpg',
      'assets/dress_shoe.jpeg',
      'assets/sandal_category.jpeg',
      'assets/sneaker_category.jpeg'
    ];
    List<String> collectionNames = [
      'Dress Shoes',
      'Loafers',
      'Slides and Sandals',
      'Sneakers'
    ];
    return GridView.builder(
        itemCount: collectionImagePaths.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 160,
                height: 176,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    
                    collectionImagePaths[index],
                  ),
                )),
              ),
              Text(collectionNames[index],  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff0A0B0A),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),)
            ],
          );
        });
  }
}
