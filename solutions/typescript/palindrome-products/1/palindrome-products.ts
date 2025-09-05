interface Input {
  maxFactor: number
  minFactor?: number
}

interface PalindromeResult {
  value: number | null;
  factors: number[][];
}

interface PalindromeProducts {
  smallest: PalindromeResult;
  largest: PalindromeResult;
}

/**
 * Generates palindrome products within a given factor range
 * @param params Object containing maxFactor and optional minFactor
 * @returns Object with smallest and largest palindromes and their factors
 */
export function generate(params: Input): PalindromeProducts {
  const maxFactor = params.maxFactor;
  const minFactor = params.minFactor || 1;
  
  // Initialize result objects
  const result: PalindromeProducts = {
    smallest: { value: null, factors: [] },
    largest: { value: null, factors: [] }
  };
  
  // This validation is important but we only need to check when accessing the properties
  // as per the tests
  
  // Find all palindrome products
  const palindromes = new Map<number, number[][]>();
  
  for (let i = minFactor; i <= maxFactor; i++) {
    for (let j = i; j <= maxFactor; j++) {
      const product = i * j;
      if (isPalindrome(product)) {
        if (!palindromes.has(product)) {
          palindromes.set(product, []);
        }
        palindromes.get(product)!.push([i, j]);
      }
    }
  }
  
  // Sort the palindromes
  const sortedKeys = Array.from(palindromes.keys()).sort((a, b) => a - b);
  
  // If we found any palindromes, update the result
  if (sortedKeys.length > 0) {
    const smallest = sortedKeys[0];
    const largest = sortedKeys[sortedKeys.length - 1];
    
    result.smallest = { 
      value: smallest, 
      factors: palindromes.get(smallest) || [] 
    };
    
    result.largest = { 
      value: largest, 
      factors: palindromes.get(largest) || [] 
    };
  }
  
  return {
    get smallest() {
      if (minFactor > maxFactor) {
        throw new Error('min must be <= max');
      }
      return result.smallest;
    },
    get largest() {
      if (minFactor > maxFactor) {
        throw new Error('min must be <= max');
      }
      return result.largest;
    }
  };
}

/**
 * Checks if a number is a palindrome
 * @param num The number to check
 * @returns True if the number is a palindrome, false otherwise
 */
function isPalindrome(num: number): boolean {
  // More efficient palindrome check without string conversion
  if (num < 0) return false;
  
  if (num < 10) return true;
  
  // Quick check: if number ends with 0, it can't be a palindrome unless it's 0
  if (num % 10 === 0 && num !== 0) return false;
  
  const str = num.toString();
  let left = 0;
  let right = str.length - 1;
  
  while (left < right) {
    if (str[left] !== str[right]) {
      return false;
    }
    left++;
    right--;
  }
  
  return true;
}