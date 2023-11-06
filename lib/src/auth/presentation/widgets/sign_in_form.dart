import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:tunceducationn/core/common/widgets/changeable_field.dart';

class SignInForm extends StatefulWidget {
  // Giriş formunu temsil eden sınıf

  const SignInForm({
    required this.emailController, // E-posta denetleyici
    required this.passwordController, // Şifre denetleyici
    required this.formKey, // Form anahtarı
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // Giriş formunun durum sınıfı

  bool obscurePassword = true; // Şifreyi gizleme durumu

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey, // Form anahtarını kullanarak Form'u tanımla
      child: Column(
        children: [
          ChangeableField(
            controller: widget.emailController, // E-posta denetleyicisi
            hintText: 'Email Address', // İpucu metni
            keyboardType: TextInputType.emailAddress, // Klavye türü
          ),
          const SizedBox(height: 25), // Boşluk ekleyin
          ChangeableField(
            controller: widget.passwordController, // Şifre denetleyicisi
            hintText: 'Password', // İpucu metni
            obscureText: obscurePassword, // Şifreyi gizleme özelliği
            keyboardType: TextInputType.visiblePassword, // Klavye türü
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword =
                        !obscurePassword; // Şifreyi gizleme durumunu tersine çevir
                  });
                },
                icon: Icon(
                  obscurePassword
                      ? IconlyLight.show
                      : IconlyLight.hide, // Göster veya gizle simgesi
                  color: Colors.grey, // Simgenin rengi
                )),
          ),
        ],
      ),
    );
  }
}
