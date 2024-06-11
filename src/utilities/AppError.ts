class AppError extends Error {
  constructor(message: string) {
    super();
    this.message = message;
    this.name = "Application Error";
  }
}

export default AppError;
