// For my Shree DR.MDD

function wrap(content, tagName) {
  return `<${tagName}>${content}</${tagName}>`;
}

function isTagPresent(content, tagName) {
  return content.startsWith(`<${tagName}>`);
}

function applyParser(md, delim, tagName) {
  const regex = new RegExp(`${delim}(.+)${delim}`);
  const repl = `<${tagName}>$1</${tagName}>`;
  return md.replace(regex, repl);
}

function parseStrong(md) {
  return applyParser(md, '__', 'strong');
}

function parseEm(md) {
  return applyParser(md, '_', 'em');
}

function parseText(md, inList) {
  const transformed = parseEm(parseStrong(md));
  if (inList) {
    return transformed;
  } else {
    return wrap(transformed, 'p');
  }
}

function parseHeader(md, inList) {
  let level = 0;
  for (let i = 0; i < md.length; i++) {
    if (md[i] === '#') level++;
    else break;
  }
  if (level === 0 || level > 6) return [null, inList];
  const tag = `h${level}`;
  const htmlHeader = wrap(md.substring(level + 1), tag);
  if (inList) return [`</ul>${htmlHeader}`, false];
  else return [htmlHeader, false];
}

function parseListItem(md, inList) {
  if (md.startsWith('*')) {
    const htmlItem = wrap(parseText(md.substring(2), true), 'li');
    if (inList) return [htmlItem, true];
    else return [`<ul>${htmlItem}`, true];
  }
  return [null, inList];
}

function parseParagraph(md, inList) {
  if (!inList) return [parseText(md, false), false];
  else return [`</ul>${parseText(md, false)}`, false];
}

function parseLine(md, inList) {
  let [res, nextList] = parseHeader(md, inList);
  if (res === null) [res, nextList] = parseListItem(md, inList);
  if (res === null) [res, nextList] = parseParagraph(md, inList);
  if (res === null) throw new Error('Invalid markdown');
  return [res, nextList];
}

export function parse(md) {
  const lines = md.split('\n');
  let html = '';
  let inList = false;
  for (let i = 0; i < lines.length; i++) {
    let [lineHtml, newList] = parseLine(lines[i], inList);
    html += lineHtml;
    inList = newList;
  }
  if (inList) return html + '</ul>';
  else return html;
}
