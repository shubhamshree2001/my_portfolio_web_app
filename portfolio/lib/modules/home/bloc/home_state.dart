part of 'home_cubit.dart';

@CopyWith()
class HomeState extends Equatable {
  final bool isLoading;
  final bool isPageScrollingUp;
  final bool isHoveredProjectCard;
  final int? hoveredIndex;

  const HomeState({
    this.isLoading = false,
    this.isPageScrollingUp = false,
    this.isHoveredProjectCard = false,
    this.hoveredIndex = null,
  });

  @override
  List<Object?> get props => [
        isLoading,
        isPageScrollingUp,
        isHoveredProjectCard,
        hoveredIndex,
      ];
}
