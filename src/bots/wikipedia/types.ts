// The type of the individual object that is returned
// after every single scrape function call
export type ScrappedArticleDataObject = {
  sections: { factiiis: string[]; content: string; imageUrls: string[] }[]; // The scraped sections
  sourceUrl: string; // The source URL of the article
  nextUrls: string[]; // New URLs to scrape
  rawScrape: string; // The raw HTML of the scraped article
  errors: string[]; // Errors that occurred during scraping
};

// These are heading that should not be scraped
export const EXCLUDED_HEADINGS = [
  "External links",
  "Further reading",
  "References",
  "Notes",
  "See also",
  "Contents",
  "Bibliography",
  "Gallery",
  "Index",
  "Acknowledgements",
  "linked topics",
  "Citations",
];
