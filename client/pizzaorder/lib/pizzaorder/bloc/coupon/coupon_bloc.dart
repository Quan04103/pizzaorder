import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/coupon_service.dart'; 
import 'coupon_event.dart';
import 'coupon_state.dart';
import '../../models/coupon.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponService couponService = CouponService();

  CouponBloc() : super(CouponState.initial()) {
    on<LoadCoupon>((event, emit) async {
      try {
        List<CouponModel> coupons = await couponService.getAllCoupons();
        emit(CouponState.loaded(coupons));
        print('New state: loaded');
      } catch (e) {
        emit(CouponState.error(e.toString()));
        print('New state: error - ${e.toString()}');
      }
    });

  on<ApplyCoupon>((event, emit) async {
  try {
    CouponModel coupon = event.coupon;
    await couponService.updateUsageCount(coupon.id!);
    if (coupon.usageCount! <= 1) {
      await couponService.deleteCoupon(coupon.id!);
    }
    
    emit(CouponState.loaded([coupon]));
    
    print('New state: applyCouponSuccess');
  } catch (e) {
    emit(CouponState.error(e.toString()));
    print('New state: error - ${e.toString()}');
  }
  });
on<ClearCoupon>((event, emit) async {
  try {
    emit(CouponState.loaded([])); // Emit một CouponState rỗng để xóa dữ liệu tạm thời
    print('Temporary data cleared');
  } catch (e) {
    emit(CouponState.error(e.toString()));
    print('Error clearing temporary data: ${e.toString()}');
  }
});
  }
}
