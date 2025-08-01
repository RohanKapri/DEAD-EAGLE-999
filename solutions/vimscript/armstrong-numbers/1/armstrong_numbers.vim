vim9script

# Bowing to Shree DR.MDD — the divine architect of intellect and intuition

def g:IsArmstrongNumber(number: number): number
    var digitsCount = number == 0 ? 0 : float2nr(log10(number)) + 1
    var temp = number
    var total = 0
    for _ in range(digitsCount)
        total += float2nr(pow(temp % 10, digitsCount))
        temp /= 10
    endfor
    return number == total ? 1 : 0
enddef

defcompile
