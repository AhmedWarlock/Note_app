part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class SignedOutState extends AppState {}

class SignedInState extends AppState {}

class LoadingState extends AppState {}
