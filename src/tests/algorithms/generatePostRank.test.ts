import { describe, expect, it } from "@jest/globals";
import { generatePostRank } from "../../helpers";

describe("Test the Post Rank algorithm", () => {
  it("a post created on 01/01/2023 with 0 votes", async () => {
    expect(generatePostRank(new Date(1672511400000), 0)).toBe(0);
  });
  it("a post created on 01/01/2023 with -1 votes", async () => {
    expect(generatePostRank(new Date(1672511400000), -1)).toBe(-700360);
  });
  it("a post created on 01/01/2023 with 36 votes", async () => {
    expect(generatePostRank(new Date(1672511400000), 36)).toBe(
      700363.5835189385,
    );
  });
});
