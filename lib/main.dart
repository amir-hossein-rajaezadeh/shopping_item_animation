import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late final AnimationController _slideController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 180),
  );

  late final Animation<Offset> _slideAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(3.5, -5.05),
  ).animate(_slideController);
  double imageWidth = 300;

  late final Animation<double> _fadeAnimation =
      Tween<double>(begin: 0, end: 1).animate(_fadeController);
  bool isDone = false;
  double shopWidth = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
        margin: const EdgeInsets.only(top: 70, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopNavBarWidget(),
            _buildTextFieldWidget(),
            buildViewAllAndReleaseWidget(),
            _buildShoesItemWidget()
          ],
        ),
      ),
    );
  }

  Container _buildShoesItemWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 180,
            height: 240,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                        color: Colors.grey.shade300,
                      ),
                      child: Image.asset(
                        "assets/images/shoes_transparent.png",
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                        height: 170,
                      ),
                    ),
                    _buildAnimatingShoesWidget(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 0, left: 0),
                        child: IconButton(
                          onPressed: () async {
                            if (isDone) {
                              _slideController.reverse();
                              await Future.delayed(
                                const Duration(milliseconds: 800),
                              );
                              setState(
                                () {
                                  imageWidth = 300;
                                },
                              );

                              await Future.delayed(
                                const Duration(milliseconds: 220),
                              );
                              _fadeController.reverse();

                              setState(
                                () {
                                  shopWidth = 45;
                                  isDone = false;
                                },
                              );
                            } else {
                              setState(
                                () {
                                  imageWidth = 110;
                                },
                              );
                              await Future.delayed(
                                const Duration(milliseconds: 300),
                              );
                              _fadeController.forward();

                              await Future.delayed(
                                const Duration(milliseconds: 800),
                              );

                              _slideController.forward();

                              setState(() {
                                imageWidth = 50;
                              });

                              await Future.delayed(
                                const Duration(milliseconds: 150),
                              );
                              setState(() {
                                shopWidth = 90;
                                isDone = true;
                              });
                            }
                          },
                          icon: Icon(
                            imageWidth != 300
                                ? Icons.remove_circle_outline
                                : Icons.add_circle_outline_sharp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 8),
                  child: const Text(
                    "Boston suede",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 2),
                  child: Text(
                    "\$199",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                )
              ],
            ),
          ),
          _buildItemLoadingWidget()
        ],
      ),
    );
  }

  Container buildViewAllAndReleaseWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "New Releases",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700),
          ),
          const Text(
            "View All",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Container _buildTextFieldWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 14, bottom: 12),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Colors.grey.shade600,
          ),
          fillColor: Colors.grey.shade300,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  Row _buildTopNavBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Home",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        InkWell(
          onTap: () {
            setState(() {
              shopWidth = 50;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: shopWidth,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: shopWidth == 45 ? Colors.transparent : Colors.grey),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 4,
                  ),
                  if (shopWidth != 45 && !_slideController.isAnimating)
                    const Expanded(
                      child: Text(
                        "1",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: const Icon(Icons.shopping_bag_outlined),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Visibility _buildAnimatingShoesWidget() {
    return Visibility(
      visible: shopWidth != 50,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: AnimatedContainer(
            width: imageWidth,
            duration: const Duration(milliseconds: 600),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: !_slideController.isAnimating
                        ? Colors.white
                        : Colors.grey),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: Image.asset(
                  "assets/images/shoes_transparent.png",
                  alignment: Alignment.topRight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildItemLoadingWidget() {
    return Container(
      width: 180,
      height: 240,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF5D3E8),
            Color(0xFFFAF0D4),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                12,
              ),
              bottomRight: Radius.circular(12),
            ),
          ),
          height: 68,
          child: const Padding(
            padding: EdgeInsets.only(top: 12, left: 8),
            child: PlaceholderLines(
              animate: true,
              count: 2,
            ),
          ),
        ),
      ),
    );
  }
}
