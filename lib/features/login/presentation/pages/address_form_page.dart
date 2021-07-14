import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cutso/features/login/presentation/widgets/cutso_header_widget.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/user_actions_provider.dart';
import '../../../../core/router/router.gr.dart';
import '../../../../core/theme/theme_data.dart';
import '../../data/models/user.dart';
import '../../data/sources/user_auth_repository.dart';
import '../provider/address_form_provider.dart';
import '../provider/mobile_otp_form_provider.dart';
import '../provider/registration_form_provider.dart';

class AddressFormPage extends ConsumerWidget {
  final bool asUpdate;
  AddressFormPage({@PathParam('asUpdate') required this.asUpdate});

  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      backgroundColor: kCream,
      body: SingleChildScrollView(
        child: Form(
          key: _addressFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CutsoHeader(),
              SizedBox(height: 8.h),
              Text(
                "Address",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.00, right: 12.00, top: 12.00),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: 'Name',
                  ),
                  initialValue: watch(addressFormProvider).name,
                  autocorrect: false,
                  onChanged: (name) =>
                      context.read(addressFormProvider).name = name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.00, right: 12.00, top: 12.00),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: 'Line',
                  ),
                  autocorrect: false,
                  initialValue: watch(addressFormProvider).line,
                  onChanged: (address) =>
                      context.read(addressFormProvider).line = address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address line';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.00, right: 12.00, top: 12.00),
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                    labelText: 'Landmark',
                  ),
                  initialValue: watch(addressFormProvider).landmark,
                  autocorrect: false,
                  onChanged: (landmark) =>
                      context.read(addressFormProvider).landmark = landmark,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some landmark';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 2.h),
              ArgonButton(
                  height: 10.w,
                  width: 64.w,
                  color: kOrange,
                  borderRadius: 5.w,
                  loader: Container(
                    padding: const EdgeInsets.all(10),
                    child: const SpinKitRotatingCircle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (btnState == ButtonState.Idle) {
                      startLoading();
                      await watch(addressFormProvider).getLocation();
                      stopLoading();
                    }
                  },
                  child: watch(addressFormProvider).hasGotLocation
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle_rounded),
                            SizedBox(width: 7.w),
                            Text(
                              "LOCATION SET",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.gps_fixed_rounded),
                            SizedBox(width: 7.w),
                            Text(
                              "GET LOCATION",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        )),
              SizedBox(height: 2.h),
              ArgonButton(
                height: 10.w,
                width: 36.w,
                color: kOrange,
                borderRadius: 5.w,
                loader: Container(
                  padding: const EdgeInsets.all(10),
                  child: const SpinKitRotatingCircle(
                    color: Colors.white,
                  ),
                ),
                onTap: (startLoading, stopLoading, btnState) async {
                  if (btnState == ButtonState.Idle &&
                      _addressFormKey.currentState!.validate()) {
                    startLoading();
                    if (asUpdate) {
                      watch(userActionsProvider).updateAddress(
                        watch(addressFormProvider).getAddress(),
                      );
                      stopLoading();
                      await context.router.pop();
                    } else {
                      final dz.Either<AuthFailure, void> userRunner =
                          await watch(userAuthRepositoryProvider).registerUser(
                        User(
                          uid: watch(mobileFormProvider).uid,
                          fullName: watch(registrationFormProvider).name!,
                          phone: watch(mobileFormProvider).mobileNo,
                          email: watch(registrationFormProvider).email!,
                          address: watch(addressFormProvider).getAddress(),
                          orders: MyOrders(orderIds: []),
                          cart: Cart(orderItems: []),
                        ),
                      );
                      stopLoading();
                      userRunner.fold(
                        (failure) {
                          watch(crashlyticsProvider)
                              .log(failure.messsage.toString());
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message:
                                  "Unable to register the user, please try again later",
                            ),
                          );
                        },
                        (_) async {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.success(
                              message: "User registration successfull !",
                            ),
                          );
                          await context.router.navigate(const HomeRoute());
                        },
                      );
                    }
                  }
                },
                child: Text(
                  asUpdate ? "UPDATE" : "SUBMIT",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
