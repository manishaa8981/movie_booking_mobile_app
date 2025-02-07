import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view/login_view.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/features/home/presentation/view_model/home_cubit.dart';

class MockLoginBloc extends Mock implements LoginBloc {}
class MockRegisterBloc extends Mock implements RegisterBloc {}
class MockHomeCubit extends Mock implements HomeCubit {}

void main() {
  late MockLoginBloc mockLoginBloc;
  late MockRegisterBloc mockRegisterBloc;
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    mockRegisterBloc = MockRegisterBloc();
    mockHomeCubit = MockHomeCubit();
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>.value(value: mockLoginBloc),
        BlocProvider<RegisterBloc>.value(value: mockRegisterBloc),
        BlocProvider<HomeCubit>.value(value: mockHomeCubit),
      ],
      child: const MaterialApp(
        home: LoginView(),
      ),
    );
  }

  testWidgets('should render LoginView with input fields and button', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Hello, Welcome Back! 👋'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('should validate empty username and password', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Username is required'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('should validate password length', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Password must be at least 6 characters long'), findsOneWidget);
  });

  testWidgets('should call LoginBloc when form is valid', (tester) async {
    when(() => mockLoginBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextFormField).at(0), 'validuser');
    await tester.enterText(find.byType(TextFormField).at(1), 'validpassword');
    await tester.tap(find.text('Login'));
    await tester.pump();

    verify(() => mockLoginBloc.add(any())).called(1);
  });

  testWidgets('should navigate to sign-up when clicking sign-up button', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byKey(const ValueKey('registerButton')));
    await tester.pumpAndSettle();

    verify(() => mockLoginBloc.add(any())).called(1);
  });
}