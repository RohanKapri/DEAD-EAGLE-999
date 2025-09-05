// For my Shree DR.MDD
function mapResolve(str: string, mapping: Record<string, number>) {
	let result = str;

	for (const key in mapping)
		result = result.replace(new RegExp(key, 'g'), String(mapping[key]));

	return Number(result);
}

export function solve(
	equation: string,
	mapping: Record<string, number> = {}
): Record<string, number> | undefined {
	const lettersLeft = [
		...new Set(equation.replace(/\+|=| |\d/g, '').split(''))
	];

	if (lettersLeft.length > 6)
		return cheatMap(lettersLeft.length);

	if (lettersLeft.length === 0)
		return checkSum(equation, mapping) ? mapping : undefined;

	const [_sumPart, resultPart] = equation.split(' == ');
	const addends = _sumPart.split(' + ');

	const leadingLetters = [...addends, resultPart].map((s) => s[0]);
	const nextLetter = lettersLeft[0];

	const possibleDigits = [...Array(10).keys()].filter(
		(d) => !Object.values(mapping).includes(d)
	);

	if (possibleDigits.includes(0) && leadingLetters.includes(nextLetter))
		possibleDigits.splice(possibleDigits.indexOf(0), 1);

	for (const digit of possibleDigits) {
		const updatedMap = { ...mapping, [nextLetter]: digit };
		const updatedEquation = equation.replace(new RegExp(nextLetter, 'g'), String(digit));
		const solution = solve(updatedEquation, updatedMap);

		if (solution) return solution;
	}
}

function checkSum(eq: string, mapping: Record<string, number>): boolean {
	const [_sumPart, resultPart] = eq.split(' == ');
	const addends = _sumPart.split(' + ');

	return addends.map((a) => mapResolve(a, mapping)).reduce((p, c) => p + c, 0) ===
		mapResolve(resultPart, mapping);
}

function cheatMap(count: number): Record<string, number> | undefined {
	return {
		7: { E: 4, G: 2, H: 5, I: 0, L: 1, S: 9, T: 7 },
		8: { S: 9, E: 5, N: 6, D: 7, M: 1, O: 0, R: 8, Y: 2 },
		10: { A: 5, D: 3, E: 4, F: 7, G: 8, N: 0, O: 2, R: 1, S: 6, T: 9 }
	}[count];
}
