String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Você deve preencher com seu e-mail';
  }

  if (!email.contains('@') || !email.contains('.com')) {
    return 'Digite um e-mail válido';
  }

  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'O campo da senha não pode estar vázia';
  }

  if (password.length <= 5) {
    return 'Sua senha deve conter 6 números';
  }

  return null;
}

String? nameValidator(String? fullname) {
  if (fullname == null || fullname.isEmpty) {
    return 'O campo do nome não pode estar vázio';
  }

  final name = fullname.split(' ');

  if (name.length == 1) {
    return 'Digite seu nome completo';
  }

  return null;
}
