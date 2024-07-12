#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

// Prototipo de la función para restaurar el modo de ventana normal
void RestoreWindow();

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"totem", origin, size)) {
    return EXIT_FAILURE;
  }
  
  // Set the window style to no border and fullscreen
  HWND hwnd = window.GetHandle();
  LONG style = GetWindowLong(hwnd, GWL_STYLE);
  style &= ~(WS_OVERLAPPEDWINDOW);
  style |= WS_POPUP;
  SetWindowLong(hwnd, GWL_STYLE, style);
  
  // Get the monitor info and set the window to fullscreen
  MONITORINFO mi = { sizeof(mi) };
  if (GetMonitorInfo(MonitorFromWindow(hwnd, MONITOR_DEFAULTTOPRIMARY), &mi)) {
    SetWindowPos(hwnd, HWND_TOP,
                 mi.rcMonitor.left, mi.rcMonitor.top,
                 mi.rcMonitor.right - mi.rcMonitor.left,
                 mi.rcMonitor.bottom - mi.rcMonitor.top,
                 SWP_FRAMECHANGED | SWP_NOACTIVATE);
  }
  
  ShowWindow(hwnd, SW_MAXIMIZE);

  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  // Restore the window mode before exiting
  RestoreWindow();

  ::CoUninitialize();
  return EXIT_SUCCESS;
}

void RestoreWindow() {
  HWND hwnd = GetActiveWindow();
  if (hwnd) {
    LONG style = GetWindowLong(hwnd, GWL_STYLE);
    style &= ~WS_POPUP;
    style |= WS_OVERLAPPEDWINDOW;
    SetWindowLong(hwnd, GWL_STYLE, style);

    SetWindowPos(hwnd, NULL,
                 0, 0, 1280, 720,
                 SWP_NOMOVE | SWP_NOZORDER | SWP_FRAMECHANGED);
  }
}
