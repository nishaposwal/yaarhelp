import 'package:fiverr_clone/pages/dropDown.dart';
import 'package:fiverr_clone/pages/main_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePost extends StatefulWidget {
  // const CreatePost({ Key? key }) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

Widget top(BuildContext context) {
  return Material(
    elevation: 5,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Text(
                      'Post a help',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 24),
                    ),
                  ),
                  Text(
                    'Ask for any kind of help',
                    style: TextStyle(
                        color: Color(0xff000000).withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Image(
                image: AssetImage('assets/images/people.jpeg'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Tell us what do you need done we’ll help you find someone who can help you in your work',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _CreatePostState extends State<CreatePost> {
  String category;
  String subCategory;
  final timerequiredController = new TextEditingController();
  final budgetController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final addressController = new TextEditingController();
  final categoryList = ['one', 'two', 'three', 'four'];
  bool isPostPressed = false;
  bool loading = false;

  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    timerequiredController.dispose();
    budgetController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(amount) async {
    var options = {
      'key': 'rzp_test_eqfjo7B0yh51Nh',
      'amount': amount,
      'name': 'Yaar Help',
      'description': 'Post a help',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
    await addGig();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
    throw Exception('Payment Failure');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  Widget categories() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 25, bottom: 5, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Choose a Category',
            style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          DropDown(
            value: category,
            hint: 'Select a category',
            itemsList: categoryList,
            onChanged: (value) {
              setState(() {
                category = value;
              });
            },
          ),
          DropDown(
            value: subCategory,
            hint: 'Select a  sub-category',
            itemsList: categoryList,
            onChanged: (value) {
              setState(() {
                subCategory = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget inputNumber(TextEditingController controller, String header,
      String hint, String errorText) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            header,
            style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: TextField(
              controller: controller,
              decoration: new InputDecoration(
                  labelText: hint,
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  errorText: controller.value == null ? errorText : null),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          )
        ],
      ),
    );
  }

  Widget stringInput(
      TextEditingController controller, String header, String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            header,
            style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Container(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<DocumentReference> addGig() {
    if (FirebaseAuth.instance.currentUser == null) {
      print('not logged in');
    } else {
      print('logged in');
    }

    return FirebaseFirestore.instance.collection('gigs').add(<String, dynamic>{
      'category': category,
      'subCategory': subCategory,
      'timeRequired': timerequiredController.text,
      'budget': budgetController.text,
      'description': descriptionController.text,
      'address': addressController.text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': FirebaseAuth.instance.currentUser.uid,
    });
  }

  bool validate() {
    if (category != null &&
        subCategory != null &&
        descriptionController.text != null &&
        addressController != null &&
        budgetController != null &&
        timerequiredController.text != null) {
      return true;
    }
    showdialogBox('Please fill all the fields before checkout', true);
    return false;
  }

  void showdialogBox(String subTitle, bool isError) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        content: Text(
          subTitle,
          style: isError
              ? TextStyle(color: Colors.red)
              : TextStyle(color: Colors.green),
        ),
        actionsPadding: EdgeInsets.all(5),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget post() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            isPostPressed = true;
          });
          if (isPostPressed && validate()) {
            try {
              await openCheckout(budgetController.text + "00");
            } catch (e) {
              print(e);
            } finally {
              setState(() {
                loading = false;
              });
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainTabs()),
                (Route<dynamic> route) => false,
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          onSurface: Colors.blue,
        ),
        child: loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
            : Text(
                'Checkout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              top(context),
              categories(),
              inputNumber(
                  timerequiredController,
                  'Service Delivery time',
                  'Enter time required to complete task',
                  'Please enter time required ih hours'),
              inputNumber(budgetController, 'What is your budget',
                  'Enter your budget in rupees', 'Please Enter your budget'),
              stringInput(
                  descriptionController, 'Add Description', 'Description'),
              stringInput(addressController, 'Add Address', 'Address'),
              post(),
            ],
          ),
        ),
      ),
    );
  }
}
