

import '../../models/coupon.dart';

abstract class CouponEvent {
  const CouponEvent();
   @override
  List<Object> get props => [];
}

class LoadCoupon extends CouponEvent {}

class ApplyCoupon extends CouponEvent {
  final CouponModel  coupon;
  ApplyCoupon(this.coupon);
}

class UpdateUsageCount extends CouponEvent {
  final String couponId;
  UpdateUsageCount(this.couponId);
}
class ApplySelectedCoupon extends CouponEvent {
  final CouponModel selectedCoupon;

  ApplySelectedCoupon(this.selectedCoupon);
}
class DeleteCoupon extends CouponEvent {
  final CouponModel coupon;

  DeleteCoupon(this.coupon);

  @override
  List<Object> get props => [coupon];
}
class ClearCoupon extends CouponEvent {}
