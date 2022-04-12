

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/homeController/news_controller.dart';

final List<String> imgList = [
  'https://gamek.mediacdn.vn/133514250583805952/2021/8/21/photo-1-1629479455983180913024.jpg',
  'https://i.ytimg.com/vi/996scY71PNs/maxresdefault.jpg',
  'https://i.ytimg.com/vi/lTTDfNY_AMs/maxresdefault.jpg',
  'http://cdn-img-v2.webbnc.net/uploadv2/web/57/5733/slide/2017/02/27/04/43/1488169961_gdf.jpg?v=4',
  'https://image.thanhnien.vn/1200x630/Uploaded/2021/dbeyxqxqrs/2020_12_16/pic_yytk.jpg'
];

class News extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 200,
        width: MediaQuery.of(context).size.width-40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(children: [
          Expanded(
            child: CarouselSlider(
              items: imageSliders,
              carouselController: controller.carouseController,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 4.0,
                  height: 150,
                  onPageChanged: (index, reason) {
                      controller.current.value = index;
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return Obx(()=>GestureDetector(
                onTap: () => controller.carouseController.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(controller.current.value == entry.key ? 0.9 : 0.4)),
                ),
              ));
            }).toList(),
          ),
        ]),
      ),
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ],
        )),
  ),
))
    .toList();