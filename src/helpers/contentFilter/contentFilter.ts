import profaneWordsList from "./eng.json";
import { v4 as uuid } from "uuid";
import urlRegexSafe from "url-regex-safe";

const urlRegex = urlRegexSafe();
const mentionRegex = /(?:@[a-zA-Z0-9_.]+)/g;
const spaceRegex = /(?:s\/[a-zA-Z0-9_.-]+)/g;

const contentFilter = (content: string) => {
  const id = uuid();

  // Create a regex part for excluded words (with word boundaries)
  const excludedWordsRegexPart = profaneWordsList.excluded
    .map((word) => `\\b${word.replace(/(\W)/g, "\\$1")}\\b`)
    .join("|");

  // Create a regex part for profane words (without word boundaries)
  const profaneWordsRegexPart = profaneWordsList.words
    .filter((word) => !profaneWordsList.excluded.includes(word))
    .map((word) => `${word.replace(/(\W)/g, "\\$1")}`)
    .join("|");

  // Combine the two parts, with excluded words taking precedence
  const combinedRegex = new RegExp(
    `(${excludedWordsRegexPart})|(${profaneWordsRegexPart})`,
    "gi",
  );

  // Function to replace a matched profane word with <c> tags
  const replaceWord = (match: string, tag: string) => {
    // Check if the word is in the exclusion list
    if (
      tag === "c" &&
      profaneWordsList.excluded.some((excludedWord) =>
        new RegExp(`\\b${excludedWord}\\b`, "gi").test(match),
      )
    ) {
      return match; // Do not replace if the word is excluded
    }
    return `<${tag} id=${id[0]}>${match}</${tag}>`;
  };

  const formatContent = (content: string) => {
    return content
      .replaceAll(combinedRegex, (match) => replaceWord(match, "c"))
      .split(
        new RegExp(
          `(${urlRegex.source}|${spaceRegex.source}|${mentionRegex.source})`,
          "gi",
        ),
      )
      .map((element) => {
        if (element.match(urlRegex)) return replaceWord(element, "link");
        else if (element.match(mentionRegex)) return replaceWord(element, "@");
        else if (element.match(spaceRegex)) return replaceWord(element, "s");
        else return element;
      })
      .join("");
  };

  // Return the filtered content and ID
  return {
    filteredContent: formatContent(content),
    id,
  };
};

export default contentFilter;
