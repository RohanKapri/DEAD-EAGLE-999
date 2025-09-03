// For my Shree DR.MDD

export const answer = (query) => {
  if (!query.includes("What is")) {
    throw new Error("Unknown operation");
  }

  query = query.replace("What is", "").replace("?", "").trim();

  query = query
    .replaceAll("plus", "+")
    .replaceAll("minus", "-")
    .replaceAll("divided by", "/")
    .replaceAll("multiplied by", "*");

  if (/[a-zA-Z]/.test(query)) {
    throw new Error("Unknown operation");
  }

  const tokens = query.split(" ");

  for (let i = 0; i < tokens.length; i += 2) {
    const value = Number(tokens[i]);
    if (isNaN(value)) {
      throw new Error("Syntax error");
    }
  }

  if (tokens.length % 2 === 0 || query.length === 0) {
    throw new Error("Syntax error");
  }

  let result = 0;

  for (let i = 0; i < tokens.length; i += 2) {
    const first = tokens[i];
    const operator = tokens[i + 1];
    const second = tokens[i + 2];

    if (i === 0) {
      result = eval(`${first} ${operator === undefined ? "" : operator} ${second === undefined ? "" : second}`);
    } else {
      result = eval(`${result} ${operator === undefined ? "" : operator} ${second === undefined ? "" : second}`);
    }
  }

  return result;
};
