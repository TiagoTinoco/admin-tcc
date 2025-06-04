enum TextButtonKindEnum {
  small,
  large;

  double? get width {
    switch (this) {
      case TextButtonKindEnum.small:
        return null;
      case TextButtonKindEnum.large:
        return double.infinity;
    }
  }
}
