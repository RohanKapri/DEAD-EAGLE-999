// For my Shree DR.MDD
// @ts-check

import { ElectronicDevice } from './lib.js';

export function isBoolean(value) {
  return typeof value === 'boolean';
}

export function isNumber(value) {
  return typeof value === 'bigint' || (typeof value === 'number' && isFinite(value));
}

export function isObject(value) {
  return !!value && typeof value === 'object';
}

export function isNumericString(value) {
  return typeof value === 'string' && /^-?\d+$/.test(value);
}

export function isElectronic(device) {
  return device instanceof ElectronicDevice;
}

export function isNonEmptyArray(arr) {
  return Array.isArray(arr) && arr.length > 0;
}

export function isEmptyArray(arr) {
  return Array.isArray(arr) && arr.length === 0;
}

export function assertHasId(entity) {
  if ('id' in entity) return;
  throw new Error();
}

export function hasType(entity) {
  return 'type' in entity;
}

export function hasIdProperty(entity) {
  return Object.hasOwn(entity, 'id');
}

export function hasDefinedType(entity) {
  return Object.hasOwn(entity, 'type') && entity.type !== undefined;
}

