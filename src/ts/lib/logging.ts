export function logger(message: string, type: string = "none") {
    switch (type) {
        case "error":
            console.error("[TLR] " + message);
            break;
        case "warn":
            console.warn("[TLR] " + message);
            break;
        case "info":
            console.info("%c[TLR] " + message, "color: #63d3ff; font-weight: bold");
            break;
        case "debug":
            console.debug("[TLR] " + message);
            break;
        case "success": 
            console.log("%c[TLR] " + message, "color: limegreen; font-weight: bold");
            break;
        case "fatal-error":
            console.error("%c[TLR] Critical Error: " + message, "font-weight: bold; font-size: 150%");
            break;
        default:
            console.log("[TLR] " + message);
            break;
    }
}