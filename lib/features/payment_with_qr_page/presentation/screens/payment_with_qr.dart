import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/utils/app_colors.dart';
import 'package:walaaprovider/core/utils/app_routes.dart';
import 'package:walaaprovider/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:walaaprovider/features/payment_with_qr_page/presentation/cubit/payment_cubit.dart';

class PaymentWithQrPage extends StatefulWidget {
  PaymentWithQrPage({Key? key, required this.orderModel}) : super(key: key);
  final OrderModel orderModel;

  @override
  State<PaymentWithQrPage> createState() => _PaymentWithQrPageState();
}

class _PaymentWithQrPageState extends State<PaymentWithQrPage> {
  String _scanBarcode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.only(right: 16, left: 16),
            icon: Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.primary,
              size: 35,
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text(
            'Payment with QR'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Card(
              color: AppColors.primary,
              elevation: 3,
              child: Container(
                width: 250,
                height: 250,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsetsDirectional.all(8),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.qrRoute );
                              scanQR();
                            },
                            child: Image.asset(
                              ImageAssets.qrImage,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Scan and pay'.tr(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.color1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print("sss${barcodeScanRes}");
      context.read<PaymentCubit>().confirmOrder(widget.orderModel, barcodeScanRes,context);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }
}
