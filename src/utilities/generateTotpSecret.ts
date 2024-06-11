const generateTotpSecret = () => {
  const base32chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
  let secret = "";

  for (let i = 0; i < 16; i++) {
    const randIndex = Math.floor(Math.random() * base32chars.length);
    secret += base32chars[randIndex];
  }

  return secret;
};

export default generateTotpSecret;
