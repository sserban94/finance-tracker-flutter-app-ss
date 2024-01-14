import 'package:finances_tracker_app_ss_flutter/data/money.dart';

List<money> getMoney() {
  money tazz = money();
  tazz.image = 'tazz.png';
  tazz.name = 'Tazz';
  tazz.time = 'today';
  tazz.fee = '60';
  tazz.buy = true;

  money salary = money();
  salary.image = 'salary.png';
  salary.name = 'Salary';
  salary.time = '10th of Jan';
  salary.fee = '2079';
  salary.buy = false;

  money megaImage = money();
  megaImage.image = 'mega_image.png';
  megaImage.name = 'Fanta 2L';
  megaImage.time = 'today';
  megaImage.fee = '13';
  megaImage.buy = true;

  money ciocanesti = money();
  ciocanesti.image = 'ciocanesti.jpg';
  ciocanesti.name = 'Taxa Curent';
  ciocanesti.time = '3rd of January';
  ciocanesti.fee = '100';
  ciocanesti.buy = true;

  return [tazz, megaImage, salary, ciocanesti];
}