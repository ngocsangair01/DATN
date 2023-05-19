import 'package:flutter/cupertino.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';

part 'sign_up_widget.dart';

class SignUpPage extends BaseGetWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    return const Center(
      child: Text("Sign Up page"),
    );
  }
}
