import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view/sign_up_view.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/signup/register_bloc.dart';

class MockRegisterBloc extends Mock implements RegisterBloc {}

void main() {
  late RegisterBloc registerBloc;

  Widget loadSignUpView() {
    return BlocProvider<RegisterBloc>(
      create: (context) => registerBloc,
      child: const MaterialApp(home: SignUpView()),
    );
  }

  setUp(() {
    registerBloc = MockRegisterBloc();
    when(() => registerBloc.state).thenReturn(RegisterState.initial());
  });

  group('SignUpView UI Tests', () {
    testWidgets('Checking for the text Sign up', (tester) async {
      await tester.pumpWidget(loadSignUpView());

      await tester.pumpAndSettle();

      //final button by text
      final result = find.widgetWithText(ElevatedButton, 'Sign Up');

      expect(result, findsOneWidget);
    });

    testWidgets('Checking for the text Login ', (tester) async {
      await tester.pumpWidget(loadSignUpView());

      await tester.pumpAndSettle();

      //final button by text
      final result = find.widgetWithText(TextButton, 'Login');

      expect(result, findsOneWidget);
    });

    testWidgets('Should display validation errors when fields are empty',
        (tester) async {
      await tester.pumpWidget(loadSignUpView());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Username is required'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Phone number is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('Should validate email format', (tester) async {
      await tester.pumpWidget(loadSignUpView());

      await tester.enterText(find.byType(TextFormField).at(1), 'invalid_email');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Enter a valid email address'), findsOneWidget);
    });

    testWidgets('Should validate phone number format', (tester) async {
      await tester.pumpWidget(loadSignUpView());

      await tester.enterText(find.byType(TextFormField).at(2), '982305891');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Enter a valid 10-digit phone number'), findsOneWidget);
    });

    testWidgets('Should validate password length', (tester) async {
      await tester.pumpWidget(loadSignUpView());

      await tester.enterText(find.byType(TextFormField).at(3), '123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Password must be at least 6 characters long'),
          findsOneWidget);
    });
  });

  group('SignUpView Interaction Tests', () {
    //vayena
    testWidgets('Should enter values correctly in text fields', (tester) async {
      await tester.pumpWidget(loadSignUpView());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'manisha');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'manisha@gmail.com');
      await tester.enterText(find.byType(TextFormField).at(2), '9823058912');
      await tester.enterText(find.byType(TextFormField).at(3), 'manisha123');

      expect(find.text('manisha'), findsOneWidget);
      expect(find.text('manisha@gmail.com'), findsOneWidget);
      expect(find.text('9823058912'), findsOneWidget);
      expect(find.text('manisha123'), findsOneWidget);
    });

    testWidgets('Should toggle password visibility', (tester) async {
      await tester.pumpWidget(loadSignUpView());

      final visibilityIcon = find.byIcon(Icons.visibility_off);
      await tester.tap(visibilityIcon);
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
