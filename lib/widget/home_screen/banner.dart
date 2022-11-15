import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shop_app/provider/banner_provider.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../ui/color.dart';

class BannerHomePage extends StatefulWidget {
  const BannerHomePage({super.key});

  @override
  State<BannerHomePage> createState() => _BannerHomePageState();
}

class _BannerHomePageState extends State<BannerHomePage> {
  BannerProvider get read => context.read<BannerProvider>();
  final controller = CarouselController();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget buildImage(String urlImage, int index) => ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.network(urlImage, fit: BoxFit.cover));

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          CarouselSlider.builder(
              carouselController: controller,
              itemCount: read.mListBanner.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = read.mListBanner[index].image;
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index))),
          const SizedBox(height: 12),
          buildIndicator()
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 10, dotHeight: 10, activeDotColor: colorMain),
        activeIndex: activeIndex,
        count: read.mListBanner.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}
