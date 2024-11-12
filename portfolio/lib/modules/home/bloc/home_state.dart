part of 'home_cubit.dart';

@CopyWith()
class HomeState extends Equatable {
  final bool isLoading;
  final bool isPageScrollingUp;

  const HomeState({
    this.isLoading = false,
    this.isPageScrollingUp = false,
  });

  @override
  List<Object?> get props => [
        isLoading,
        isPageScrollingUp,
      ];
}
