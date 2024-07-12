import 'package:pizzaorder/pizzaorder/models/coupon.dart';

class CouponState {
  final bool isLoading;
  final bool isLoaded;
  final bool isError;
  final bool applyCoupon;
  final bool clearCoupon;
  final List<CouponModel>? coupons;
  final CouponModel? selectedCoupon; // Thêm trường cho coupon được chọn

  CouponState({
    required this.isLoading,
    required this.isLoaded,
    required this.isError,
    required this.clearCoupon,
    this.coupons,
    required this.applyCoupon,
    this.selectedCoupon,
  });

  factory CouponState.initial() {
    return CouponState(
      isLoading: false,
      isLoaded: false,
      isError: false,
      applyCoupon: false,
      clearCoupon: false,
    );
  }

  factory CouponState.applyCoupon(List<CouponModel>? coupons) {
    return CouponState(
      isLoading: false,
      isLoaded: false,
      isError: false,
      applyCoupon: true,
      coupons: coupons,
      clearCoupon: false,
    );
  }

  factory CouponState.error(String error) {
    return CouponState(
      isLoading: false,
      isLoaded: false,
      isError: true,
      clearCoupon: false,
      applyCoupon: false,
    );
  }

  factory CouponState.loaded(List<CouponModel> coupons) {
    return CouponState(
      isLoading: false,
      isLoaded: true,
      isError: false,
      clearCoupon: false,
      applyCoupon: false,
      coupons: coupons,
    );
  }

  factory CouponState.reload(List<CouponModel> coupons) {
    return CouponState(
      isLoading: false,
      isLoaded: true,
      isError: false,
      clearCoupon: false,
      applyCoupon: false,
      coupons: coupons,
    );

  }
    factory CouponState.clear(List<CouponModel> coupons) {
    return CouponState(
      isLoading: false,
      isLoaded: true,
      isError: false,
      clearCoupon: true,
      applyCoupon: false,
      coupons: coupons,
    );}
  factory CouponState.selected(CouponModel selectedCoupon) {
    return CouponState(
      isLoading: false,
      clearCoupon: false,
      isLoaded: false,
      isError: false,
      applyCoupon: false,
      selectedCoupon: selectedCoupon,
    );
  }
  bool isCouponSelected(CouponModel coupon) {
    return selectedCoupon != null && selectedCoupon!.id == coupon.id;
  }
  @override
  List<Object?> get props => [isLoading, isLoaded, isError, coupons, applyCoupon, selectedCoupon];

  @override
  String toString() {
    return 'CouponState: isLoading: $isLoading, isLoaded: $isLoaded, isError: $isError, applyCoupon: $applyCoupon, selectedCoupon: $selectedCoupon, coupons: $coupons';
  }
}
