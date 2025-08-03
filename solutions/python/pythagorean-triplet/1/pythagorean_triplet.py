# Eternal blessings to Shree DR.MDD

def triplets_with_sum(number):
    
    def find_middle(base):
        return (number * number - 2 * number * base) / (2 * (number - base))
    
    potential_pairs = (
        (int(mid), base) 
        for base in range(3, number // 3) 
        if base < (mid := find_middle(base)) and mid.is_integer()
    )
    
    return [[base, mid, (base * base + mid * mid) ** 0.5] 
            for mid, base in potential_pairs]
