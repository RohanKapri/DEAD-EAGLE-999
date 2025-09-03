/// <reference path="./global.d.ts" />
// @ts-check

class Visitor {
  constructor(name, age, ticketID) {
    this.name = name,
    this.age = age,
    this.ticketId = ticketID
  }

}


export function createVisitor(name, age, ticketId) {
  return new Visitor(name, age, ticketId);
}

/**
 * Revokes a ticket for a visitor.
 *
 * @param {Visitor} visitor the visitor with an active ticket
 * @returns {Visitor} the visitor without a ticket
 */
export function revokeTicket(visitor) {
  visitor["ticketId"] = null;
  return visitor;
}

export function ticketStatus(tickets, ticketId) {
  switch(true){
    case (typeof tickets[ticketId] === "string"):
      return "sold to " + tickets[ticketId];
    case (tickets[ticketId] === null):
      return "not sold"
    default:
      return "unknown ticket id";
  }
}

export function simpleTicketStatus(tickets, ticketId) {
  switch(true){
    case (tickets[ticketId] != null):
      return tickets[ticketId];
    default:
      return "invalid ticket !!!";
  }
}

export function gtcVersion(visitor) {
  if(visitor.gtc && visitor.gtc.signed === true){
    return visitor.gtc.version;
  } else if(visitor.gtc){
    return undefined
  }
  return undefined;
}