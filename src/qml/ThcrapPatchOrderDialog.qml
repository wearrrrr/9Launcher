import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC
import QtQuick.Controls.Material
import FileIO 1.0
import Downloader 1.0

import MMaterial as MMaterial
import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media
import MMaterial.Controls.Dialogs

Dialog {
    id: control

    property var gameItem: ({})
    property string appDataPath: StandardPaths.writableLocation(StandardPaths.AppDataLocation)
    property var selectedPatches: []
    property var orderedPatches: []
    property var patchMetadata: ({})
    property int downloadsPending: 0
    property bool downloadInProgress: false

    Downloader {
        id: downloader
        
        onDownloadFinished: {
            downloadsPending--
            if (downloadsPending === 0 && downloadInProgress) {
                downloadInProgress = false
                saveConfigFile()
            }
        }
        
        onDownloadFailed: {
            console.log("Download failed:", errorString)
            downloadsPending--
            if (downloadsPending === 0 && downloadInProgress) {
                downloadInProgress = false
                saveConfigFile()
            }
        }
    }

    title: qsTr("Configure Patch Order -") + " " + gameItem.en_title
    width: parent.width > 700 ? 700 * UI.Size.scale : parent.width * 0.9
    height: parent.height > 600 ? 600 * UI.Size.scale : parent.height * 0.9
    anchors.centerIn: parent
    modal: true

    FileIO {
        id: fileIO
    }

    onOpened: {
        loadPatchOrder()
    }

    function loadPatchOrder() {
        orderedPatches = []
        
        for (let i = 0; i < selectedPatches.length; i++) {
            const patch = selectedPatches[i]

            if (!patch.patchId || !patch.repoUrl) {
                continue
            }
            
            let repoId = patch.repoId || ""
            if (!repoId) {
                const urlWithoutProtocol = patch.repoUrl.replace(/https?:\/\//, '')
                const pathParts = urlWithoutProtocol.split('/').filter(s => s.length > 0)
                
                if (urlWithoutProtocol.includes('thpatch.net') && pathParts.length <= 1) {
                    repoId = "thpatch"
                } else {
                    repoId = pathParts[pathParts.length - 1]
                }
            }
            
            orderedPatches.push({
                patchId: patch.patchId,
                repoUrl: patch.repoUrl,
                repoId: repoId,
                isAutoDependency: patch.isAutoDependency || false,
                dependencies: []
            })
        }
        
        updatePatchList()
    }

    function sortByDependencies() {
        const graph = {}
        const inDegree = {}

        for (let i = 0; i < orderedPatches.length; i++) {
            const patch = orderedPatches[i]
            graph[patch.key] = []
            inDegree[patch.key] = 0
        }
        
        for (let i = 0; i < orderedPatches.length; i++) {
            const patch = orderedPatches[i]
            if (patch.dependencies && patch.dependencies.length > 0) {
                for (let j = 0; j < patch.dependencies.length; j++) {
                    const dep = patch.dependencies[j]
                    for (let k = 0; k < orderedPatches.length; k++) {
                        const otherPatch = orderedPatches[k]
                        if (matchesDependency(otherPatch, dep)) {
                            if (!graph[otherPatch.key]) {
                                graph[otherPatch.key] = []
                            }
                            graph[otherPatch.key].push(patch.key)
                            inDegree[patch.key]++
                            break
                        }
                    }
                }
            }
        }
        
        const queue = []
        const sorted = []
        
        for (let key in inDegree) {
            if (inDegree[key] === 0) {
                queue.push(key)
            }
        }
        
        while (queue.length > 0) {
            const current = queue.shift()
            sorted.push(current)
            
            if (graph[current]) {
                for (let i = 0; i < graph[current].length; i++) {
                    const neighbor = graph[current][i]
                    inDegree[neighbor]--
                    if (inDegree[neighbor] === 0) {
                        queue.push(neighbor)
                    }
                }
            }
        }
        
        const newOrder = []
        for (let i = 0; i < sorted.length; i++) {
            for (let j = 0; j < orderedPatches.length; j++) {
                if (orderedPatches[j].key === sorted[i]) {
                    newOrder.push(orderedPatches[j])
                    break
                }
            }
        }
        orderedPatches = newOrder
    }

    function matchesDependency(patch, dependency) {
        if (dependency.indexOf("/") > -1) {
            const parts = dependency.split("/")
            const depRepo = parts[0]
            const depId = parts[1]
            return patch.patchId === depId && patch.repoUrl.includes(depRepo)
        } else {
            return patch.patchId === dependency
        }
    }
    function updatePatchList() {
        patchListModel.clear()
        for (let i = 0; i < orderedPatches.length; i++) {
            const patch = orderedPatches[i]
            patchListModel.append({
                patchKey: patch.repoId + "/" + patch.patchId,
                patchId: patch.patchId,
                repoUrl: patch.repoUrl,
                index: i
            })
        }
    }

    function moveUp(index) {
        if (index > 0) {
            const temp = orderedPatches[index]
            orderedPatches[index] = orderedPatches[index - 1]
            orderedPatches[index - 1] = temp
            orderedPatches = orderedPatches.slice()
            updatePatchList()
        }
    }

    function moveDown(index) {
        if (index < orderedPatches.length - 1) {
            const temp = orderedPatches[index]
            orderedPatches[index] = orderedPatches[index + 1]
            orderedPatches[index + 1] = temp
            orderedPatches = orderedPatches.slice()
            updatePatchList()
        }
    }

    function generateConfig() {
        const patches = []
        for (let i = 0; i < orderedPatches.length; i++) {
            const patch = orderedPatches[i]
            
            // Extract repo path from URL
            // URL format: https://srv.thpatch.net -> repos/thpatch/<patch>/
            // URL format: https://mirrors.thpatch.net/nmlgc -> repos/nmlgc/<patch>/
            let repoPath = ""
            const urlWithoutProtocol = patch.repoUrl.replace(/https?:\/\//, '')
            const pathParts = urlWithoutProtocol.split('/').filter(s => s.length > 0)
            
            if (urlWithoutProtocol.includes('thpatch.net') && pathParts.length <= 1) {
                repoPath = "thpatch"
            } else {
                repoPath = pathParts[pathParts.length - 1]
            }
            
            patches.push({
                "archive": "repos/" + repoPath + "/" + patch.patchId + "/"
            })
        }
        
        const config = {
            "patches": patches
        }
        
        return JSON.stringify(config, null, 2)
    }

    function downloadPatchFiles() {
        downloadsPending = 0
        downloadInProgress = true
        
        for (let i = 0; i < orderedPatches.length; i++) {
            const patch = orderedPatches[i]

            const repoPath = patch.repoId

            let baseUrl = patch.repoUrl
            if (!baseUrl.startsWith("http://") && !baseUrl.startsWith("https://")) {
                baseUrl = "https://" + baseUrl
            }
            
            const localRepoPath = appDataPath + "/thcrap/repos/" + repoPath + "/" + patch.patchId + "/"
            const patchJsUrl = baseUrl + "/" + patch.patchId + "/patch.js"
            const filesJsUrl = baseUrl + "/" + patch.patchId + "/files.js"
            const versionsJsUrl = baseUrl + "/" + patch.patchId + "/versions.js"

            downloadsPending++
            downloader.download(patchJsUrl, localRepoPath + "patch.js", false, false)
            
            downloadsPending++
            downloader.download(filesJsUrl, localRepoPath + "files.js", false, false)
            
            // versions.js only exists on base patches
            if (patch.patchId === "base_tsa" || patch.patchId === "base_tasofro") {
                const versionsJsUrl = baseUrl + "/" + patch.patchId + "/versions.js"
                downloadsPending++
                downloader.download(versionsJsUrl, localRepoPath + "versions.js", false, false)
            }
        }
        
        if (downloadsPending === 0) {
            downloadInProgress = false
            saveConfigFile()
        }
    }

    function saveConfigFile() {
        const configJson = generateConfig()
        const gameId = gameItem.game_id || "default"
        const configPath = appDataPath + "/thcrap/config/" + gameId + ".js"
        
        try {
            fileIO.write(configPath, configJson)
            console.log("Saved thcrap config to:", configPath)
            control.close()
        } catch (e) {
            console.log("Failed to save config:", e)
        }
    }

    contentItem: ColumnLayout {
        spacing: UI.Size.pixel16

        Text {
            text: qsTr("Reorder patches (dependencies should come first)")
            color: Material.foreground
            font.pixelSize: UI.Size.pixel14
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
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

                    delegate: Rectangle {
                        width: patchListView.width
                        height: UI.Size.pixel64
                        color: "transparent"
                        border.color: Material.dividerColor
                        border.width: 1
                        radius: 4

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: UI.Size.pixel12
                            spacing: UI.Size.pixel12

                            Text {
                                text: (model.index + 1) + "."
                                color: Material.foreground
                                font.pixelSize: UI.Size.pixel14
                                font.bold: true
                                Layout.preferredWidth: UI.Size.pixel24
                                Layout.alignment: Qt.AlignVCenter
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                spacing: 4

                                Text {
                                    text: model.patchId
                                    color: Material.foreground
                                    font.pixelSize: UI.Size.pixel14
                                    font.bold: true
                                    elide: Text.ElideRight
                                    Layout.fillWidth: true
                                }

                                Text {
                                    text: model.repoUrl
                                    color: Material.secondaryTextColor
                                    font.pixelSize: UI.Size.pixel11
                                    elide: Text.ElideMiddle
                                    Layout.fillWidth: true
                                }
                            }

                            QQC.Button {
                                text: qsTr("↑")
                                flat: true
                                enabled: model.index > 0
                                onClicked: control.moveUp(model.index)
                                Layout.preferredWidth: UI.Size.pixel40
                                Layout.alignment: Qt.AlignVCenter
                            }

                            QQC.Button {
                                text: qsTr("↓")
                                flat: true
                                enabled: model.index < patchListModel.count - 1
                                onClicked: control.moveDown(model.index)
                                Layout.preferredWidth: UI.Size.pixel40
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }
                    }
                }
            }
        }

        Text {
            text: qsTr("Total patches: ") + orderedPatches.length
            color: Material.foreground
            font.pixelSize: UI.Size.pixel12
        }

        Text {
            visible: downloadInProgress
            text: qsTr("Downloading patch files... (%1 remaining)").arg(downloadsPending)
            color: Material.accentColor
            font.pixelSize: UI.Size.pixel12
        }
    }

    Dialog.DialogButton {
        text: qsTr("Save Configuration")
        enabled: !downloadInProgress
        onClicked: {
            downloadPatchFiles()
        }
    }

    Dialog.DialogCloseButton {
        text: qsTr("Cancel")
        enabled: !downloadInProgress
        onClicked: control.close()
    }
}
