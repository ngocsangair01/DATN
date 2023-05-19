import '../values/dimens.dart';

extension SizeWidget on double {
  double get res => this * AppDimen.borderDefault;
}
