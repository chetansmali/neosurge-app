class DeleteDeliveryAddressParams {
  final int id;

  DeleteDeliveryAddressParams(this.id);

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
