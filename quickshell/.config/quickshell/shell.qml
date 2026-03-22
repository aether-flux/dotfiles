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
    path: "/home/aether/.config/themes/current/colors.json"
    blockLoading: true
  }

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

  // Theme
  property var theme: JSON.parse(themeFile.text())
  property string fontFamily: "GeistMono Nerd Font"
  property int fontSize: 14

  anchors.top: true
  anchors.right: true
  anchors.bottom: true
  anchors.left: true

  color: "transparent"

  WlrLayershell.layer: WlrLayer.Bottom
  WlrLayershell.namespace: "qs-frame"
  WlrLayershell.exclusionMode: ExclusionMode.Ignore

  property int margin: 10
  property int corRad: 20
  property color frameColor: theme.fg_primary

  Item {
    anchors.fill: parent

    // TOP BAR 
    Rectangle {
      id: topbar
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      height: 50
      color: root.frameColor

      // BAR START
      Item {
        anchors.fill: parent
        anchors.margins: 8

        // LEFT SECTION
        Row {
          id: leftSection
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          spacing: 10

          Rectangle {
            id: wsContainer
            color: theme.bg_primary
            height: 40
            radius: 50

            property int itemWidth: 20
            property int spacing: 3
            property int activeWs: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1

            Connections {
              target: Hyprland
              function onFocusedWorkspaceChanged() {
                wsContainer.activeWs = Hyprland.focusedWorkspace?.id || 1
              }
            }

            Rectangle {
              id: activeIndicator
              width: wsContainer.itemWidth
              height: wsContainer.itemWidth
              radius: 30
              color: theme.accent_primary

              y: (parent.height - height) / 2
              x: {
                for (let i = 0; i < wsRepeater.count; i++) {
                  let item = wsRepeater.itemAt(i)
                  if (item && item.wsId === wsContainer.activeWs) {
                    return item.x + 8
                  }
                }
                return 0
              }

              Behavior on x {
                NumberAnimation {
                  duration: 200
                  easing.type: Easing.InOutCubic
                }
              }
            }

            Row {
              id: wsRow
              anchors.centerIn: parent

              Repeater {
                id: wsRepeater
                model: 5

                Rectangle {
                  id: wsItem
                  radius: 30
                  width: wsContainer.itemWidth
                  height: wsContainer.itemWidth
                  color: "transparent"

                  property int wsId: index + 1

                  HoverHandler { id: wsHover }

                  MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                  }

                  property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                  property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                  opacity: wsHover.hovered ? 0.5 : 1

                  Behavior on color {
                    ColorAnimation { duration: 100 }
                  }

                  Text {
                    anchors.centerIn: parent
                    text: index + 1
                    color: {
                      let active = Hyprland.focusedWorkspace?.id === (index + 1)
                      return active ? theme.bg_primary : theme.fg_secondary
                    }
                    font { pixelSize: 18; family: root.fontFamily; bold: true }
                  }
                }
              }
            }

            width: wsRow.width + 15
          }

          Rectangle {
            color: theme.bg_primary
            // width: activeWinHover.hovered ? activeWindowTitle.width + 30 : activeWindowTitle.width + 10
            width: activeWindowTitle.width + 10
            height: 40
            radius: 40

            HoverHandler { id: activeWinHover }

            Behavior on width {
              NumberAnimation { duration: 150; easing.type: Easing.InOutCubic }
            }

            Text {
              id: activeWindowTitle
              anchors.centerIn: parent
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.margins: 20

              text: {  
                const activeWindow = ToplevelManager.activeToplevel;  
                  
                if (activeWindow?.activated) {  
                    let t = activeWindow.appId;
                    return "󰹑  " + t.charAt(0).toUpperCase() + t.slice(1);
                }  
                return "󰹑";
              }
              color: theme.fg_primary
              font { family: root.fontFamily; pixelSize: root.fontSize }

              leftPadding: 10
              rightPadding: 10

              elide: Text.ElideRight
              maximumLineCount: 1
            }
          }
        }

        // CENTER SECTION
        Row {
          id: centerSection
          anchors.centerIn: parent

          Rectangle {
            color: theme.bg_primary
            // width: clockHover.hovered ? clock.width + 30 : clock.width + 10
            width: clock.width + 10
            height: 40
            radius: 40

            HoverHandler { id: clockHover }

            Behavior on width {
              NumberAnimation { duration: 150; easing.type: Easing.InOutCubic }
            }

            Text {
              id: clock
              text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
              color: theme.fg_primary
              font.family: root.fontFamily
              font.pixelSize: root.fontSize

              anchors.centerIn: parent

              leftPadding: 10
              rightPadding: 10

              Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
              }
            }
          }
        }

        // RIGHT SECTION
        Row {
          id: rightSection
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: 10

          Rectangle {
            color: theme.bg_primary
            height: 40
            radius: 40

            HoverHandler {
              id: cpuHover
            }

            Behavior on width {
              NumberAnimation {
                duration: 100
                easing.type: Easing.InOutCubic
              }
            }

            Text {
              id: cpuText
              anchors.centerIn: parent

              text: cpuHover.hovered ? "  " + cpuUsage + "%" : ""
              color: cpuHover.hovered ? theme.accent_primary : theme.accent_soft
              font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }

              leftPadding: 5
              rightPadding: 5
            }

            width: cpuText.width + 10
          }

          Rectangle {
            color: theme.bg_primary
            height: 40
            radius: 40

            HoverHandler {
              id: memHover
            }

            Behavior on width {
              NumberAnimation {
                duration: 200
                easing.type: Easing.InOutCubic
              }
            }

            Text {
              id: memText
              anchors.centerIn: parent

              text: memHover.hovered ? "  " + memUsage + "%" : ""
              color: memHover.hovered ? theme.accent_primary : theme.accent_soft
              font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }

              leftPadding: 5
              rightPadding: 5
            }

            width: memText.width + 10
          }
        }
      }
    }

    // BOTTOM BAR 
    Rectangle {
      id: botbar
      anchors.bottom: parent.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      height: root.margin
      color: root.frameColor
    }

    // LEFT BAR
    Rectangle {
      id: leftbar
      anchors.top: topbar.bottom
      anchors.bottom: botbar.top
      // anchors.bottomMargin: root.margin
      anchors.left: parent.left
      width: root.margin
      color: root.frameColor
    }

    // RIGHT BAR
    Rectangle {
      id: rightbar
      anchors.top: topbar.bottom
      anchors.bottom: botbar.top
      // anchors.bottomMargin: root.margin
      anchors.right: parent.right
      width: root.margin
      color: root.frameColor
    }

    Canvas {
      anchors.fill: parent
      
      // Re-paint if frameColor changes (theme switch etc.)
      property color fc: root.frameColor
      onFcChanged: requestPaint()
      
      onPaint: {
        var ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        var r = root.corRad
        var m = root.margin
        var mt = topbar.height
        var W = width
        var H = height

        ctx.fillStyle = Qt.rgba(root.frameColor.r, root.frameColor.g, root.frameColor.b, root.frameColor.a)

        // TOP-LEFT
        ctx.beginPath()
        ctx.moveTo(m, mt)
        ctx.lineTo(m + r, mt)
        ctx.arcTo(m, mt, m, mt + r, r)
        ctx.lineTo(m, mt)
        ctx.closePath()
        ctx.fill()

        // TOP-RIGHT
        ctx.beginPath()
        ctx.moveTo(W - m, mt)
        ctx.lineTo(W - m - r, mt)
        ctx.arcTo(W - m, mt, W - m, mt + r, r)
        ctx.lineTo(W - m, mt)
        ctx.closePath()
        ctx.fill()

        // BOTTOM-LEFT
        ctx.beginPath()
        ctx.moveTo(m, H - m)
        ctx.lineTo(m + r, H - m)
        ctx.arcTo(m, H - m, m, H - m - r, r)
        ctx.lineTo(m, H - m)
        ctx.closePath()
        ctx.fill()

        // BOTTOM-RIGHT
        ctx.beginPath()
        ctx.moveTo(W - m, H - m)
        ctx.lineTo(W - m - r, H - m)
        ctx.arcTo(W - m, H - m, W - m, H - m - r, r)
        ctx.lineTo(W - m, H - m)
        ctx.closePath()
        ctx.fill()
      }
    }

    // Inner rounded border
    // Rectangle {
    //   anchors.fill: parent
    //   anchors.margins: root.margin - 1
    //   color: "transparent"
    //   radius: root.corRad
    //   border.color: theme.border_active_primary
    //   border.width: 2
    // }
  }
}
