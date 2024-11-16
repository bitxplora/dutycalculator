/*
 * Removes commas seperator from number string.
 * @param numberStr = a string of commas seperated number e.g '1,234,567'
 * @returns string with the commas seperator removed.
 */
export default function valueFromStr(numberStr) {
  if (!numberStr) return 0;
  return numberStr.replace(/,/g, '');
}
