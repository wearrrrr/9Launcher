import wineListJSON from "../assets/winelist.json";
import wineManager from "./lib/wineManager";
import tingle from "tingle.js";
const wineList = document.getElementById(
    "wine-downloads-list",
) as HTMLDivElement;

var modal = new tingle.modal({
    footer: true,
    stickyFooter: false,
    closeMethods: [],
});

var setPrimaryVersion = new tingle.modal({
    footer: true,
    stickyFooter: false,
    closeMethods: [],
});

let firstLoadFirstModal = 0;
let firstLoadSecondModal = 0;

function wineListIterator() {
    for (const [name, value] of Object.entries(wineListJSON["linux-wine"])) {
        let wine = document.createElement("div");
        wine.classList.add("wine");
        wine.id = name;
        wine.dataset.url = value.downloadURL || "";
        wine.textContent = name;
        wineList.appendChild(wine);
        let isRelativePath = true;
        wine.addEventListener("click", async () => {
            if (name == "System Wine") {
                isRelativePath = false;
            }
            if ((await wineManager.checkIfVersionExists(name)) == false) {
                modal.setContent(`
                <h2 class="modal-title">Wine build ${name} not found! Download now?</h2>
                <div class="progress-bar" id="progress-bar">
                    <div id="progress-bar-progress"><p id="progress-bar-text">0%</p></div>
                </div>`);
                modal.open();
                if (firstLoadFirstModal == 0) {
                    firstLoadFirstModal = 1;
                    modal.addFooterBtn(
                        "Download",
                        "tingle-btn tingle-btn--primary",
                        async () => {
                            await wineManager.downloadWine(
                                value.downloadURL,
                                name,
                            );
                        },
                    );

                    modal.addFooterBtn(
                        `Cancel`,
                        "tingle-btn tingle-btn--danger",
                        () => {
                            modal.close();
                        },
                    );
                }
            } else {
                setPrimaryVersion.setContent(`
                <h2 class="modal-title">Set ${name} as primary Wine build?</h2>
                <div class="progress-bar" id="progress-bar">
                    <div id="progress-bar-progress"><p id="progress-bar-text">0%</p></div>
                </div>`);
                setPrimaryVersion.open();
                if (firstLoadSecondModal == 0) {
                    firstLoadSecondModal = 1;
                    setPrimaryVersion.addFooterBtn(
                        "Set",
                        "tingle-btn tingle-btn--primary",
                        async () => {
                            await wineManager.setPrimaryWine(
                                name,
                                value,
                                isRelativePath,
                            );
                            setTimeout(() => {
                                setPrimaryVersion.close();
                            }, 500);
                        },
                    );

                    setPrimaryVersion.addFooterBtn(
                        `Cancel`,
                        "tingle-btn tingle-btn--danger",
                        () => {
                            setPrimaryVersion.close();
                        },
                    );
                }
            }
        });
    }
}

function updateWineProgressBar(totalDownloaded: number, total: number) {
    const progressBarProgress = document.getElementById(
        "progress-bar-progress",
    ) as HTMLDivElement;
    const progressBarText = document.getElementById(
        "progress-bar-text",
    ) as HTMLDivElement;
    const percentage = Math.round((totalDownloaded / total) * 100);

    progressBarProgress.style.width = percentage + "%";
    progressBarText.textContent = percentage + "%";
}

function finalizeWineProgressBar() {
    const progressBarProgress = document.getElementById(
        "progress-bar-progress",
    ) as HTMLDivElement;
    progressBarProgress.style.width = "100%";
    progressBarProgress.textContent = "Unzipping...";
}

function wineDownloadComplete() {
    modal.close();
}

function resetWineProgressbar() {
    const progressBarProgress = document.getElementById(
        "progress-bar-progress",
    ) as HTMLDivElement;
    progressBarProgress.style.width = "0%";
}

let funcs = {
    updateWineProgressBar,
    finalizeWineProgressBar,
    wineDownloadComplete,
    resetWineProgressbar,
};

export default funcs;

wineListIterator();
