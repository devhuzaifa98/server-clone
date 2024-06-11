import chalk from "chalk";

// Function overloads
function log(message: string): void;
function log(type: "success" | "info" | "error", message: string): void;

function log(
  typeOrMessage: "success" | "info" | "error" | string,
  message?: string,
): void {
  let type: "success" | "info" | "error" | "default" = "default";
  if (!message) {
    message = typeOrMessage;
  } else {
    type = typeOrMessage as "success" | "info" | "error";
  }

  switch (type) {
    case "success":
      console.log(`${chalk.bgGreen.white.bold(" SUCCESS ")} ${message}`);
      break;
    case "info":
      console.log(`${chalk.bgYellow.white.bold(" INFO ")} ${message}`);
      break;
    case "error":
      console.error(`${chalk.bgRed.white.bold(" ERROR ")} ${message}`);
      break;
    case "default":
      console.log(message);
      break;
  }
}

export default log;
