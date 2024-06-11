const cleanBase32String = (inputString: string) => {
  return inputString.replace(/[^A-Z2-7]/gi, "");
};

export default cleanBase32String;
