/*import 'package:flutter/material.dart';

class StarAnimationExample extends StatefulWidget {
  @override
  _StarAnimationExampleState createState() => _StarAnimationExampleState();
}

class _StarAnimationExampleState extends State<StarAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 1.0,
      upperBound: 1.07,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zoom In-Out Star Animation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _controller.value,
              child: child,
            );
          },

          child: Container(
            width: 300,
            height: 57,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(12)),
              gradient: RadialGradient(
                colors: [Colors.yellow, Colors.orange],
                center: Alignment.center,
                radius: 0.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.5),
                  blurRadius: 9,
                  spreadRadius: 1,
                ),
              ],
            ),
            child:Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(



                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(12)),
                ),child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("On our platform, you can both sell and rent your products",style: TextStyle(

                        fontFamily:
                        "Montserrat-Italic",
                        color:
                      Colors.black,
                      fontWeight:
                      FontWeight.w500,
                      fontSize: 14),

                  maxLines: 2),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

class ExpandableList extends StatefulWidget {
  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  // Maintain the open/close state of each item
  List<bool> isOpenList = [];

  // Example filtered items
  List<Item> filteredItems = List.generate(
    10,
        (index) => Item(name: "Item $index", details: "Details for Item $index"),
  );

  @override
  void initState() {
    super.initState();
    isOpenList = List.generate(filteredItems.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expandable List")),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.58,
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // Main Container
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        // Toggle the state when the container is tapped
                        setState(() {
                          isOpenList[index] = !isOpenList[index];
                        });
                      },
                      child: Container(
                        height: 42,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                filteredItems[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                isOpenList[index]
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: Color(0xff675397),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded Content
                  if (isOpenList[index])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(

                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          filteredItems[index].details,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Item {
  final String name;
  final String details;

  Item({required this.name, required this.details});
}
