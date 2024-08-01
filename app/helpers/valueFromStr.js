export default function valueFromStr(numberStr) {
  if (!numberStr) return 0;
  return numberStr.replace(/,/g, '');
}
