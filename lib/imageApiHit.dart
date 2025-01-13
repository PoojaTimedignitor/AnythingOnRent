import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class estimation extends StatefulWidget {
  const estimation({super.key});

  @override
  State<estimation> createState() => _estimationState();
}

class _estimationState extends State<estimation> {

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  final _razorpay = Razorpay();
  String orderPaymentId = "";



  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    print("response.paymentId ${response.paymentId}  ${response.data}");

    orderPaymentId = response.paymentId.toString();

    print("orderPaymentId ${orderPaymentId} ");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // setSnackBars(response.message!, context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message!)
        ));

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: ${response.walletName!}");
  }

  List<Map<String, int>> listAmounts = [
    {"amount": 48},
    {"amount": 78}
  ];


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:  Container(
        height: screenHeight,
        child: ListView.builder(
          itemCount: listAmounts.length,
          itemBuilder: (context, index) {
            final amount = listAmounts[index]['amount'];
            return ListTile(
              contentPadding: EdgeInsets.only(
                  top:  screenHeight * 0.03,
                  left: screenWidth * 0.1
              ),
              title: GestureDetector(
                onTap: (){
                  print("listAmounts[index]['amount'] ${listAmounts[index]['amount']}");
                  razorpayPayment(double.parse(listAmounts[index]['amount'].toString()));
                },
                child: Container(
                    color: Colors.transparent,
                    child: Text("Amount: $amount")),
              ),
            );
          },
        ),
      ),

    );
  }

  razorpayPayment(double price) async {

    double amt = price * 100;

    var options = {
      'key': "rzp_test_XXp6pYrKU2MgRN",
      'amount': amt.toString(),
      'name': 'Order Payment',
      'prefill': {'contact': '', 'email': ''},
      'description': "My Project Recharge",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'external': {
        'wallets': ['']
      }
    };
    print("options  $options");
    try {
      _razorpay.open(
        options,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

//razorpay_flutter:
