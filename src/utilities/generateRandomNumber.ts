/**
 *
 * @param min the least possible value (inclusive)
 * @param max the greatest posible value (exclusive)
 * @returns an integer between `min` and `max`
 */

const generateRandomNumber = (min: number, max: number): number => {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

export default generateRandomNumber;
