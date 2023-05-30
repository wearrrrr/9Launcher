export function logger(message: string, type: string = "info") {
    switch (type) {
        case "error":
            console.error("[9L] " + message);
            break;
        case "warn":
            console.warn("[9L] " + message);
            break;
        case "info":
            console.info("%c[9L] " + message, "color: #63d3ff; font-weight: bold");
            break;
        case "debug":
            console.debug("[9L] " + message);
            break;
        case "success": 
            console.log("%c[9L] " + message, "color: limegreen; font-weight: bold");
            break;
        case "fatal-error":
            console.error("%c[9L] Critical Error: " + message, "font-weight: bold; font-size: 150%");
            break;
        default:
            console.log("[9L] " + message);
            break;
    }
}