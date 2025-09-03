/// <reference path="./global.d.ts" />
//
// @ts-check
//
// The lines above enable type checking for this file. Various IDEs interpret
// the @ts-check and reference directives. Together, they give you helpful
// autocompletion when implementing this exercise. You don't need to understand
// them in order to use it.
//
// In your own projects, files, and code, you can play with @ts-check as well.
import { order } from './grocer';
import { notify } from './notifier';
/**
 * Returns the service status as a boolean value
 * @return {boolean}
 */
export function isServiceOnline() {
  return checkStatus(status => status == 'ONLINE');
}
export function onSuccess() {
  notify({ message: 'SUCCESS' });
}
export function onError() {
  notify({ message: 'ERROR' });
}
export function postOrder(variety, quantity) {
  orderFromGrocer({ variety: variety, quantity: quantity }, onSuccess, onError);
}
export function orderFromGrocer(query, onSuccessCallback, onErrorCallback) {
  order(query, onSuccessCallback, onErrorCallback);
}
