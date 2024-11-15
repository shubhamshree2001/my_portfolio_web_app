// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState isLoading(bool isLoading);

  HomeState isPageScrollingUp(bool isPageScrollingUp);

  HomeState isHoveredProjectCard(bool isHoveredProjectCard);

  HomeState hoveredIndex(int? hoveredIndex);

  HomeState showMoreExperience(bool showMoreExperience);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    bool? isLoading,
    bool? isPageScrollingUp,
    bool? isHoveredProjectCard,
    int? hoveredIndex,
    bool? showMoreExperience,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeState.copyWith.fieldName(...)`
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  const _$HomeStateCWProxyImpl(this._value);

  final HomeState _value;

  @override
  HomeState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  HomeState isPageScrollingUp(bool isPageScrollingUp) =>
      this(isPageScrollingUp: isPageScrollingUp);

  @override
  HomeState isHoveredProjectCard(bool isHoveredProjectCard) =>
      this(isHoveredProjectCard: isHoveredProjectCard);

  @override
  HomeState hoveredIndex(int? hoveredIndex) => this(hoveredIndex: hoveredIndex);

  @override
  HomeState showMoreExperience(bool showMoreExperience) =>
      this(showMoreExperience: showMoreExperience);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isPageScrollingUp = const $CopyWithPlaceholder(),
    Object? isHoveredProjectCard = const $CopyWithPlaceholder(),
    Object? hoveredIndex = const $CopyWithPlaceholder(),
    Object? showMoreExperience = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isPageScrollingUp: isPageScrollingUp == const $CopyWithPlaceholder() ||
              isPageScrollingUp == null
          ? _value.isPageScrollingUp
          // ignore: cast_nullable_to_non_nullable
          : isPageScrollingUp as bool,
      isHoveredProjectCard:
          isHoveredProjectCard == const $CopyWithPlaceholder() ||
                  isHoveredProjectCard == null
              ? _value.isHoveredProjectCard
              // ignore: cast_nullable_to_non_nullable
              : isHoveredProjectCard as bool,
      hoveredIndex: hoveredIndex == const $CopyWithPlaceholder()
          ? _value.hoveredIndex
          // ignore: cast_nullable_to_non_nullable
          : hoveredIndex as int?,
      showMoreExperience: showMoreExperience == const $CopyWithPlaceholder() ||
              showMoreExperience == null
          ? _value.showMoreExperience
          // ignore: cast_nullable_to_non_nullable
          : showMoreExperience as bool,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class that can be used as follows: `instanceOfHomeState.copyWith(...)` or like so:`instanceOfHomeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}
