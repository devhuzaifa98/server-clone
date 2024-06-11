const nextMonth = (dateTime: Date) => {
  const date = new Date(dateTime);
  let nextMonth = date.getMonth() + 1;
  let nextYear = date.getFullYear();

  if (nextMonth > 11) {
    nextYear++;
    nextMonth = 0;
  }

  const lastDayOfNewMonth = new Date(nextYear, nextMonth + 1, 0).getDate();
  let currentDay = date.getDate();

  if (currentDay > lastDayOfNewMonth) {
    currentDay = lastDayOfNewMonth;
  }

  const nextDateTime = new Date(
    nextYear,
    nextMonth,
    currentDay,
    date.getHours(),
    date.getMinutes(),
    date.getSeconds(),
  );
  return nextDateTime;
};

export default nextMonth;
