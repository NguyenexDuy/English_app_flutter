import 'dart:ffi';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app01/models/english_today.dart';
import 'package:flutter_app01/models/qoute_model.dart';
import 'package:flutter_app01/models/quote.dart';
import 'package:flutter_app01/values/app_assets.dart';
import 'package:flutter_app01/values/app_colors.dart';
import 'package:flutter_app01/values/app_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  List<EnglishToday> words = [];
  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() {
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: 5, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });

    words = newList.map((e) => EnglishToday(noun: e)).toList();
  }

  getQoute(String noun) {
    Quote? qoute;
    qoute = Quotes().getByWord(noun);

    return EnglishToday(noun: noun, quote: qoute?.content, id: qoute?.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(viewportFraction: 0.9);
    getEnglishToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //lấy kích thước màn hình hiện tại
    ui.Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          elevation: 0,
          title: Text(
            "English today",
            style:
                AppStyles.h3.copyWith(color: AppColors.textColor, fontSize: 36),
          ),
          leading: InkWell(
            onTap: () {},
            child: Image.asset(AppAssets.menu),
          )),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerLeft,
            height: size.height * 1 / 10,
            child: Text(
              '"It is amazing how complete is the delusion that beauti is goodness."',
              style: AppStyles.h5
                  .copyWith(fontSize: 15, color: AppColors.textColor),
            ),
          ),

          //item card english
          Container(
            height: size.height * 2 / 3,
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: words.length,
                itemBuilder: (context, index) {
                  String firstLetter =
                      words[index].noun != null ? words[index].noun! : '';
                  firstLetter = firstLetter.substring(0, 1);

                  String leftLetter =
                      words[index].noun != null ? words[index].noun! : '';
                  leftLetter = leftLetter.substring(1, leftLetter.length);

                  String quoteDefault =
                      "Think of all the beauty still left around you and be happy";

                  String qoute = words[index].quote != null
                      ? words[index].quote!
                      : quoteDefault;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(3, 6),
                                blurRadius: 6)
                          ],
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(AppAssets.heart)),
                          RichText(
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: firstLetter,
                                  style: TextStyle(
                                      fontFamily: FontFamily.sen,
                                      fontSize: 89,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(3, 6),
                                            blurRadius: 6)
                                      ]),
                                  children: [
                                    TextSpan(
                                        text: leftLetter,
                                        style: TextStyle(
                                          fontFamily: FontFamily.sen,
                                          fontSize: 56,
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ])),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Text(
                              '"$qoute"',
                              style: AppStyles.h4.copyWith(
                                  letterSpacing: 1, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          //Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              height: size.height * 1 / 13,
              child: Container(
                height: 8,
                padding: const EdgeInsets.symmetric(vertical: 24),
                alignment: Alignment.center,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return buildIndicator(index == _currentIndex, size);
                  },
                ),
              ),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          print("exchaned");
        },
        child: Image.asset(AppAssets.exchange),
      ),
    );
  }

  Widget buildIndicator(bool isActive, ui.Size size) {
    return Container(
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
}
