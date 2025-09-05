export function hey(message: string): string {
  message = message.replace(/ /g,'');
  message = message.replace(/\t/g,'');
  message = message.replace(/\r/g,'');
  message = message.replace(/\n/g,'');
  if (message[message.length - 1] == '?') {
    message = message.replace(/[^A-Za-z]+/g, '');
    if (message && message.length > 1 && message.toUpperCase() == message) {
      return "Calm down, I know what I'm doing!";
    }
    return 'Sure.';
  }
  if (message.length == 0) {
    return 'Fine. Be that way!';
  }
  message = message.replace(/[^A-Za-z]+/g, '');
  if (message.length > 1 && message.toUpperCase() == message) {
    return 'Whoa, chill out!';
  }
  return 'Whatever.';
}
 