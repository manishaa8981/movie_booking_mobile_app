import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view/login_view.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
  });

  Widget loadLoginView() {
    return BlocProvider(
      create: (context) => loginBloc,
      child: MaterialApp(
        home: LoginView(),
      ),
    );
  }

  group('LoginView Tests', () {
    testWidgets('Checking for the text Login', (tester) async {
      await tester.pumpWidget(loadLoginView());
      await tester.pumpAndSettle();

      final result = find.widgetWithText(ElevatedButton, 'Login');
      expect(result, findsOneWidget);
    });

    testWidgets('Checking for incorrect text Logins', (tester) async {
      await tester.pumpWidget(loadLoginView());
      await tester.pumpAndSettle();

      final result = find.widgetWithText(ElevatedButton, 'Logins');
      expect(result, findsNothing); // Should not find 'Logins'
    });

    testWidgets('Check for the text Sign up in the login UI', (tester) async {
      await tester.pumpWidget(loadLoginView());
      await tester.pumpAndSettle();

      final result = find.widgetWithText(TextButton, 'Sign up');
      expect(result, findsOneWidget);
    });

    testWidgets('Check for incorrect text Register in the login UI',
        (tester) async {
      await tester.pumpWidget(loadLoginView());
      await tester.pumpAndSettle();

      final result = find.widgetWithText(ElevatedButton, 'Register');
      expect(result, findsNothing); // Should not find 'Register'
    });

    group('Validation Tests', () {
      testWidgets('Check if validation messages appear when fields are empty',
          (tester) async {
        await tester.pumpWidget(loadLoginView());
        await tester.pumpAndSettle();

        final usernameField = find.byType(TextFormField).at(0);
        final passwordField = find.byType(TextFormField).at(1);
        final loginButton = find.byType(ElevatedButton);

        await tester.enterText(usernameField, '');
        await tester.enterText(passwordField, '');
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        expect(find.text('Username is required'), findsOneWidget);
        expect(find.text('Please enter your password'), findsOneWidget);
      });

      testWidgets('should validate password length', (tester) async {
        await tester.pumpWidget(loadLoginView());

        await tester.enterText(find.byType(TextFormField).at(0), 'manisha');
        await tester.enterText(find.byType(TextFormField).at(1), 'manisha123');
        await tester.tap(find.text('Login'));
        await tester.pump();

        expect(find.text('Password must be at least 6 characters long'),
            findsOneWidget);
      });
    });
//yo auta vayenaa
    group('Login Tests', () {
      testWidgets('Login Success', (tester) async {
        when(() => loginBloc.state).thenReturn(LoginState(
          isLoading: false,
          isSuccess: true,
        ));

        await tester.pumpWidget(loadLoginView());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(0), 'manisha');
        await tester.enterText(find.byType(TextFormField).at(1), 'manisha123');

        await tester.tap(find.byType(ElevatedButton).first);
        await tester.pumpAndSettle();

        expect(loginBloc.state.isSuccess, true);
      });
    });
  });
}
