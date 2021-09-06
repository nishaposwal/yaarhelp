import 'package:yaarhelp/pages/loginPage.dart';
import 'package:yaarhelp/pages/profile/profile.dart';
import 'package:intl/intl.dart';
import 'package:yaarhelp/pages/dropDown.dart';
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
                          fontSize: 24,
                          fontFamily: 'Rowdies'),
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
                image: AssetImage('assets/images/fashion.png'),
                height: 60,
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
  final titleController = new TextEditingController();
  final addressController = new TextEditingController();
  final categoryList = [
    'Online Help',
    'Offline Help',
    'Learn English',
    'Volunteering'
  ];
  Map<String, List<String>> subCategoryList = {
    'Online Help': [
      "Assignment Help",
      "Social Media Help",
      "Art & Design Help",
      'Presentations Help',
      'Programming Help',
      'Question solving Help',
      'Writing Help',
      'Tech Help',
      'Content research Help',
      'Other Help',
    ],
    'Offline Help': [
      'Personal Assistant Help',
      'Organize/Decor Help',
      'Health/Therapy Help',
      'Technical Help',
      'Drop-ship/Moving Help',
      'Baby/Pet Care Help',
      'Cafe/Hotel',
      'Repairing Help',
      'House Help',
      'Other Help'
    ],
    'Volunteering': [
      'Donate Blood',
      'Clean Your City',
      'Feed poor',
      'Educate underprivileged'
    ],
  };
  bool isPostPressed = false;
  bool loading = false;

  // static const platform = const MethodChannel("razorpay_flutter");

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
                subCategory = null;
              });
            },
          ),
          category != null && subCategoryList[category].length != 0
              ? DropDown(
                  value: subCategory,
                  hint: 'Select a sub-category',
                  itemsList: subCategoryList[category],
                  onChanged: (value) {
                    setState(() {
                      subCategory = value;
                    });
                  },
                )
              : SizedBox(
                  height: 1,
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
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
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

  void openCheckout(amount) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var uid = currentUser.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        if (value.data() != null) {
          var options = {
            'key': 'rzp_live_BvYohqnLVXKdY1',
            'amount': amount,
            'name': 'Yaar Help',
            'description': 'Post a help',
            'prefill': {
              'contact': value.data()['phoneNumber'],
              'email': currentUser.email
            },
          };
          try {
            _razorpay.open(options);
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      });
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      await addGig();
      Fluttertoast.showToast(
          msg: "Help Posted Successfully!",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.green);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            uid: FirebaseAuth.instance.currentUser.uid,
            index: 1,
          ),
        ),
      );
    } catch (e) {
      showdialogBox(e, true);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: " + response.code.toString() + " - " + response.message);
    var error = "";
    var code = response.code.toString();
    switch (code) {
      case "0":
        error = "There was a network error. Payment was Unsuccessful.";
        break;
      case "1":
        error =
            "An issue with data passed to Razorpay. Payment was Unsuccessful.";
        break;
      case "2":
        error = "Payment Cancelled. Please complete the payment to checkout.";
        break;
      case "3":
        error =
            "Unsupported device. Please try to create a post from some other device.";
        break;
      case "4":
        error = "An unknown error occurred. Payment was Unsuccessful.";
        break;
      default:
        error = "Payment Failure.";
        break;
    }
    showdialogBox(error, true);
    throw Exception('Payment Failure');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_LONG);
  }

  Future<DocumentReference> addGig() {
    if (FirebaseAuth.instance.currentUser == null) {
      print('not logged in');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return null;
    }
    final now = new DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);

    return FirebaseFirestore.instance.collection('gigs').add(<String, dynamic>{
      'category': category,
      'subCategory': subCategory,
      'timeRequired': timerequiredController.text,
      'budget': budgetController.text,
      'description': descriptionController.text,
      'title': titleController.text,
      'address': addressController.text,
      'postedOn': formatter,
      'timeStamp': new DateTime.now().microsecondsSinceEpoch,
      'userId': FirebaseAuth.instance.currentUser.uid,
      'userName': FirebaseAuth.instance.currentUser.displayName,
      'userImageUrl': FirebaseAuth.instance.currentUser.photoURL,
      'helper': null
    });
  }

  bool validate() {
    if (category != null &&
        (subCategory != null || category == "Learn English") &&
        descriptionController.text != "" &&
        addressController.text != "" &&
        budgetController.text != "" &&
        timerequiredController.text != "" &&
        descriptionController.text != null &&
        addressController.text != null &&
        budgetController.text != null &&
        timerequiredController.text != null) {
      return true;
    }
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
          if (FirebaseAuth.instance.currentUser == null) {
            print('not logged in');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
            return null;
          }
          if (validate()) {
            try {
              await openCheckout(budgetController.text + "00");
              // await addGig();
            } catch (e) {
              print(e);
            } finally {
              setState(() {
                loading = false;
              });
            }
          } else {
            showdialogBox('Please fill all fields before checkout', true);
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
              stringInput(titleController, 'Add Title', 'Title'),
              stringInput(
                  descriptionController, 'Add Description', 'Description'),
              stringInput(timerequiredController, 'Service Delivery time',
                  'Enter time required to complete task'),
              inputNumber(budgetController, 'What is your budget ( ₹ )',
                  'Enter your budget in rupees', 'Please Enter your budget'),
              stringInput(addressController, 'Add Address', 'Address'),
              post(),
            ],
          ),
        ),
      ),
    );
  }
}
