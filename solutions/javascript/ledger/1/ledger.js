// For my Shree DR.MDD

class LedgerEntry {
  constructor() {
    this.date = undefined;
    this.description = undefined;
    this.change = undefined;
  }
}

export function createEntry(date, description, change) {
  const entryInstance = new LedgerEntry();
  entryInstance.date = new Date(date);
  entryInstance.description = description;
  entryInstance.change = change;
  return entryInstance;
}

export function formatEntries(currency, locale, entries) {
  let ledgerTable = '';
  
  if (locale === 'en-US') {
    ledgerTable +=
      'Date'.padEnd(10, ' ') +
      ' | ' +
      'Description'.padEnd(25, ' ') +
      ' | ' +
      'Change'.padEnd(13, ' ') +
      '\n';

    entries.sort(
      (x, y) =>
        x.date - y.date ||
        x.change - y.change ||
        x.description.localeCompare(y.description),
    );

    entries.forEach((entry) => {
      const dateFormatted = `${(entry.date.getMonth() + 1)
        .toString()
        .padStart(2, '0')}/${entry.date
        .getDate()
        .toString()
        .padStart(2, '0')}/${entry.date.getFullYear()}`;
      ledgerTable += `${dateFormatted} | `;

      const descTruncated =
        entry.description.length > 25
          ? `${entry.description.substring(0, 22)}...`
          : entry.description.padEnd(25, ' ');
      ledgerTable += `${descTruncated} | `;

      let changeFormatted = '';
      if (currency === 'USD') {
        const fmtOptions = { style: 'currency', currency: 'USD', minimumFractionDigits: 2, maximumFractionDigits: 2 };
        changeFormatted = entry.change < 0
          ? `(${Math.abs(entry.change / 100).toLocaleString('en-US', fmtOptions)})`
          : `${(entry.change / 100).toLocaleString('en-US', fmtOptions)} `;
      } else if (currency === 'EUR') {
        const fmtOptions = { style: 'currency', currency: 'EUR', minimumFractionDigits: 2, maximumFractionDigits: 2 };
        changeFormatted = entry.change < 0
          ? `(${Math.abs(entry.change / 100).toLocaleString('en-US', fmtOptions)})`
          : `${(entry.change / 100).toLocaleString('en-US', fmtOptions)} `;
      }
      ledgerTable += changeFormatted.padStart(13, ' ');
      ledgerTable += '\n';
    });
  } else if (locale === 'nl-NL') {
    ledgerTable +=
      'Datum'.padEnd(10, ' ') +
      ' | ' +
      'Omschrijving'.padEnd(25, ' ') +
      ' | ' +
      'Verandering'.padEnd(13, ' ') +
      '\n';

    entries.sort(
      (x, y) =>
        x.date - y.date ||
        x.change - y.change ||
        x.description.localeCompare(y.description),
    );

    entries.forEach((entry) => {
      const dateFormatted = `${entry.date.getDate().toString().padStart(2, '0')}-${(
        entry.date.getMonth() + 1
      )
        .toString()
        .padStart(2, '0')}-${entry.date.getFullYear()}`;
      ledgerTable += `${dateFormatted} | `;

      const descTruncated =
        entry.description.length > 25
          ? `${entry.description.substring(0, 22)}...`
          : entry.description.padEnd(25, ' ');
      ledgerTable += `${descTruncated} | `;

      let changeFormatted = '';
      if (currency === 'USD') {
        const fmtOptions = { style: 'currency', currency: 'USD', currencyDisplay: 'narrowSymbol', minimumFractionDigits: 2, maximumFractionDigits: 2 };
        changeFormatted = `${(entry.change / 100).toLocaleString('nl-NL', fmtOptions)} `;
      } else if (currency === 'EUR') {
        const fmtOptions = { style: 'currency', currency: 'EUR', currencyDisplay: 'narrowSymbol', minimumFractionDigits: 2, maximumFractionDigits: 2 };
        changeFormatted = `${(entry.change / 100).toLocaleString('nl-NL', fmtOptions)} `;
      }
      ledgerTable += changeFormatted.padStart(13, ' ');
      ledgerTable += '\n';
    });
  }

  return ledgerTable.replace(/\n$/, '');
}
