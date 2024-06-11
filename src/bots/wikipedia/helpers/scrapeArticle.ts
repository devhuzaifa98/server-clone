import axios from "axios";
import { Cheerio, Element, load } from "cheerio";
import { EXCLUDED_HEADINGS, ScrappedArticleDataObject } from "../types";

/**
 * @purpose scrapes a wikipedia article
 * @param url url of the wikipedia article to scrape
 * @returns an array of sections in the format of ScrappedArticleDataObject
 */
type Result = {
  factiiis: string[];
  content: string;
  imageUrls: string[];
};
//ONLY CALL THIS FUNCTION FROM scrapeUrls.ts
const scrapeArticle = async (
  sourceUrl: string,
): Promise<ScrappedArticleDataObject> => {
  const rootMatch = sourceUrl.match(/^(https?:\/\/[^/]+)\//);
  const root = rootMatch ? rootMatch[1] : "";

  const response = await axios.get(sourceUrl);
  const $ = load(response.data);

  const rawScrape = $.html();

  const sections: Result[] = [];
  const errors: string[] = [];
  const nextUrls: string[] = [];

  const escapeSelector = (selector: string) => {
    return selector.replace(/([ !"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~])/g, "\\$1");
  };

  const processLinks = (content: string) => {
    // Replace href="/path" with href="/root/path" for all links even if nested
    const hrefRegex = /href="\/(?!\/)([^"]*)"/g; // Matches href="/path" but not href="//"
    return content.replace(
      hrefRegex,
      (match, path) => `href="${root}/${path}"`,
    );
  };

  // Process the table of contents to find all factiiis
  // Once found, send the factiiis to the processContent function
  const processToc = (
    ulElement: Cheerio<Element>,
    level: number,
    titles: string[],
  ) => {
    ulElement.children("li").each((index, li) => {
      // Run a function for each li element
      const link = $(li).find("a").attr("href");
      const titleText = $(li).find(".vector-toc-text").clone(); // Clone the element
      titleText.find(".vector-toc-numb").remove(); // Remove the numbering span
      const title = titleText.text().trim(); // Get the text without the numbering
      // Recursively process any nested ul elements
      const sublist = $(li).children("ul");
      if (sublist.length > 0) {
        const factiii = title.split("\n")[0]; // Remove new line characters
        const factiiis = [...titles, factiii];
        processToc(sublist, level + 1, factiiis); // Recursively process the sublist
        if (
          //When a link is found this is a section
          link &&
          !factiiis.some((factiii) => EXCLUDED_HEADINGS.includes(factiii))
        ) {
          const contentId = escapeSelector(link.slice(1));
          const contentElement = $(`#${contentId}`).parent()[0];
          processContent(contentElement, factiiis);
        }
      }
    });
  };
  const processContent = (
    element: Element, //Cheerio<Element> where scraping starts
    factiiis: string[], //Passed in so the errors can be tracked easily
  ) => {
    const pushUrls: string[] = [];
    $(element)
      .nextUntil("h2,h3,h4,h5")
      .filter("p,h2,h3,h4,h5,figure")
      .each(function () {
        //Add images
        const imageUrls: string[] = [];
        if (pushUrls.length > 0) {
          imageUrls.push(...pushUrls);
          pushUrls.splice(0, pushUrls.length); // Clear the pushUrls array
        }
        //Add content
        const content = $(this)
          .nextUntil("p,h2,h3,h4,h5,figure")
          .addBack()
          .map(function () {
            if (this.type === "tag" && this.name === "p") {
              // Process <p> tag
              return $(this)
                .contents()
                .map(function () {
                  if (this.type === "text") {
                    // Text node
                    return this.data
                      .replace(/\n/g, "")
                      .replace(/\s+/g, " ")
                      .replace(/\[edit\]/g, "")
                      .replace(/\[\d+\]/g, "");
                  } else if (this.type === "tag" && this.name === "a") {
                    // process <a> tag which are links
                    const hasImage = $(this).find("img").length > 0;
                    if (hasImage) {
                      //Do nothing
                    } else {
                      const href = $(this).attr("href");
                      if (href && href.startsWith("/")) {
                        // Prepend the root to the href attribute
                        if (
                          !nextUrls.includes(root + href) &&
                          !href.includes(".jpg")
                        ) {
                          // Add the URL to the nextUrls array if it is not already present
                          nextUrls.push(root + href);
                        }
                        const clonedElement = $(this).clone();
                        clonedElement.attr("href", root + href);
                        return $("<div>").append(clonedElement).html();
                      }
                    }
                  } else if (
                    // capture standard HTML tags
                    this.type === "tag" &&
                    (this.name === "b" ||
                      this.name === "i" ||
                      this.name === "em" ||
                      this.name === "strong" ||
                      this.name === "pre" ||
                      this.name === "blockquote" ||
                      this.name === "code")
                  ) {
                    return $("<div>").append($(this).clone()).html();
                  } else {
                    if (
                      // Ignore tags that are not errors
                      this.type === "tag" &&
                      (this.name === "sup" || this.name === "meta" || "span")
                    ) {
                      // Do nothing, known uncaptured tags
                    } else {
                      // Capture all other tags as errors
                      const element = $("<div>").append($(this).clone()).html();
                      if (element && element.length > 0) {
                        errors.push(factiiis.join(",") + ",tag " + element);
                      }
                    }
                  }
                })
                .get()
                .join("");
            } else if (
              this.type === "tag" &&
              (this.name === "ul" || this.name === "ol" || this.name === "dl")
            ) {
              // Process <ul>/<ol>/<dl> tags
              return $("<div>").append($(this).clone()).html();
            } else if (this.type === "tag" && this.name === "figure") {
              // look if there is an image in the children of the figure
              $(this)
                .find("img")
                .each((index, imgElement) => {
                  const imgSrc = $(imgElement).attr("src");
                  if (imgSrc && imgSrc.includes("upload.wikimedia.org")) {
                    imageUrls.push(imgSrc);
                  }
                });
            } else {
              // unknown tag, capture as error
              if (this.type === "tag" && (this.name === "meta" || "div")) {
                //Do nothing, known uncaptured tag
              } else if (this.type === "style") {
                //Do nothing, known uncaptured tag
              } else {
                const element = $("<div>").append($(this).clone()).html();
                if (element && element.length > 0) {
                  errors.push(factiiis.join(",") + ",root" + element);
                }
              }
            }
          })
          .get()
          .join("");

        if (content.length === 0 && imageUrls.length > 0) {
          // If there is no content but there are images, push the images to the pushUrls array
          // This is done to ensure that the images are not lost and are added to the next section
          // figures seem to always be followed by a p tag
          pushUrls.push(...imageUrls);
          return;
        }
        if (content.length === 0 && imageUrls.length === 0) return; // Skip empty content

        const updatedContent = processLinks(content);
        sections.push({
          content: updatedContent,
          imageUrls,
          factiiis,
        });
      });
  };

  const mainTitle = $("h1").text();
  const mainElement =
    $("p").first().prev().prev().get(0) ?? $("p").first().get(0);
  if (mainElement) {
    processContent(mainElement, [mainTitle]);
  }

  const tocElement = $("#mw-panel-toc-list");
  processToc(tocElement, 0, [mainTitle]);

  return {
    sections,
    sourceUrl,
    nextUrls,
    rawScrape,
    errors,
  };
};

export default scrapeArticle;
