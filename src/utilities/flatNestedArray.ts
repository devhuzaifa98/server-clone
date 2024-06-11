const flatNestedArray = (childKey: string, array: any[]): any[] => {
  let result: any[] = [];
  array.forEach(function (a) {
    result.push(a);
    if (Array.isArray(a[childKey])) {
      result = result.concat(flatNestedArray(childKey, a[childKey]));
    }
  });
  return result;
};

export default flatNestedArray;
