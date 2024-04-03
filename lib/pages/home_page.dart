import 'package:flutter/material.dart';
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
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    //lấy kích thước màn hình hiện tại
    Size size = MediaQuery.of(context).size;
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
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          Container(
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
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
                                text: 'B',
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
                                      text: 'eautiful ',
                                      style: TextStyle(
                                        fontFamily: FontFamily.sen,
                                        fontSize: 56,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ])),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            '"Think of all the beauty still left around you and be happy."',
                            style: AppStyles.h4.copyWith(
                                letterSpacing: 1, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
          //Indicator
          SizedBox(
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

  Widget buildIndicator(bool isActive, Size size) {
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
