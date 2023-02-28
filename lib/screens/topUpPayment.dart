import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/resources/midtransApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:intl/intl.dart';

class TopUpPayment extends StatefulWidget {
  final Map<String, dynamic> data;
  const TopUpPayment({super.key, required this.data});

  @override
  State<TopUpPayment> createState() => _TopUpPaymentState();
}

class _TopUpPaymentState extends State<TopUpPayment> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.data.toString());
  }

  @override
  void didUpdateWidget(covariant TopUpPayment oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double numValue = double.parse(widget.data["data"]["gross_amount"]);
    NumberFormat currencyFormatter = NumberFormat.simpleCurrency(
        locale: "id", decimalDigits: 0, name: "Rp. ");
    String bank = "Permata";
    String expiry_date = "";
    Map<String, dynamic> payloadData = widget.data["data"];
    if (widget.data["data"]["payment_type"] == "echannel") {
      bank = "Mandiri";
      expiry_date = widget.data["data"]["expiry_time"];
    } else if (widget.data["data"]["payment_type"] == "bank_transfer" &&
        payloadData.containsKey("permata_va_number")) {
      bank = "Permata";
      DateTime time = DateTime.parse(widget.data["data"]["transaction_time"]);
      DateTime expired_date = time.add(Duration(days: 1));
      expiry_date = DateFormat("yyyy-MM-dd HH:mm:ss").format(expired_date);
    } else if (widget.data["data"]["payment_type"] == "bank_transfer" &&
        widget.data["data"]["va_numbers"][0]['bank'] == "bni") {
      bank = "BNI";
      expiry_date = widget.data["data"]["expiry_time"];
    } else if (widget.data["data"]["payment_type"] == "bank_transfer" &&
        widget.data["data"]["va_numbers"][0]['bank'] == "bri") {
      bank = "BRI";
      expiry_date = widget.data["data"]["expiry_time"];
    } else if (widget.data["data"]["payment_type"] == "bank_transfer" &&
        widget.data["data"]["va_numbers"][0]['bank'] == "bca") {
      bank = "BCA";
      expiry_date = widget.data["data"]["expiry_time"];
    }
    String newGrossAmount = currencyFormatter.format(numValue);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Top Up Payment Nunut",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: nunutPrimaryColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NunutText(title: "Total"),
                      NunutText(
                        title: "Pay before: " + expiry_date,
                        size: 12,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      NunutText(
                        title: newGrossAmount,
                        size: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      NunutText(
                        title: "Order ID #" +
                            widget.data["data"]["transaction_id"],
                        size: 10,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            NunutText(
              title: "Bank " + bank,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            NunutText(
              title:
                  "Complete payment from ${bank} to the virtual account number below.",
              size: 18,
            ),
            SizedBox(height: 40),
            Container(
              child: bank == "Mandiri"
                  ? mandiriPayment()
                  : (bank == "Permata" ? permataPayment() : bankPayment()),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: NunutButton(
                  title: "Done",
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              color: nunutPrimaryColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 25.0),
                                    child: CircularProgressIndicator(
                                      value: null,
                                      strokeWidth: 5.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        NunutText(
                                            title: "Loading...",
                                            color: Colors.white,
                                            size: 20,
                                            fontWeight: FontWeight.w500),
                                        NunutText(
                                            title: "Mohon Tunggu",
                                            color: Colors.white,
                                            size: 20,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    setState(() {
                      _isLoading = true;
                    });
                    var res = await MidtransApi.getTransaction(
                        widget.data["data"]["order_id"]);

                    if (res != null) {
                      setState(() {
                        _isLoading = false;
                      });
                      if (res["status"] == 500 || res["status"] == 400) {
                        Fluttertoast.showToast(
                            msg:
                                "Gagal memuat data transaksi, silahkan coba lagi",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        return;
                      }
                      if (res["data"]["status"] == "settlement") {
                        Fluttertoast.showToast(
                            msg:
                                "Transaksi berhasil, mohon tunggu beberapa saat",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.popUntil(
                            context, ModalRoute.withName('/nunutPay'));
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/nunutPay');
                      } else {
                        Fluttertoast.showToast(
                            msg: "Transaksi gagal, silahkan coba lagi",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.popUntil(
                            context, ModalRoute.withName('/nunutPay'));
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/nunutPay');
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mandiriPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NunutText(
          title: "Company Code",
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            NunutText(
              title: widget.data["data"]["biller_code"],
              size: 18,
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(new ClipboardData(
                    text: widget.data["data"]["biller_code"]));
                Fluttertoast.showToast(
                    msg: "Disalin ke clipboard",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Text(
                "Copy",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        NunutText(
          title: "Virtual Account Number",
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            NunutText(
              title: widget.data["data"]["bill_key"],
              size: 18,
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(
                    new ClipboardData(text: widget.data["data"]["bill_key"]));
                Fluttertoast.showToast(
                    msg: "Disalin ke clipboard",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Text(
                "Copy",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget permataPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NunutText(
          title: "Virtual Account Number",
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            NunutText(
              title: widget.data["data"]["permata_va_number"],
              size: 18,
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(new ClipboardData(
                    text: widget.data["data"]["permata_va_number"]));
                Fluttertoast.showToast(
                    msg: "Disalin ke clipboard",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Text(
                "Copy",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bankPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NunutText(
          title: "Virtual Account Number",
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            NunutText(
              title: widget.data["data"]["va_numbers"][0]["va_number"],
              size: 18,
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(new ClipboardData(
                    text: widget.data["data"]["va_numbers"][0]["va_number"]));
                Fluttertoast.showToast(
                    msg: "Disalin ke clipboard",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Text(
                "Copy",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
