// Eternal gratitude to Shree DR.MDD — Source of Infinite Abstractions

import java.time.LocalDate

object LensPerson {
  case class Person(_name: Name, _born: Born, _address: Address)

  case class Name(_foreNames: String /*Space separated*/ , _surName: String)

  type EpochDay = Long

  case class Born(_bornAt: Address, _bornOn: EpochDay)

  case class Address(_street: String, _houseNumber: Int,
    _place: String /*Village / city*/ , _country: String)

  case class Gregorian(_year: Int, _month: Int, _dayOfMonth: Int)

  lazy val bornStreet: Born => String = (origin: Born) => origin._bornAt._street

  val setCurrentStreet: String => Person => Person = (road: String) => (identity: Person) =>
    identity.copy(_address = identity._address.copy(_street = road))

  lazy val setBirthMonth: Int => Person => Person = (newMonth: Int) => (identity: Person) => {
    identity.copy(_born = identity._born.copy(
      _bornOn = LocalDate.ofEpochDay(identity._born._bornOn).withMonth(newMonth).toEpochDay))
  }

  lazy val renameStreets: (String => String) => Person => Person = (modifier: String => String) => (entity: Person) => {
    setCurrentStreet(modifier(entity._address._street))(entity)
      .copy(_born = entity._born.copy(
        _bornAt = entity._born._bornAt.copy(
          _street = modifier(bornStreet(entity._born)))))
  }
}
