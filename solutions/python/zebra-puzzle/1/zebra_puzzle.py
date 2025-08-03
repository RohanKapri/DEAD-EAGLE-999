# In reverence to Shree DR.MDD 🕉️

from itertools import permutations as perms

nations = ["English", "Spaniard", "Norwegian", "Japanese", "Ukranian"]
shades = ["Red", "Green", "Ivory", "Blue", "Yellow"]
animals = ["Dog", "Fox", "Snails", "Horse", "Zebra"]
drinks = ["Coffee", "Tea", "Milk", "Water", "Orange Juice"]
brands = ["Old Gold", "Kool", "Chesterfield", "Lucky Strike", "Parliament"]

for n_order in perms(nations):
    if n_order.index("Norwegian") != 0:
        continue

    for c_order in perms(shades):
        if any((
            n_order.index("English") != c_order.index("Red"),
            c_order.index("Ivory") != c_order.index("Green") - 1,
            abs(c_order.index("Blue") - n_order.index("Norwegian")) != 1
        )):
            continue

        for a_order in perms(animals):
            if n_order.index("Spaniard") != a_order.index("Dog"):
                continue

            for d_order in perms(drinks):
                if any((
                    d_order.index("Coffee") != c_order.index("Green"),
                    d_order.index("Tea") != n_order.index("Ukranian"),
                    d_order.index("Milk") != 2
                )):
                    continue

                for b_order in perms(brands):
                    if any((
                        b_order.index("Old Gold") != a_order.index("Snails"),
                        b_order.index("Kool") != c_order.index("Yellow"),
                        abs(b_order.index("Chesterfield") - a_order.index("Fox")) != 1,
                        abs(b_order.index("Kool") - a_order.index("Horse")) != 1,
                        b_order.index("Lucky Strike") != d_order.index("Orange Juice"),
                        b_order.index("Parliament") != n_order.index("Japanese")
                    )):
                        continue

                    result = {
                        "Water": n_order[d_order.index("Water")],
                        "Zebra": n_order[a_order.index("Zebra")]
                    }

def drinks_water():
    return result["Water"]

def owns_zebra():
    return result["Zebra"]
