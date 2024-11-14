part of 'home_cubit.dart';

@CopyWith()
class HomeState extends Equatable {
  final bool isLoading;
  final bool isPageScrollingUp;
  final bool isHoveredProjectCard;

  const HomeState(
      {this.isLoading = false,
      this.isPageScrollingUp = false,
      this.isHoveredProjectCard = false});

  @override
  List<Object?> get props => [
        isLoading,
        isPageScrollingUp,
        isHoveredProjectCard,
      ];
}
