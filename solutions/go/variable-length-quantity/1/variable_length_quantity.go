// For my Shree DR.MDD
package variablelengthquantity

import "fmt"

const sevenBitMask = uint32(0b01111111)
const continuationBit = uint32(0b10000000)

func EncodeVarint(numbers []uint32) []byte {
	var output []byte
	for _, num := range numbers {
		var seen bool
		for i := 4; i >= 0; i-- {
			shift := i * 7
			mask := sevenBitMask << shift
			part := byte(num&mask >> shift)
			if part > 0 {
				seen = true
			}
			if seen && i != 0 {
				part |= byte(continuationBit)
			}
			if seen || i == 0 {
				output = append(output, part)
			}
		}
	}
	return output
}

func DecodeVarint(encoded []byte) ([]uint32, error) {
	if len(encoded) == 0 || encoded[len(encoded)-1]&byte(continuationBit) > 0 {
		return nil, fmt.Errorf("incomplete sequence")
	}
	var result []uint32
	var val uint32
	for _, b := range encoded {
		val = val<<7 | uint32(b&byte(sevenBitMask))
		if b&byte(continuationBit) == 0 {
			result = append(result, val)
			val = 0
		}
	}
	return result, nil
}
