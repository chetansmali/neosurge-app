import 'package:json_annotation/json_annotation.dart';

part 'mutual_fund_cart.g.dart';

@JsonSerializable()
class MutualFundCart {
  final String purchaseType;
  final double cartValue;
  @JsonKey(name: 'cartItems')
  final List<CartMutualFund> cartMutualFunds;

  MutualFundCart({
    required this.purchaseType,
    required this.cartValue,
    required this.cartMutualFunds,
  });

  factory MutualFundCart.fromJson(Map<String, dynamic> json) =>
      _$MutualFundCartFromJson(json);

  Map<String, dynamic> toJson() => _$MutualFundCartToJson(this);

  MutualFundCart copyWith({
    String? purchaseType,
    double? cartValue,
    List<CartMutualFund>? cartMutualFunds,
  }) {
    return MutualFundCart(
      purchaseType: purchaseType ?? this.purchaseType,
      cartValue: cartValue ?? this.cartValue,
      cartMutualFunds: cartMutualFunds ?? this.cartMutualFunds,
    );
  }
}

@JsonSerializable()
class CartMutualFund {
  final String schemeName;
  final double purchaseAmount;
  final String schemeLogo;
  final int? installments;
  final String? invDate;
  final String? folioNumber;

  @JsonKey(name: 'cartID')
  final int cartId;

  CartMutualFund({
    required this.schemeName,
    required this.purchaseAmount,
    this.installments,
    this.invDate,
    required this.schemeLogo,
    required this.cartId,
    this.folioNumber,
  });

  factory CartMutualFund.fromJson(Map<String, dynamic> json) =>
      _$CartMutualFundFromJson(json);

  Map<String, dynamic> toJson() => _$CartMutualFundToJson(this);
}
