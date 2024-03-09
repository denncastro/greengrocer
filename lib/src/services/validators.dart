import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email!.isEmpty) {
    return "Digite o seu email";
  }

  if (!email.isEmail) {
    return "Digite um email válido";
  }
  return null;
}

String? nameValidator(String? name) {
  if (name!.isEmpty) {
    return "Digite o seu nome";
  }

  final names = name.split("");

  if (names.length == 1) {
    return "Digite o seu nome completo";
  }

  return null;
}

String? passwordValidator(String? password) {
  if (password!.isEmpty) {
    return "Digite a sua password";
  }

  if (password.length < 7) {
    return "Digite uma password no minimo com 7 carateres";
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf!.isEmpty) {
    return "Digite o seu cpf";
  }

  if (!cpf.isCpf) {
    return "Digite um cpf válido";
  }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone!.isEmpty) {
    return "Digite o seu telefone";
  }

  if (phone.length < 14 || !phone.isPhoneNumber) {
    return "Digite um número de telefone válido";
  }
  return null;
}
