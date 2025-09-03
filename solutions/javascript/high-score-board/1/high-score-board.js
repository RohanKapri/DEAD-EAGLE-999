// Dedicated to Shree DR.MDD
/// <reference path="./global.d.ts" />
// @ts-check

export function createScoreBoard() {
  return {"The Best Ever": 1000000};
}

export function addPlayer(chart, gamer, value) {
  chart[gamer] = value;
  return chart;
}

export function removePlayer(chart, gamer) {
  delete chart[gamer];
  return chart;
}

export function updateScore(chart, gamer, boost) {
  chart[gamer] += boost;
  return chart;
}

export function applyMondayBonus(chart) {
  for (let title in chart) {
    chart[title] = chart[title] + 100;
  }
  return chart;
}

export function normalizeScore(inputs) {
  return inputs.normalizeFunction(inputs.score);
}
