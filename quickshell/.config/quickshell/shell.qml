import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: root

  FileView {
    id: themeFile
    path: Qt.resolvedUrl("/home/aether/.config/themes/current/colors.json")
    blockLoading: true
  }

  // theme
  property var theme: JSON.parse(themeFile.text())
  property string fontFamily: "JetBrainsMono Nerd Font"
  property int fontSize: 18

  property int cpuUsage: 0
  property int lastCpuIdle: 0
  property int lastCpuTotal: 0
  property int memUsage: 0

  Process {
    id: cpuProc
    command: ['sh', '-c', 'head -1 /proc/stat']

    stdout: SplitParser {
      onRead: data => {
        var p = data.trim().split(/\s+/)
        var idle = parseInt(p[4]) + parseInt(p[5])
        var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
        if (lastCpuTotal > 0) {
          cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
        }
        lastCpuTotal = total
        lastCpuIdle = idle
      }
    }

    Component.onCompleted: running = true
  }

  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        var parts = data.trim().split(/\s+/)
        var total = parseInt(parts[1]) || 1
        var used = parseInt(parts[2]) || 0
        memUsage = Math.round(100 * used / total)
      }
    }
    Component.onCompleted: running = true
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      cpuProc.running = true
      memProc.running = true
    }
  }

  anchors.top: true
  anchors.left: true
  anchors.right: true
  implicitHeight: 50
  color: "transparent"

  RowLayout {
    anchors.fill: parent
    anchors.margins: 8

    Rectangle {
      color: theme.bg_primary
      height: 40
      radius: 50

      Row {
        id: wsRow
        anchors.centerIn: parent

        Repeater {
          model: 5

          Rectangle {
              radius: 30
              width: 30
              height: 30

              HoverHandler { id: mouse }

              MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (index + 1))
              }

              property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
              property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

              color: mouse.hovered ? theme.accent_primary : "transparent"

              Behavior on color {
                ColorAnimation { duration: 100 }
              }

              Text {
                  anchors.centerIn: parent
                  text: isActive ? " " : index + 1
                  color: mouse.hovered ? theme.bg_primary : isActive ? theme.accent_primary : theme.fg_secondary
                  font { pixelSize: 18; bold: true }
              }
          }
        }
      }

      width: wsRow.width + 10
    }

    Item { Layout.fillWidth: true }

    Text {
      id: clock
      text: "   " + Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
      color: theme.fg_primary

      Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = "   " + Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
      }
    }

    Rectangle { width: 1; height: 16; color: theme.accent_secondary }

    Text {
      text: "  " + cpuUsage + "%"
      color: theme.accent_soft
      font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
    }

    Rectangle { width: 1; height: 16; color: theme.accent_secondary }

    Text {
      text: "  " + memUsage + "%"
      color: theme.accent_soft
      font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
    }
  }
}
