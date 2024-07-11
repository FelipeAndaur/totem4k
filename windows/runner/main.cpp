#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>
#include <iostream>
#include <string>

#include "flutter_window.h"
#include "utils.h"

// Función para bloquear combinaciones de teclas
LRESULT CALLBACK LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam) {
  if (nCode == HC_ACTION) {
    KBDLLHOOKSTRUCT *p = (KBDLLHOOKSTRUCT *)lParam;
    if ((wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN) &&
        (p->vkCode == VK_TAB && GetAsyncKeyState(VK_MENU) < 0 || // Alt+Tab
         p->vkCode == VK_ESCAPE && GetAsyncKeyState(VK_CONTROL) < 0 || // Ctrl+Esc
         p->vkCode == VK_LWIN || p->vkCode == VK_RWIN)) { // Win key
      return 1; // Bloquear la entrada
    }
  }
  return CallNextHookEx(NULL, nCode, wParam, lParam);
}

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

  // Instalar hook de teclado para bloquear combinaciones de teclas
  HHOOK keyboardHook = SetWindowsHookEx(WH_KEYBOARD_LL, LowLevelKeyboardProc, instance, 0);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN));
  if (!window.Create(L"totem4k", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  // Mantener la ventana siempre en la parte superior
  SetWindowPos(window.GetHandle(), HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    if (msg.message == WM_CLOSE) {
      // Restore the window before closing
      window.RestoreWindowControls();
      PostQuitMessage(0);
    }
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  // Desinstalar hook de teclado antes de salir
  UnhookWindowsHookEx(keyboardHook);

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
