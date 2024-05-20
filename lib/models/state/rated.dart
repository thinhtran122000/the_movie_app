class Rated {
  double? value;

  Rated({
    this.value,
  });

  factory Rated.fromJson(Map<String, dynamic> json) => Rated(
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
      };
}
