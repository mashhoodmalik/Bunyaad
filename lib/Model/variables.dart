import 'package:bunyaad/Model/buyer.dart';
import 'package:bunyaad/Model/seller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Variables{
  static FirebaseAuth? auth;

  static Buyer? buyer;
  static bool isSeller= false;

  static Seller? seller;
}
