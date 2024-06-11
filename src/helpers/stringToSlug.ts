//TODO find all places slug to name is converted and use this
const stringToSlug = (name: string) => {
  return name
    .toLowerCase()
    .replaceAll(" ", "-")
    .replaceAll(/[^A-Za-z0-9-]+/g, "")
    .replace(/-$/, "");
};

export default stringToSlug;
