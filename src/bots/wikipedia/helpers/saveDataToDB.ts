import axios from "axios";
import log from "../../../helpers/log";
import { ScrappedArticleDataObject } from "../types";

/**
 *
 * @param data the ScrappedArticleDataObject to save to DB
 * @param authToken JWT token of the u/wikipedia user
 * @returns a boolean indicating whether the save was successful
 */

const saveDataToDB = async (
  scrappedData: ScrappedArticleDataObject[],
  authToken: string,
) => {
  try {
    await axios.post(
      process.env.SERVER_URL + "/factiiis/wiki-scrape-bulk-upload",
      {
        scrappedData,
      },
      {
        headers: {
          Authorization: `Bearer ${authToken}`,
        },
      },
    );

    log("success", "All scrapped data uploaded successfully to the server");
  } catch (error) {
    log("error", "Upload to database failed");
    log("error", error as string);
    throw new Error("An error occured while uploading data to server");
  }

  return true;
};

export default saveDataToDB;
