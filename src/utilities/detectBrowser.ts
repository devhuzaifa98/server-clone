const detectBrowser = (userAgent: string) => {
  if (userAgent.match(/chrome|chromium|crios/i)) return "Chrome";
  if (userAgent.match(/firefox|fxios/i)) return "Firefox";
  if (userAgent.match(/safari/i)) return "Safari";
  if (userAgent.match(/opr\//i)) return "Opera";
  if (userAgent.match(/edg/i)) return "Edge";
  return "Unknown";
};

export default detectBrowser;
