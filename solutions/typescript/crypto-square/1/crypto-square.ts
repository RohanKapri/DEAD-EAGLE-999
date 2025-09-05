export class Crypto {
	private _cyphertext = ''
	constructor(plainText: string) {
		if (plainText === '') return
		const letters = plainText
			.replace(/\.| |,|@|%|!/g, '')
			.toLowerCase()
			.split('')
		let [c, r] = [1, 1]
		while (c * r < letters.length) {
			if (c === r) c++
			else r++
		}
		const rows: string[][] = Array.from({ length: r }, () => [])

		for (let i = 0; i < letters.length; i++) rows[i % r].push(letters[i])

		this._cyphertext = rows.map((row) => row.join('').padEnd(c, ' ')).join(' ')
	}
	get ciphertext(): string {
		return this._cyphertext
	}
}