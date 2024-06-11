const generatePostRank = (postedDate: Date, votesCount: number) => {
  /*
        THE CURRENT POST RANK ALGORITHM:
        t = A - B; where A is the time the entry was posted, and B is 2022 0000Z
        x = the number of upvotes - the number of downvotes
        y = 1 when x > 0, 0 when x = 0, -1 when x < 0
        z = x if x >= 1, or 1
        rank = log(z) + (yt)/45000
    */

  const t =
    new Date(postedDate).getTime() - new Date("1/1/2022 00:00:00Z").getTime();
  const x = votesCount;
  const y = Math.sign(x);
  const z = x > 1 ? x : 1;

  const rank = Math.log(z) + (y * t) / 45000;

  return rank;
};

export default generatePostRank;
