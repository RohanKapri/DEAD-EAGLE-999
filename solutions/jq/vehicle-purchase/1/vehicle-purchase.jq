
def needs_license:
  IN("car", "truck");

def choose_vehicle:
  min + " is clearly the better choice.";

def resell_price:
  .original_price * (
    if .age < 3 then 80
    elif .age <= 10 then 70
    else 50
    end
  ) / 100;