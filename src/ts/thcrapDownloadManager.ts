import { thcrapDownloader } from "./thcrap";
const branchList = document.getElementById("thcrap__branch-list-items")!
const selectedItem = document.getElementById("thcrap__branch-list-selected")!
const thcrap = new thcrapDownloader();
const json = await thcrap.getBranchInfo();
const url = thcrap.getPath();
delete json["version-resolve-fix"];

const branchMap = new Map<string, string>();

Object.keys(json).forEach((branch) => {
    const branchName = branch.charAt(0).toUpperCase() + branch.slice(1);
    const option = document.createElement("div");
    option.textContent = branchName;
    branchMap.set(branch, url + json[branch].latest);
    branchList.appendChild(option);
    option.addEventListener("click", () => {
        selectedItem.textContent = branchName;
        collapseInput(branchList, option);
    });
});

selectedItem.textContent = branchList.children[0].textContent;

selectedItem.addEventListener("click", () => {
    collapseInput(branchList, branchList.children[0]);
})

function collapseInput(element: HTMLElement, branchItem?: Element) {
    //  Calculate the height of the branch item, multiply by the number of items in the list. Default height is 48px in case something goes wrong.
    const branchItemHeight = branchItem ? branchItem.clientHeight * element.children.length : 48;
    element.style.height = element.style.height === "0px" ? `${branchItemHeight}px` : "0px";
}

