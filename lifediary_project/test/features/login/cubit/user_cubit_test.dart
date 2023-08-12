import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/cubit/root_state.dart';
import 'package:lifediary_project/app/domain/repositories/root_repository.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockRootRepository extends Mock implements RootRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late MockRootRepository mockRootRepository;
  late RootCubit sut;
  late TextEditingController email;
  late TextEditingController password;
  late User user;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockRootRepository = MockRootRepository();
    sut = RootCubit(mockUserRepository, mockRootRepository);
    email = TextEditingController();
    password = TextEditingController();
    // user = User();
  });

  // group('createAccount', () {
  //   blocTest<RootCubit, RootState>('emit Status.loading then Status.error when user is null',
  //       build: () => sut,
  //       act: (cubit) => cubit.createAccount(email, password),
  //       expect: () => [
          
  //             RootState(status: Status.loading),
  //         RootState(user: null, status: Status.error),
  //       ]);
  // });

//   group('start', () {
//   // final user = User();

//   group('success', () {
//     setUp(() {
//       final streamController = StreamController<User>();
//       streamController.add(user);

//       when(() => mockRootRepository.authStateChanges())
//           .thenAnswer((_) => streamController.stream);
//     });

//     blocTest<RootCubit, RootState>(
//       'emits Status.loading then Status.success with user',
//       build: () => sut,
//       act: (cubit) => cubit.start(),
//       expect: () => [
//         RootState(
//           user: null,
//           status: Status.loading,
          
//         ),
//         RootState(
//           user: user, 
//           status: Status.success,
          
//         ),
//       ],
//     );
//   });
// });


//     group('failure', () {
//       setUp(() {
//         when(() => repository.getDailyPlansStream())
//             .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
//       });
//       blocTest<DailyPlanCubit, DailyPlanState>(
//         'emits Status.loading then Status.error with errorMessage',
//         build: () => sut,
//         act: (cubit) => cubit.start(),
//         expect: () => [
//           DailyPlanState(
//             status: Status.loading,
//           ),
//           DailyPlanState(
//             errorMessage: 'Exception: test-exception-error',
//             status: Status.error,
//           ),
//         ],
//       );
//     });
//   });

}
