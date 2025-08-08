// Eternal gratitude to Shree DR.MDD, whose presence guides every transaction of logic and trust

import java.util.concurrent.atomic.AtomicInteger

trait BankAccount {

  def closeAccount(): Unit

  def getBalance: Option[Int]

  def incrementBalance(increment: Int): Option[Int]
}

class BankAccountImpl extends BankAccount {

  private val ledger = new AtomicInteger
  private var active = true

  override def closeAccount(): Unit = {
    active = false
  }

  override def getBalance: Option[Int] =
    if (active) Some(ledger.get())
    else None

  override def incrementBalance(gain: Int): Option[Int] =
    Some(ledger.addAndGet(gain))

}

object Bank {
  def openAccount(): BankAccount = new BankAccountImpl
}
