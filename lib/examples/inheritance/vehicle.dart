// Ví dụ 1 — Inheritance cơ bản: Vehicle → Car → ElectricCar / Truck.
// Doc: md/inheritance.md mục 4.1

// ── Base class ────────────────────────────────────────────────────────────────

class Vehicle {
  final String brand;
  final int year;

  Vehicle(this.brand, this.year);

  String get info => '$brand ($year)';

  /// Concrete method — lớp con có thể override hoặc kế thừa nguyên.
  String describe() => 'Vehicle: $info';

  String fuelType() => 'Unknown';
}

// ── Level 2 ───────────────────────────────────────────────────────────────────

class Car extends Vehicle {
  final int doors;

  /// super.brand, super.year — chuyển tham số lên constructor cha.
  Car(super.brand, super.year, this.doors);

  @override
  String describe() => '${super.describe()} — Car, $doors cửa';

  @override
  String fuelType() => 'Gasoline';
}

class Truck extends Vehicle {
  final double payloadTons;

  Truck(super.brand, super.year, this.payloadTons);

  @override
  String describe() => '${super.describe()} — Truck, tải ${payloadTons}t';

  @override
  String fuelType() => 'Diesel';
}

// ── Level 3 (multi-level) ─────────────────────────────────────────────────────

class ElectricCar extends Car {
  final int rangeKm;

  ElectricCar(super.brand, super.year, super.doors, this.rangeKm);

  @override
  String describe() => '${super.describe()} [Electric, ${rangeKm}km]';

  @override
  String fuelType() => 'Electric';
}

// ── Demo helper ───────────────────────────────────────────────────────────────

class VehicleInfo {
  final Vehicle vehicle;

  VehicleInfo(this.vehicle);

  String get rType => vehicle.runtimeType.toString();
  bool get isCar => vehicle is Car;
  bool get isElectric => vehicle is ElectricCar;
  String get describeText => vehicle.describe();
  String get fuel => vehicle.fuelType();
}

List<VehicleInfo> buildVehicleList() => [
      VehicleInfo(Car('Toyota', 2022, 4)),
      VehicleInfo(Truck('Volvo', 2021, 10.5)),
      VehicleInfo(ElectricCar('Tesla', 2024, 4, 500)),
    ];
