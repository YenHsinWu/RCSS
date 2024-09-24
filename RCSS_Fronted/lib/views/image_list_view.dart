import 'package:flutter/material.dart';

import '../pages/service_page.dart';

class ImageListView extends StatelessWidget {
  ImageListView({super.key, required this.imagesCount});
  final int imagesCount;
  final List<String> imagesPath = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imagesPath.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
                child: Image.asset(imagesPath[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServicePage(
                        serviceIndex: 0,
                      ),
                    ),
                  );
                }),
          ],
        );
      },
    );
  }
}
