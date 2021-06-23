import 'package:flutter/material.dart';

class DetailBottomContent extends StatelessWidget {
  DetailBottomContent(this.selectedObj, this.isDiabetics);
  final selectedObj;
  final bool isDiabetics;

  static const String _hd_advice_danger =
      '\t\t\tYurak kasalligi atamasi bir qator yurak-qon tomir kasalliklarini, shu jumladan qon tomirlari kasalliklari, yurak tomirlari kasalliklari, yurak aritmi, tug\'ma yurak nuqsonlari va yurak infektsiyalarini o\'z ichiga olgan kollektiv atama. Yurak kasalligi jiddiy holat bo\'lsa-da, siz sog\'lom ovqatlanish, faollikni saqlash, stressni yengish va chekishni tashlash orqali yurak kasalliklari xavfini kamaytirish uchun bir nechta oddiy choralarni ko\'rishingiz mumkin. Agar siz yurak kasalligi yoki yuqori qon bosimi, yuqori xolesterin yoki diabet kasalligi xavfi bor deb o\'ylasangiz, darhol shifokoringizga murojaat qiling.';
  static const String _hd_advice_safe =
      '\t\t\tXavotirga o\'rin yo\'q, lekin, doimiy sog\'lom turmush tarziga rioya qilib, to\'g\'ri ovqatlanishni, faollikni saqlashni, spirtli ichimliklarni va chekishni tashlashni unutmang! Shu bilan birga shifikor ko\'rigiga borib turing.';

  static const String _dia_advice_danger =
      '\t\t\tQandli diabetda nima sodir bo\'ladi? Tanada insulin kam miqdorda ishlab chiqariladi, qonda glyukoza miqdori yuqori bo\'ladi, lekin shunga qaramay hujayralarga glyukoza yetishmasligi boshlanadi. Doimiy nazorat ostida bo\'lgan va shifokor tavsiyalariga amal qilingan holda kasallik asoratlarini oldini olish yoki butunlay cheklash mumkin. Zero kasallikni o\'zi emas, asoratlari xavfli hisoblanadi.';
  static const String _dia_advice_safe =
      '\t\t\tHammasi joyida. Qandli diabetning oldini olish uchun tana vazningizni normallashtiring, qon bosimi va yog\'lar almashinuvini nazorat qiling, yengil hazm bo\'ladigan ovqat iste\'mol qiling, jismoniy faollika amal qiling va shu bilan birga haddan ziyod zo\'riqishlardan o\'zingizni tiying!';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            const Text(
              'Maslahat',
              style: TextStyle(fontSize: 24),
            ),
            isDiabetics
                ? Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: selectedObj.predict >= 50.0
                        ? const Text(
                            _dia_advice_danger,
                            style: TextStyle(fontSize: 18, fontFamily: 'KoHo'),
                            // textAlign: TextAlign.justify,
                          )
                        : const Text(
                            _dia_advice_safe,
                            style: TextStyle(fontSize: 18, fontFamily: 'KoHo'),
                            // textAlign: TextAlign.justify,
                          ),
                  )
                : Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: selectedObj.predict >= 50.0
                        ? const Text(
                            _hd_advice_danger,
                            style: TextStyle(fontSize: 18, fontFamily: 'KoHo'),
                            // textAlign: TextAlign.justify,
                          )
                        : const Text(
                            _hd_advice_safe,
                            style: TextStyle(fontSize: 18, fontFamily: 'KoHo'),
                            // textAlign: TextAlign.justify,
                          ),
                  ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
