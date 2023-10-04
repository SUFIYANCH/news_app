import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/provider.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/services/user_service.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/responsive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ref.watch(singleUserProvider).when(
                    data: (data) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://api.dicebear.com/6.x/initials/png?seed=${data.data()!.username}"),
                        ),
                        title: const Text("Good Morning"),
                        subtitle: Text(
                          data.data()!.username,
                          style: TextStyle(
                              fontSize: R.sw(16, context),
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            ref.read(currentTabProvider.notifier).state = 1;
                            ref.read(pageControllerProvider).jumpToPage(1);
                          },
                          child: CircleAvatar(
                            backgroundColor: secondaryColor,
                            child: const Icon(Icons.search),
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              Text(
                "Breaking News",
                style: TextStyle(
                    fontSize: R.sw(22, context), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height: R.sh(230, context),
                  child: ref.watch(getAllNewsProvider).when(
                        data: (data) {
                          log(data!.data.toString());
                          return Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: 5,
                                itemBuilder: ((context, index, realIndex) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(top: R.sw(10, context)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            R.sw(8, context)),
                                        image: DecorationImage(
                                          image: NetworkImage(data
                                                  .data[index].image ??
                                              "https://img.freepik.com/free-vector/global-earth-blue-technology-digital-background-design_1017-27075.jpg?w=1380&t=st=1691990839~exp=1691991439~hmac=4b1794da1411e3d3d71b0a2ff97fdec90a2752b53a82205e62e4b92ed406fddc"
                                                  .toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(R.sw(16, context)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: R.sw(224, context),
                                              ),
                                              child: Container(
                                                height: R.sh(30, context),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            R.sw(50, context))),
                                                child: Text(
                                                  data.data[index].category,
                                                  style: TextStyle(
                                                      color: tertiaryColor),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${data.data[index].source} - time',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: tertiaryColor,
                                                      fontSize:
                                                          R.sw(14, context)),
                                                ),
                                                SizedBox(
                                                  height: R.sh(10, context),
                                                ),
                                                Text(
                                                  data.data[index].title,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: tertiaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          R.sw(16, context)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                options: CarouselOptions(
                                  initialPage: 0,
                                  height: R.sh(200, context),
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  viewportFraction: 0.85,
                                  onPageChanged: (index, reason) {
                                    ref.read(carouselProvider.notifier).state =
                                        index;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: R.sh(10, context),
                              ),
                              AnimatedSmoothIndicator(
                                activeIndex: ref.watch(carouselProvider),
                                duration: const Duration(milliseconds: 900),
                                count: 5,
                                effect: WormEffect(
                                    dotHeight: R.sh(10, context),
                                    dotWidth: R.sw(10, context),
                                    activeDotColor: primaryColor,
                                    dotColor: Colors.grey.withOpacity(0.5)),
                              ),
                            ],
                          );
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
              SizedBox(
                height: R.sh(12, context),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: R.sw(16, context)),
                height: R.sh(40, context),
                child: DefaultTabController(
                  length: 6,
                  child: TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      splashBorderRadius:
                          BorderRadius.circular(R.sw(50, context)),
                      dividerColor: Colors.transparent,
                      labelColor: secondaryColor,
                      indicator: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(R.sw(50, context)),
                          color: primaryColor),
                      tabs: const [
                        Tab(
                          child: Text('All'),
                        ),
                        Tab(
                          child: Text('Sport'),
                        ),
                        Tab(
                          child: Text('Politic'),
                        ),
                        Tab(
                          child: Text('Education'),
                        ),
                        Tab(
                          child: Text('Stocks'),
                        ),
                        Tab(
                          child: Text('Finance'),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: R.sh(16, context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: R.sw(16, context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Only for you",
                      style: TextStyle(
                          fontSize: R.sw(22, context),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: R.sh(20, context),
              ),
              SizedBox(
                  height: R.sh(300, context),
                  width: R.sw(340, context),
                  child: ref.watch(getCountryNewsProvider).when(
                        data: (data) {
                          return ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: R.sh(10, context),
                              );
                            },
                            itemCount: data!.data.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DetailScreen(),
                                  )),
                              child: Container(
                                height: R.sh(100, context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        R.sw(12, context))),
                                child: Row(
                                  children: [
                                    Container(
                                      width: R.sw(100, context),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            R.sw(12, context),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(data
                                                      .data[index].image ??
                                                  "https://img.freepik.com/free-vector/global-earth-blue-technology-digital-background-design_1017-27075.jpg?w=1380&t=st=1691990839~exp=1691991439~hmac=4b1794da1411e3d3d71b0a2ff97fdec90a2752b53a82205e62e4b92ed406fddc"),
                                              fit: BoxFit.cover)),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: R.sw(12, context)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              data.data[index].source,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Color(0xFF4B4B4B)),
                                            ),
                                            Text(
                                              data.data[index].title,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  height: 1,
                                                  fontSize: R.sw(18, context)),
                                            ),
                                            Text(
                                              data.data[index].author ??
                                                  "Unknown",
                                              style: const TextStyle(
                                                  color: Color(0xFF4B4B4B)),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
