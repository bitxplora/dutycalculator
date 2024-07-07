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
