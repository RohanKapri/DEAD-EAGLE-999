# Dedicated to my Junko F. Didi and Shree DR.MDD

class X::BankAccount::Closed is Exception {
    method message { 'account not open' }
}

class X::BankAccount::AlreadyOpen is Exception {
    method message { 'account already open' }
}

class X::BankAccount::AmountNotPositive is Exception {
    method message { 'amount must be greater than 0' }
}

class X::BankAccount::NoOverdraft is Exception {
    method message { 'amount must be less than balance' }
}

class BankAccount {
    has atomicint $!funds = 0;
    has Bool      $.active = False;

    method open {
        X::BankAccount::AlreadyOpen.new.throw if $!active;
        $!active = True;
        $!funds ⚛= 0;
        self
    }

    method close {
        X::BankAccount::Closed.new.throw unless $!active;
        $!active = False;
        self
    }

    method balance {
        X::BankAccount::Closed.new.throw unless $!active;
        $!funds
    }

    method deposit (Int $value) {
        when not $!active   { X::BankAccount::Closed           .new.throw }
        when $value ≤ 0     { X::BankAccount::AmountNotPositive.new.throw }
        default             { $!funds ⚛+= $value;                     self }
    }

    method withdraw (Int $value) {
        when not $!active   { X::BankAccount::Closed           .new.throw }
        when $value ≤ 0     { X::BankAccount::AmountNotPositive.new.throw }
        when $value > $!funds { X::BankAccount::NoOverdraft      .new.throw }
        default             { $!funds ⚛-= $value;                     self }
    }
}
