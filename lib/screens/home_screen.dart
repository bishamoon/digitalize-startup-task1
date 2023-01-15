import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:housen/main.dart';
import 'package:housen/model/house.dart';
import 'package:flutter/services.dart' as rootBundle;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return const Center(
              child: Text(
                'Error Happen!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          } else if (data.hasData) {
            var items = data.data as List<House>;
            return screen(items, context);
          } else {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
            );
          }
        },
      ),
    );
  }

  Widget screen(List<House> items, BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                    ),
                    InkWell(
                      child: Image(
                        image: AssetImage(
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? 'assets/images/dark.png'
                                : 'assets/images/light.png'),
                      ),
                      onTap: () {
                        MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                      },
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 17, top: 20, bottom: 10),
                child: Text(
                  'Find your ideal home !',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                width: 400,
                height: 200,
                child: MasonryGridView.count(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  mainAxisSpacing: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 2,
                  crossAxisCount: 1,
                  itemCount: items.length,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 370,
                      height: 200,
                      child: Image(
                        image: AssetImage(
                          items[index].imageURL.toString(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 24, top: 22, bottom: 11),
                child: TextField(
                  onChanged: searchItem('', items),
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search for address',
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 168, 168, 168),
                    ),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    prefix: SizedBox(
                      width: 25,
                      height: 25,
                      child: Row(
                        children: const [
                          Image(
                            image: AssetImage('assets/images/search.png'),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Image(
                            image: AssetImage('assets/images/divider.png'),
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                  enableSuggestions: true,
                ),
              ),
              const SizedBox(height: 7),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 24, bottom: 4),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 105, 53, 253)),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                mainAxisSpacing: 2,
                shrinkWrap: true,
                crossAxisSpacing: 2,
                crossAxisCount: 1,
                itemCount: items.length,
                padding: const EdgeInsets.only(left: 5, right: 5),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item.cityName}, ${item.stateName}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 14),
                                  child: Image(
                                      image:
                                          AssetImage('assets/images/Line.png')),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/Filter.png'),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '${item.cost}/ ${item.beds} Beds / Appt. ...3 more',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Color.fromARGB(255, 174, 166, 166)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }

// function to fetch data from local json file stored in assets!
  Future<List<House>> ReadJsonData() async {
    final jsonData = await rootBundle.rootBundle.loadString('assets/data.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => House.fromJson(e)).toList();
  }

  searchItem(
    String quary,
    List<House> items,
  ) {
    final suggestions = items.where((item) {
      final cityname = item.cityName!.toLowerCase();
      final input = quary.toLowerCase();
      return cityname.contains(input);
    }).toList();
    //error happen here , because we called setstate..
    //   setState(() => items = suggestions);
  }
}
