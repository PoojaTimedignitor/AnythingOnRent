import 'package:flutter/material.dart';

import '../Common_File/new_responsive_helper.dart';

class NearbyProductDetail extends StatefulWidget {
  final String imageUrl;

  const NearbyProductDetail({super.key, required this.imageUrl});

  @override
  State<NearbyProductDetail> createState() => _NearbyProductDetailState();
}

class _NearbyProductDetailState extends State<NearbyProductDetail> {
  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.imageUrl,
              fit: BoxFit.contain,
            ),
            Container(
              width: double.infinity,
               height: 500,
               color: Colors.black26,
               margin: responsive.getMargin(all: 0).copyWith(top: responsive.isMobile ? 4 : 4 , bottom: responsive.isMobile ? 4 : 4 , ),
           //  padding: responsive.getPadding(all: 0).copyWith(left: responsive.isMobile ? 5 : 30, right: responsive.isMobile ? 5 : 5),              /// new add responsive padding
        
            )
          ],
        ),
      ),
    );
  }
}
