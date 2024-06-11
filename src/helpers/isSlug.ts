const isSlug = (str: string) => {
  const regex = /^[a-z0-9-]+$/;
  return regex.test(str) && !str.endsWith("-");
};
export default isSlug;
