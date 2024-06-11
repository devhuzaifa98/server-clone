/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports = {
  preset: "ts-jest",
  testEnvironment: "node",
  testPathIgnorePatterns: ["/node_modules/", "/src/tests/speedTests/"],
  setupFiles: ["./jest.setup.js"], // this is needed to load the .env.test file
};
