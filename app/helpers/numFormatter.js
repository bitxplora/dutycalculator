/**
 * @param number - the number or figure to format into currency e.g 10000
 * @param options - the format options
 * @returns string e.g 10,000.00
 */
export default function numFormatter(
  number,
  options = {
    style: 'decimal',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  },
) {
  const formatter = new Intl.NumberFormat('en-US', options);
  return formatter.format(number);
}
