package HandshakeCalculator

import Signal
import Signal.*

fun calculateHandshake(number: Int): List<Signal> {

    val handshake = ArrayList<Signal>()

    if (number.bitSet(0)) handshake.add(WINK)
    if (number.bitSet(1)) handshake.add(DOUBLE_BLINK)
    if (number.bitSet(2)) handshake.add(CLOSE_YOUR_EYES)
    if (number.bitSet(3)) handshake.add(JUMP)
    if (number.bitSet(4)) handshake.reverse()

    return handshake
}

private fun Int.bitSet(bit: Int) = this and (1 shl bit) != 0