import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../DetailScreen.dart';
import '../MyBehavior.dart';
import '../ResponseModule/getAllProductList.dart';
import '../model/dio_client.dart';

class MyCollection extends StatefulWidget {
  const MyCollection({super.key});

  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  bool isSearchingData = false;
  List<Products> filteredItems = [];
  List<Products> items = [];
  bool isLoading = true;
  int currentIndex = 0;
  int page = 1;
  bool isPagination = true;
  String? selectedProductId;
  final List<String> Price = [
    "11,400",
    "500",
    "345",
    "5000",
  ];
  final List<String> Labels = [
    "/Per Hour",
    "/Per Day",
    "/Per Week",
    "/Per Month"
  ];

  @override
  void initState() {
    fetchProductsList(page);
    super.initState();
  }

  Future<void> fetchProductsList(int page) async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllProductList();
      var jsonList = getAllProductList.fromJson(response);
      setState(() {
        items = jsonList.products ?? [];

        filteredItems = List.from(items);

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("loader $isLoading");
    }
  }



  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 2));
    filteredItems.clear();
    page = 1;
    isPagination = true;
    fetchProductsList(page);
    print("Data has been refreshed!");

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffafaff),
        body: RefreshIndicator(
          onRefresh: refreshList,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.04,
                    left: SizeConfig.screenWidth * 0.05),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    Expanded(
                      child: Center(
                        child: !isSearchingData
                            ? Text(
                                "My Post",
                                style: TextStyle(
                                  fontFamily: "Montserrat-Medium",
                                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                                  color: CommonColor.TextBlack,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(left: 14),
                                child: TextField(
                                  onChanged: (String query) {
                                    setState(() {
                                      filteredItems = items
                                          .where((item) =>
                                              item.name != null &&
                                              item.name!
                                                  .toLowerCase()
                                                  .contains(query.toLowerCase()))
                                          .toList();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    border: InputBorder.none,
                                  ),
                                  autofocus: true,
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(13.0),
                      child: GestureDetector(
                        onTap: () {
                          print("list...$filteredItems");
                          setState(() {
                            isSearchingData = !isSearchingData;
                            if (!isSearchingData) {
                              filteredItems = items;
                            }
                          });
                        },
                        child: Icon(
                          isSearchingData ? Icons.close : Icons.search_rounded,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),
              MainCollectionData(SizeConfig.screenHeight, SizeConfig.screenWidth)
            ],
          ),
        ));
  }

  Widget MainCollectionData(double parentHeight, double parentWidth) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(shrinkWrap: true, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider()),
              SizedBox(
                width: 10,
              ),
              Center(
                  child: Text(
                "TO CREATE ALL PRODUCT LIST CHOOSE",
                style: TextStyle(color: Colors.grey[500]!),
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(child: Divider()),
            ],
          ),
          isLoading
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Image(
                      image: AssetImage("assets/images/logo.gif"),
                      height: SizeConfig.screenHeight * 0.16),
                ))
              : filteredItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredItems.length,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final product = filteredItems[index];
                        final productImages = product.images ?? [];
                        final rent = product.rent;

                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 600),
                                  reverseTransitionDuration:
                                      Duration(milliseconds: 400),
                                  pageBuilder: (_, __, ___) =>
                                      DetailScreen(product: product),
                                  transitionsBuilder: (_, animation,
                                      secondaryAnimation, child) {
                                    var curve = Curves.easeInOut;
                                    var tween = Tween(begin: 0.0, end: 1.0)
                                        .chain(CurveTween(curve: curve));
                                    return FadeTransition(
                                      opacity: animation.drive(tween),
                                      child: ScaleTransition(
                                        scale: animation.drive(tween),
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              );


                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              child: Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: product.sId
                                          .toString(),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.13,
                                                 width: 120,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                  margin: EdgeInsets.all(4),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.11,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.13,
                                                  child: Center(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/home.jpeg'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                           EdgeInsets.only(top: 5,left: 2),
                                                      child: Container(
                                                        width: 190,
                                                        child: Text(
                                                          filteredItems[index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: CommonColor
                                                                .Black,
                                                            fontFamily:
                                                                "okra_Medium",
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),



                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 4,top: 4),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.035,
                                                            child:
                                                                CarouselSlider
                                                                    .builder(
                                                              itemCount:
                                                                  items.length,
                                                              options:
                                                                  CarouselOptions(
                                                                initialPage: 1,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.13,
                                                                viewportFraction:
                                                                    1.0,
                                                                enableInfiniteScroll:
                                                                    false,
                                                                autoPlay: true,
                                                                enlargeStrategy:
                                                                    CenterPageEnlargeStrategy
                                                                        .height,
                                                              ),
                                                              itemBuilder: (BuildContext
                                                                      context,
                                                                  int itemIndex,
                                                                  int index1) {
                                                                final Rent?
                                                                    rent =
                                                                    items[itemIndex]
                                                                        .rent;
                                                                String priceDisplay = rent !=
                                                                        null
                                                                    ? rent.perDay !=
                                                                                null &&
                                                                            rent.perDay! >
                                                                                0
                                                                        ? "₹${rent.perDay} (Day)"
                                                                        : "Price Not Available"
                                                                    : "Price Not Available";

                                                                return Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                    priceDisplay,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xffFE7F64),
                                                                      letterSpacing:
                                                                          0.2,
                                                                      fontFamily:
                                                                          "okra_Medium",
                                                                      fontSize:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              3.4,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: SizeConfig
                                                                        .screenHeight *
                                                                    0.017,
                                                                color: Color(
                                                                    0xff3684F0),
                                                              ),
                                                              Flexible(
                                                                child:
                                                                    Container(
                                                                  width: 250,
                                                                  child: Text(
                                                                    ' MG ROAD, PUNE',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xff3684F0),
                                                                      fontFamily:
                                                                          "okra_Regular",
                                                                      fontSize:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              3.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                width:80,
                                                                child: Text(
                                                                  "Honda Shine 125cc 2024 Model",
                                                                  style: TextStyle(
                                                                    letterSpacing: 0.2,
                                                                    color: Colors.grey[500]!,
                                                                    fontFamily: "okra_Regular",
                                                                    fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis, // Truncate overflowed text
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: Alignment.topRight,
                                                                child: Container(
                                                                  color: Colors.white,
                                                                  child: Text(
                                                                    " 20 Nov 2024  ",
                                                                    style: TextStyle(
                                                                      color: Colors.grey[500]!,
                                                                      letterSpacing: 0.2,
                                                                      fontFamily: "okra_Bold",
                                                                      fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                    textAlign: TextAlign.right,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  selectedProductId = product.sId;
                                                });
                                                 showModalBottomSheet(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(20),
                                                        topRight: Radius.circular(20),
                                                      ),
                                                    ),
                                                    context: context,
                                                    backgroundColor: Colors.white,
                                                    elevation: 2,
                                                    isScrollControlled: true,
                                                    isDismissible: true,
                                                    builder: (BuildContext bc) {
                                                      return EditDeleteBottomSheet(  productId:selectedProductId.toString(), fetchProductsList: fetchProductsList,);
                                                    });


                                              },
                                              child: Container(
                                                height: 55,
                                                width: 45,
                                               // color: Colors.red,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20,right: 10),
                                                  child: Image(
                                                    image: AssetImage(
                                                        'assets/images/more.png'),

                                                  ),
                                                ),
                                              ),
                                            ),


                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_sharp,
                            color: CommonColor.noResult,
                            size: 50,
                          ),
                          Text("No results found",
                              style: TextStyle(
                                color: CommonColor.Black,
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(height: 10),
                          Container(
                            width: SizeConfig.screenWidth * 0.6,
                            child: Text(
                              "We couldn't find what you searched for try searching again",
                              style: TextStyle(
                                color: CommonColor.gray,
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
        ]),
      ),
    );
  }
}
class EditDeleteBottomSheet extends StatefulWidget {
  final String?productId;
  final Future<void> Function(int) fetchProductsList;
  const EditDeleteBottomSheet({super.key, required this.productId, required this.fetchProductsList});

  @override
  State<EditDeleteBottomSheet> createState() => _EditDeleteBottomSheetState();
}

class _EditDeleteBottomSheetState extends State<EditDeleteBottomSheet> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Center(
                  child: Container(
                    color: CommonColor.showBottombar.withOpacity(0.2),
                    height: SizeConfig.screenHeight * 0.004,
                    width: SizeConfig.screenHeight * 0.1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 13),
            Center(
              child: Text(
                "Select Options",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w400,
                    color: CommonColor.Black),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        image: AssetImage('assets/images/editing.png'),
                        height: 18),
                    SizedBox(width: 8),
                    Text(
                      " Can edit",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "okra_Medium",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 8),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
                showDialog(
          context: context,
          builder: (BuildContext context) {
            return DeleteConfirmationDialog(productId: widget.productId.toString(),
                fetchProductsList: widget.fetchProductsList);
          },
        );
      },
              child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 27,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: "okra_Medium",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteConfirmationDialog extends StatefulWidget {
  final String productId;
  final Future<void> Function(int) fetchProductsList;

  const DeleteConfirmationDialog({Key? key, required this.productId, required this.fetchProductsList}) : super(key: key);

  @override
  State<DeleteConfirmationDialog> createState() => _DeleteConfirmationDialogState();
}

class _DeleteConfirmationDialogState extends State<DeleteConfirmationDialog> {

  bool isLoading = true;
/*  void deleteProduct(String productId) async {
    setState(() {
      isLoading = true;
    });

    try {

      Map<String, dynamic> response = await ApiClients().deleteProduct(productId);

      if (response['success'] == true) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Product deleted successfully')),
        );

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Failed to delete product')),
        );
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    } finally {
      setState(() {
        isLoading = false; // Hide loader
      });
    }
  }*/






  void deleteProduct(String productId) async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> response = await ApiClients().deleteProduct(productId);

      if (response['success'] == true) {

        await widget.fetchProductsList(1);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? '')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? '')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 9),
            Text(
              "Delete Product?",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Are you sure you want to delete this product?",
              style: TextStyle(
                fontFamily: "Roboto_Regular",
                fontSize: 14,
                color: CommonColor.grayText,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Container(
                    width: SizeConfig.screenWidth * 0.25,
                    height: SizeConfig.screenHeight * 0.05,

                    child: Center(
                        child: Text("Cancel",

                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto-Regular',
                              fontSize:
                              SizeConfig.blockSizeHorizontal *
                                  4.4),
                        )
                    )
                ),





      GestureDetector(
        onTap: (){
          Navigator.pop(context);
          deleteProduct(widget.productId);
        },
        child: Container(
            width: SizeConfig.screenWidth * 0.27,
            height: SizeConfig.screenHeight * 0.05,
            decoration: BoxDecoration(
              color:  Color(0xffe64949),

              borderRadius:  BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.delete_outline_outlined,
                        color: CommonColor.white,
                        size: 22,
                      ),

                      Text("Delete",

                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto-Regular',
                            fontSize:
                            SizeConfig.blockSizeHorizontal *
                                4.1),
                      ),
                    ],
                  )),
            )),
      ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}

