import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


class _UnknownContact with OnTapMixin {
  const _UnknownContact();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('connect', () {
    group('onTapMixin', () {
      final ok = isA<Future<void>>();

      test('should assert other than Contact', () {
        expect(() =>  const _UnknownContact().onTap(), throwsA(isA<AssertionError>()));
      });

      test('on PhoneContact', () {
        expect(const PhoneContact(phoneNumber: "0101").onTap(), ok);
      });

      test('on Email', () {
        expect(const Email(email: "").onTap(), ok);
      });

      test('on LinkedIn', () {
        expect(const LinkedIn(username: "").onTap(), ok);
      });

      test('on Telegram', () {
        expect(const Telegram(username: "").onTap(), ok);
      });

      test('on Website', () {
        expect(const Website(url: "").onTap(), ok);
      });

      ///**Developer medium */
      test('on StackOverflow', () {
        expect(const StackOverflow(id: "").onTap(), ok);
      });

      test('on GitHub', () {
        expect(const GitHub(userId: "").onTap(), ok);
      });

      test('on HackerRank', () {
        expect(const HackerRank(username: "").onTap(), ok);
      });

      test('on LeetCode', () {
        expect(const LeetCode(username: "").onTap(), ok);
      });

      test('on Other', () {
        expect(const OtherSite(name: "", url: "", data: "").onTap(), ok);
      });
    });
  });
}
