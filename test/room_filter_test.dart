import 'dart:async';

import 'package:byma_app/business_logic/hotel_rooms_filter/cubit/hotel_rooms_filter_cubit.dart';
import 'package:byma_app/data/models/room_filter_model.dart';
import 'package:byma_app/data/models/room_model.dart';
import 'package:byma_app/data/models/room_category_model.dart';
import 'package:byma_app/data/repositories/hotels_repo.dart';
import 'package:byma_app/data/web_services/hotels_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeHotelsRepo extends HotelsRepo {
  _FakeHotelsRepo(this.responses) : super(HotelsApi(Dio()));

  final Map<String, Future<List<RoomModel>>> responses;

  @override
  Future<List<RoomModel>> fetchHotelRooms(
    int hotelId, {
    RoomFilterModel? filter,
  }) {
    return responses[filter?.status]!;
  }
}

RoomModel _room(int id) {
  return RoomModel(
    id: id,
    price: 100,
    category: RoomCategoryModel(id: 1, name: 'Suite'),
    photos: const [],
  );
}

void main() {
  test('serializes only selected filter values', () {
    final filter = RoomFilterModel(status: 'AVAILABLE', roomCategoryId: 3);

    expect(filter.toJson(), {
      'status': 'AVAILABLE',
      'roomCategoryId': 3,
    });
  });

  test('ignores an older response when a newer request completes first', () async {
    final firstResponse = Completer<List<RoomModel>>();
    final secondResponse = Completer<List<RoomModel>>();
    final repo = _FakeHotelsRepo({
      'first': firstResponse.future,
      'second': secondResponse.future,
    });
    final cubit = HotelRoomsFilterCubit(repo);
    addTearDown(cubit.close);

    final firstRequest = cubit.fetchFilteredRooms(
      1,
      RoomFilterModel(status: 'first'),
    );
    final secondRequest = cubit.fetchFilteredRooms(
      1,
      RoomFilterModel(status: 'second'),
    );

    secondResponse.complete([_room(2)]);
    await secondRequest;
    firstResponse.complete([_room(1)]);
    await firstRequest;

    final roomId = cubit.state.maybeWhen(
      success: (rooms) => rooms.single.id,
      orElse: () => null,
    );

    expect(roomId, 2);
  });

  test('reset invalidates an in-flight request', () async {
    final response = Completer<List<RoomModel>>();
    final repo = _FakeHotelsRepo({'first': response.future});
    final cubit = HotelRoomsFilterCubit(repo);
    addTearDown(cubit.close);

    final request = cubit.fetchFilteredRooms(
      1,
      RoomFilterModel(status: 'first'),
    );
    cubit.resetFilter();
    response.complete([_room(1)]);
    await request;

    expect(cubit.state, const HotelRoomsFilterState.initial());
  });
}
