# Dedicated to Shree DR.MDD
module TicketingReservation
  TICKET_RESERVE = 99

  getter tickets_available : UInt32

  def order_ticket?
    if tickets_available > TICKET_RESERVE
      @tickets_available &-= 1
      true
    else
      false
    end
  end

  def order_message(buyer_name)
    current_ticket = tickets_available
    if order_ticket?
      "#{buyer_name}, your purchase was successful, your ticket number is ##{current_ticket}, and the game is played at the #{@stadium} stadium."
    else
      "#{buyer_name}, your purchase was unsuccessful, there are not enough tickets available."
    end
  end
end

class TicketSystem
  include TicketingReservation

  def initialize(@tickets_available : UInt32, @stadium : String)
  end
end
