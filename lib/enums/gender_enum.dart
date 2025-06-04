enum GenderEnum {
  male,
  female,
  others;

  String get label {
    switch (this) {
      case GenderEnum.male:
        return 'Masculino';
      case GenderEnum.female:
        return 'Feminino';
      case GenderEnum.others:
        return 'Outros';
    }
  }
}
