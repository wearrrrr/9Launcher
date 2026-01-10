import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC
import QtQuick.Controls.Material
import FileIO 1.0
import Downloader

import MMaterial as MMaterial
import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media
import MMaterial.Controls.Dialogs

Dialog {
    id: control

    property var gameItem: ({})
    property string appDataPath: StandardPaths.writableLocation(StandardPaths.AppDataLocation)
    property var availablePatches: []
    property var selectedPatches: []
    property var downloadQueue: []
    property bool isDownloading: false
    property string searchText: ""
    property var processedRepos: []
    property var pendingDependencyCallbacks: []
    property var pendingNeighborCallbacks: []

    title: qsTr("Configure thcrap -") + " " + gameItem.en_title
    width: parent.width > 700 ? 700 * UI.Size.scale : parent.width * 0.9
    height: parent.height > 600 ? 600 * UI.Size.scale : parent.height * 0.9
    anchors.centerIn: parent
    modal: true

    ThcrapPatchOrderDialog {
        id: patchOrderDialog
        parent: control.parent
        gameItem: control.gameItem
        selectedPatches: control.selectedPatches
    }

    FileIO {
        id: fileIO
    }

    Downloader {
        id: downloader

        onDownloadFinished: {
            statusText.text = "Downloaded repository successfully"
            isDownloading = false
            statusText.text = "Main repository downloaded, discovering patches..."
            discoverPatches()
        }

        onDownloadFailed: function(errorString) {
            console.log("Download failed:", errorString)
            statusText.text = "Download failed: " + errorString
            isDownloading = false
        }

        onContentFetched: function(content) {
            if (pendingDependencyCallbacks.length > 0) {
                const callback = pendingDependencyCallbacks.shift()
                callback(content)
            } else if (pendingNeighborCallbacks.length > 0) {
                const callback = pendingNeighborCallbacks.shift()
                callback(content)
            }
        }
    }

    Component.onCompleted: {
        loadSelectedPatches()
    }

    function loadSelectedPatches() {
        const configPath = appDataPath + "/thcrap/selected_patches.json"
        if (fileIO.exists(configPath)) {
            try {
                const configData = JSON.parse(fileIO.read(configPath))
                let patches = configData.patches || []
                
                selectedPatches = []
                for (let i = 0; i < patches.length; i++) {
                    const patch = patches[i]
                    if (patch && typeof patch === "object") {
                        selectedPatches.push(patch)
                    }
                }
                saveSelectedPatches()
                selectedPatches = selectedPatches.slice()
            } catch (e) {
                console.log("Failed to parse selected patches:", e)
                selectedPatches = []
            }
        } else {
            selectedPatches = []
        }
    }

    function saveSelectedPatches() {
        const configPath = appDataPath + "/thcrap/selected_patches.json"
        const configData = {
            patches: selectedPatches
        }
        fileIO.write(configPath, JSON.stringify(configData, null, 2))
    }

    function discoverPatches() {
        statusText.text = "Discovering patches..."
        const repoPath = appDataPath + "/thcrap/repos/thpatch/repo.js"
        
        if (!fileIO.exists(repoPath)) {
            statusText.text = "Repository not found. Please download patches first."
            return
        }

        processedRepos = []

        try {
            const repoData = JSON.parse(fileIO.read(repoPath))
            let allPatches = []

            const mainRepoUrl = "https://srv.thpatch.net"
            const mainRepoId = repoData.id || "thpatch"
            
            processedRepos.push(mainRepoUrl)
            
            if (repoData.patches) {
                for (let patchId in repoData.patches) {
                    const patchInfo = repoData.patches[patchId]
                    allPatches.push({
                        id: patchId,
                        repo: mainRepoId,
                        repoId: mainRepoId,
                        repoUrl: mainRepoUrl,
                        title: (typeof patchInfo === "string") ? patchId : (patchInfo.title || patchId),
                        description: (typeof patchInfo === "string") ? patchInfo : (patchInfo.title || ""),
                        dependencies: (typeof patchInfo === "object" && patchInfo.dependencies) ? patchInfo.dependencies : []
                    })
                }
            }

            if (repoData.neighbors) {
                processNeighbors(repoData.neighbors, 0, allPatches)
            } else {
                availablePatches = allPatches
                updatePatchList()
                statusText.text = "Found " + allPatches.length + " patches"
            }
        } catch (e) {
            statusText.text = "Failed to parse repository: " + e
            console.log("Error:", e)
        }
    }

    function processNeighbors(neighbors, index, allPatches) {
        if (index >= neighbors.length) {
            availablePatches = allPatches
            updatePatchList()
            statusText.text = "Found " + allPatches.length + " patches from " + (neighbors.length + 1) + " repositories"
            return
        }

        const neighborUrl = neighbors[index]
        
        if (processedRepos.indexOf(neighborUrl) > -1) {
            processNeighbors(neighbors, index + 1, allPatches)
            return
        }
        
        const repoUrl = neighborUrl + "/repo.js"
        const urlParts = neighborUrl.split('/').filter(s => s.length > 0)
        const repoName = urlParts.length >= 2 ? urlParts[urlParts.length - 2] : (urlParts[urlParts.length - 1] || "unknown")

        statusText.text = "Processing neighbor " + (index + 1) + "/" + neighbors.length + ": " + repoName
        processedRepos.push(neighborUrl)
        
        pendingNeighborCallbacks.push(function(content) {
            try {
                const neighborData = JSON.parse(content)
                const repoDisplayName = neighborData.id || repoName
                
                if (neighborData.patches) {
                    for (let patchId in neighborData.patches) {
                        const patchInfo = neighborData.patches[patchId]
                        allPatches.push({
                            id: patchId,
                            repo: repoDisplayName,
                            repoId: neighborData.id || repoName,
                            repoUrl: neighborUrl,
                            title: (typeof patchInfo === "string") ? patchId : (patchInfo.title || patchId),
                            description: (typeof patchInfo === "string") ? patchInfo : (patchInfo.title || ""),
                            dependencies: (typeof patchInfo === "object" && patchInfo.dependencies) ? patchInfo.dependencies : []
                        })
                    }
                }
                if (neighborData.neighbors) {
                    for (let i = 0; i < neighborData.neighbors.length; i++) {
                        if (neighbors.indexOf(neighborData.neighbors[i]) === -1) {
                            neighbors.push(neighborData.neighbors[i])
                        }
                    }
                }
                processNeighbors(neighbors, index + 1, allPatches)
            } catch (e) {
                console.log("Failed to parse neighbor repo:", e)
                processNeighbors(neighbors, index + 1, allPatches)
            }
        })
        
        downloader.fetchContent(repoUrl)
    }

    function downloadPatches() {
        const repoUrl = "https://srv.thpatch.net/repo.js"
        const localPath = appDataPath + "/thcrap/repos/thpatch/repo.js"
        statusText.text = "Downloading thpatch repository..."
        isDownloading = true
        downloader.download(repoUrl, localPath, false, false)
    }

    function loadPatchDependencies(patchId, repoUrl, callback) {
        let fullRepoUrl = repoUrl
        if (!fullRepoUrl.startsWith("http://") && !fullRepoUrl.startsWith("https://")) {
            fullRepoUrl = "https://" + fullRepoUrl
        }
        
        const patchUrl = fullRepoUrl + "/" + patchId + "/patch.js"
        pendingDependencyCallbacks.push(function(content) {
            try {
                const patchData = JSON.parse(content)
                callback(patchData.dependencies || [])
            } catch (e) {
                console.log("Failed to parse patch.js for", patchId, ":", e)
                callback([])
            }
        })
        downloader.fetchContent(patchUrl)
    }

    function togglePatch(patchId, repoUrl, repoId) {
        let patchIndex = -1
        for (let i = 0; i < selectedPatches.length; i++) {
            if (selectedPatches[i].patchId === patchId && selectedPatches[i].repoUrl === repoUrl) {
                patchIndex = i
                break
            }
        }
        
        if (patchIndex > -1) {
            selectedPatches.splice(patchIndex, 1)
            selectedPatches = selectedPatches.slice()
            saveSelectedPatches()
            updatePatchList()
        } else {
            loadPatchDependencies(patchId, repoUrl, function(dependencies) {
                if (dependencies.length > 0) {
                    addDependencies(dependencies, repoUrl)
                }

                selectedPatches.push({patchId: patchId, repoUrl: repoUrl, repoId: repoId, isAutoDependency: false})
                selectedPatches = selectedPatches.slice()
                saveSelectedPatches()
                updatePatchList()
            })
        }
    }

    function addDependencies(dependencies, repoUrl) {
        for (let i = 0; i < dependencies.length; i++) {
            const dep = dependencies[i]
            let depRepo = ""
            let depId = dep
            
            if (dep.indexOf("/") > -1) {
                const parts = dep.split("/")
                depRepo = parts[0]
                depId = parts[1]
            }

            let foundPatch = null
            for (let j = 0; j < availablePatches.length; j++) {
                const patch = availablePatches[j]

                if (patch.id === depId) {
                    if (depRepo === "" || patch.repo === depRepo) {
                        foundPatch = patch
                        break
                    }
                }
            }
            
            if (!foundPatch) {
                console.log("Dependency not found:", dep, "(looking for repo:", depRepo, "patch:", depId + ")")
                continue
            }
            
            let alreadySelected = false
            for (let k = 0; k < selectedPatches.length; k++) {
                if (selectedPatches[k].patchId === foundPatch.id && selectedPatches[k].repoUrl === foundPatch.repoUrl) {
                    alreadySelected = true
                    break
                }
            }
        
            if (alreadySelected) {
                continue
            }
            
            let insertIndex = 0
            for (let k = 0; k < selectedPatches.length; k++) {
                if (!selectedPatches[k].isAutoDependency) {
                    insertIndex = k
                    break
                }
                insertIndex = k + 1
            }
            
            selectedPatches.splice(insertIndex, 0, {
                patchId: foundPatch.id,
                repoUrl: foundPatch.repoUrl,
                repoId: foundPatch.repoId,
                isAutoDependency: true
            })
            
            loadPatchDependencies(foundPatch.id, foundPatch.repoUrl, function(nestedDeps) {
                if (nestedDeps.length > 0) {
                    addDependencies(nestedDeps, foundPatch.repoUrl)
                }
            })
        }
    }

    function isPatchSelected(patchId, repoUrl) {
        for (let i = 0; i < selectedPatches.length; i++) {
            if (selectedPatches[i].patchId === patchId && selectedPatches[i].repoUrl === repoUrl) {
                return true
            }
        }
        return false
    }

    function matchesSearch(patchTitle, patchId, patchRepo) {
        if (searchText === "") {
            return true
        }
        const search = searchText.toLowerCase()
        return patchTitle.toLowerCase().includes(search) ||
               patchId.toLowerCase().includes(search) ||
               patchRepo.toLowerCase().includes(search)
    }

    function updatePatchList() {
        patchListModel.clear()
        
        if (searchText === "") {
            for (let i = 0; i < availablePatches.length; i++) {
                const patch = availablePatches[i]
                if (patch.id === "lang_en") {
                    patchListModel.append(patch)
                    break
                }
            }
        }
        
        for (let i = 0; i < availablePatches.length; i++) {
            const patch = availablePatches[i]
            if (searchText === "" && patch.id === "lang_en") {
                continue
            }
            if (matchesSearch(patch.title, patch.id, patch.repo)) {
                patchListModel.append(patch)
            }
        }
    }

    onSearchTextChanged: {
        updatePatchList()
    }

    contentItem: ColumnLayout {
        spacing: UI.Size.pixel16

        Text {
            id: statusText
            text: "Ready"
            color: Material.foreground
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
        }

        RowLayout {
            spacing: UI.Size.pixel8
            Layout.fillWidth: true

            QQC.Button {
                text: qsTr("Download Patches")
                onClicked: downloadPatches()
            }

            QQC.Button {
                text: qsTr("Refresh")
                onClicked: discoverPatches()
            }
        }

        Text {
            text: qsTr("Available Patches:")
            color: Material.foreground
            font.pixelSize: UI.Size.pixel16
        }

        QQC.TextField {
            id: searchField
            Layout.fillWidth: true
            Layout.preferredHeight: UI.Size.pixel32
            placeholderText: qsTr("Search patches...")
            onTextChanged: searchText = text
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Material.dialogColor
            border.color: Material.dividerColor
            border.width: 1
            radius: 4

            ScrollView {
                anchors.fill: parent
                anchors.margins: UI.Size.pixel8
                clip: true

                ListView {
                    id: patchListView
                    model: ListModel {
                        id: patchListModel
                    }
                    spacing: UI.Size.pixel4

                    delegate: Item {
                        id: delegateItem
                        width: patchListView.width
                        height: patchDelegate.implicitHeight + UI.Size.pixel16 + (expanded ? descriptionText.implicitHeight + UI.Size.pixel8 : 0)
                        
                        property bool expanded: false

                        Rectangle {
                            anchors.fill: parent
                            color: patchMouseArea.containsMouse ? Material.listHighlightColor : "transparent"
                            radius: 4

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: UI.Size.pixel8
                                spacing: 0

                                RowLayout {
                                    id: patchDelegate
                                    Layout.fillWidth: true
                                    spacing: UI.Size.pixel8

                                    QQC.CheckBox {
                                        id: patchCheckBox
                                        Layout.alignment: Qt.AlignTop
                                        checked: control.isPatchSelected(model.id, model.repoUrl)
                                        onClicked: control.togglePatch(model.id, model.repoUrl, model.repoId)
                                    }

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2

                                        Text {
                                            text: model.title
                                            color: Material.foreground
                                            font.pixelSize: UI.Size.pixel14
                                            font.bold: true
                                            wrapMode: Text.WordWrap
                                            Layout.fillWidth: true
                                        }

                                        Text {
                                            text: "(" + model.repo + ")"
                                            color: Material.secondaryTextColor
                                            font.pixelSize: UI.Size.pixel12
                                            wrapMode: Text.WordWrap
                                            Layout.fillWidth: true
                                        }
                                    }

                                    Text {
                                        id: expandArrow
                                        text: delegateItem.expanded ? "▼" : "▶"
                                        color: Material.foreground
                                        font.pixelSize: UI.Size.pixel12
                                        visible: model.description && model.description !== ""
                                        Layout.alignment: Qt.AlignVCenter
                                        Layout.rightMargin: UI.Size.pixel16
                                    }
                                }

                                Text {
                                    id: descriptionText
                                    text: model.description || ""
                                    color: Material.secondaryTextColor
                                    font.pixelSize: UI.Size.pixel12
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.topMargin: UI.Size.pixel8
                                    Layout.leftMargin: patchCheckBox.width + UI.Size.pixel8
                                    visible: delegateItem.expanded && model.description && model.description !== ""
                                }
                            }

                            MouseArea {
                                id: patchMouseArea
                                anchors.fill: parent
                                anchors.leftMargin: patchCheckBox.width + UI.Size.pixel8
                                hoverEnabled: true
                                onClicked: {
                                    if (model.description && model.description !== "") {
                                        delegateItem.expanded = !delegateItem.expanded
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Text {
            text: qsTr("Selected patches: ") + selectedPatches.length
            color: Material.foreground
            font.pixelSize: UI.Size.pixel12
        }
    }

    Dialog.DialogButton {
        text: qsTr("Deselect All")
        enabled: selectedPatches.length > 0
        onClicked: {
            selectedPatches = []
            saveSelectedPatches()
        }
    }

    Dialog.DialogButton {
        text: qsTr("Configure Patch Order")
        enabled: selectedPatches.length > 0
        onClicked: {
            patchOrderDialog.open()
        }
    }

    Dialog.DialogCloseButton {
        text: qsTr("Close")
        fontCapitalization: Font.MixedCase
        onClicked: control.close()
    }
}
