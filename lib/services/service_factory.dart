import "package:cloud_firestore/cloud_firestore.dart";
import "package:cloud_functions/cloud_functions.dart";
import "package:com_nicodevelop_taskmator/models/ready_start_model.dart";
import "package:com_nicodevelop_taskmator/repositories/account_repository.dart";
import "package:com_nicodevelop_taskmator/repositories/authentication_repository.dart";
import "package:com_nicodevelop_taskmator/repositories/task_repository.dart";
import "package:com_nicodevelop_taskmator/repositories/upload_repository.dart";
import "package:com_nicodevelop_taskmator/services/add_task/add_task_bloc.dart";
import "package:com_nicodevelop_taskmator/services/authentication_status/authentication_status_bloc.dart";
import "package:com_nicodevelop_taskmator/services/bootstrap/bootstrap_bloc.dart";
import "package:com_nicodevelop_taskmator/services/create_account/create_account_bloc.dart";
import "package:com_nicodevelop_taskmator/services/delete_account/delete_account_bloc.dart";
import "package:com_nicodevelop_taskmator/services/login/login_bloc.dart";
import "package:com_nicodevelop_taskmator/services/logout/logout_bloc.dart";
import "package:com_nicodevelop_taskmator/services/update_account/update_account_bloc.dart";
import "package:com_nicodevelop_taskmator/services/upload_file/upload_file_bloc.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ServiceFactory extends StatelessWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseFunctions firebaseFunctions;

  final Widget child;

  const ServiceFactory({
    super.key,
    required this.child,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
    required this.firebaseFunctions,
  });

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository(
      firebaseAuth: firebaseAuth,
    );

    final AccountRepository accountRepository = AccountRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );

    final UploadRepository uploadRepository = UploadRepository(
      firebaseAuth: firebaseAuth,
      firebaseStorage: firebaseStorage,
    );

    final TaskRepository taskRepository = TaskRepository(
      firebaseAuth: firebaseAuth,
      firebaseFirestore: firebaseFirestore,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<BootstrapBloc>(
          create: (_) => BootstrapBloc()
            ..add(OnBootstrapEvent(
              readyStartModel: ReadyStartModel(),
            )),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AuthenticationStatusBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<CreateAccountBloc>(
          create: (context) => CreateAccountBloc(
            accountRepository: accountRepository,
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationRepository: AuthenticationRepository(
              firebaseAuth: firebaseAuth,
            ),
          ),
        ),
        BlocProvider<UpdateAccountBloc>(
          create: (context) => UpdateAccountBloc(
            accountRepository: accountRepository,
          ),
        ),
        BlocProvider<DeleteAccountBloc>(
          create: (context) => DeleteAccountBloc(
            accountRepository: accountRepository,
          ),
        ),
        BlocProvider<LogoutBloc>(
          create: (context) => LogoutBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<UploadFileBloc>(
          create: (context) => UploadFileBloc(
            uploadRepository: uploadRepository,
          ),
        ),
        BlocProvider<AddTaskBloc>(
          create: (context) => AddTaskBloc(
            taskRepository: taskRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
